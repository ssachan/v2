<?php


/*
Functions for analytics

*/

abstract class testEvent {
    
    const OPTION_SELECT = 0;
    const OPTION_DESELECT = 1;
    const QUESTION_OPEN = 3;
    const QUESTION_CLOSE = 4;
    const QUESTION_MARK  = 5;
    const QUESTION_UNMARK = 6;
    const QUESTION_SUBMIT = 7;
    const TEST_SUBMIT = 8;
    const TEST_PAUSE = 9;
    const TEST_START = 10;


    public static $enums= array(

        self::OPTION_SELECT => "Option Selected",
        self::OPTION_DESELECT => "Option Deselected",
        self::QUESTION_OPEN => "Question Opened",
        self::QUESTION_CLOSE => "Question Closed",
        self::QUESTION_MARK => "Question Marked",
        self::QUESTION_UNMARK => "Question Unmarked",
        self::QUESTION_SUBMIT => "Question Submitted",
        self::TEST_SUBMIT => "Test Submitted",
        self::TEST_PAUSE => "Test Paused",
        self::TEST_START => "Test Started" 
    );
}

abstract class questionType {
    
    const SINGLE_CHOICE = 1;
    const MULTIPLE_CHOICE = 2;
    const INTEGER_TYPE = 3;
    const MATRIX_MATCH = 4;
}

abstract class analConst {
    const ABILITY_DEFAULT_SCORE = 50;
    const UNSEEN_TOLERANCE = 2000;
    const CORRECT = 1;
    const INCORRECT = 2;
    const SKIPPED = 3;
    const UNSEEN = 4;
    const ATTEMPTED_AS_TIMED_TEST = 1;
    const ATTEMPTED_AS_PRACTICE = 2;

    public static function timeFactor()
    {
        return 1;
    }

    public static function abilityFactor()
    {
        return 1;
    }    
}


//>> FRONT-FACING Functions
function testCode()
{
   
}

function updateResults()
{
    $accountId = $_POST['accountId']; 
    $quizId = $_POST['quizId'];
    $logs = $_POST['logs'];

    $temp = getStateOfQuiz($accountId,$quizId);
    $attemptedAs = $temp["attemptedAs"];
    //$state = intval($temp["state"]);
    $state = $_POST['state'];

    updateResultsTable($accountId,$quizId,$logs); //storing to database

    if($attemptedAs == analConst::ATTEMPTED_AS_TIMED_TEST)
    {
        updateResultsForTest($accountId,$quizId,$logs);
        //updating state in Results table is taken care of in function itself.
    }
    elseif($attemptedAs == analConst::ATTEMPTED_AS_PRACTICE)
    {
        updateResultsForPractice($accountId,$quizId,$logs);
        setStateOfQuiz($accountId,$quizId,$state);
    }
}

function updateResultsForPractice($accountId,$quizId,$logs)
{
    $attemptedAs = analConst::ATTEMPTED_AS_PRACTICE;
    $logsByQuestion = splitLogsByQuestion($logs);
    $qid = 0;
    foreach($logsByQuestion as $key => $value)
    {
        $qid = $key;
        $logsByQuestion = $value;
    }
    

    $optionArray = getFinalOptionArray($logsByQuestion);
    $optionText = getOptionTextFromArray($optionArray);
    $timeTaken = getTotalTime($logsByQuestion);

    $qDetails = getQuestionDetails($qid);
    $userAbility = getUserAbilityLevels($accountId, $qDetails->l3Id);
    
    //This might need to change for practice
    $result = evaluateQuestion($qDetails,$optionText, $timeTaken,$userAbility);
    $delta = $result[0];
    $state = $result[1];
    $delta = adjustDelta($qDetails,$userAbility,$timeTaken,$delta,$state,$attemptedAs);

    insertIntoResponsesTable($accountId, $qid, $optionText, $timeTaken,$userAbility->l3score,$delta,$state);
    updateScore($accountId, $delta, $userAbility,$state);

    $response["status"] = SUCCESS;
    $response["data"] = true;
    /*$response["data"] = array(
        "optionText"=>$optionText,
        "timeTaken "=>$timeTaken,
        "state"=>$state,
        "delta"=>$delta,
        "userAbilityRecord"=>$userAbility
        );*/
    sendResponse($response);
}

function updateResultsForTest($accountId,$quizId,$logs)
{
    $attemptedAs = analConst::ATTEMPTED_AS_TIMED_TEST;
    $response = array();
    //$streamId = $_POST['streamId']; // why is this required??
    
    /**************UNCOMMENT BELOW LATER*******************/

    $questionIds = getQuestionIdsForQuiz($quizId);
    $logsByQuestion = splitLogsByQuestion($logs);

    $optionArray = array();
    $optionText = array();
    $timeTaken = array(); //All 4 are per question arrays
    $state = array();
    $delta = array(); //default to 0?
    $userAbilityRecord = array();
    foreach ($questionIds as $key => $qid)
    {
       //Retrieve the final option selected and time taken
        if(isset($logsByQuestion[$qid]))
        {
            $optionArray[$qid] = getFinalOptionArray($logsByQuestion[$qid]);
            $optionText[$qid] = getOptionTextFromArray($optionArray[$qid]);
            $timeTaken[$qid] = getTotalTime($logsByQuestion[$qid]);
        }
        else
        {
            //not attempted at all
            $optionsArray[$qid] = array();
            $optionText[$qid] = "";
            $timeTaken[$qid] = 0;
            $state[$qid] = analConst::UNSEEN;
        }

        $qDetails = getQuestionDetails($qid);
        $userAbility = getUserAbilityLevels($accountId, $qDetails->l3Id);
        $result[$qid] = evaluateQuestion($qDetails,$optionText[$qid], $timeTaken[$qid],$userAbility);
        $delta[$qid] = $result[$qid][0]; $state[$qid] = $result[$qid][1];
        $delta[$qid] = adjustDelta($qDetails,$userAbility,$timeTaken[$qid],$delta[$qid],$state[$qid],$attemptedAs);
        $userAbilityRecord[$qid]=$userAbility;
        //$result[0] is $delta, $result[1] is state;
        // optimization tip:  unseen questions can be evaluated faster.

        //now adding question to response table;
        insertIntoResponsesTable($accountId, $qid, $optionText[$qid], $timeTaken[$qid],$userAbility->l3score,$delta[$qid],$state[$qid]);
        updateScore($accountId, $delta[$qid], $userAbility,$state[$qid]);
    }
    setStateOfQuiz($accountId,$quizId,count($questionIds));

    $videoArray = getVideoArray($accountId, $qDetails, $state, $delta);

    $response["status"] = SUCCESS;

    $response["data"] = array(
        "optionText"=>$optionText,
        "timeTaken "=>$timeTaken,
        "state"=>$state,
        "delta"=>$delta,
        "userAbilityRecord"=>$userAbilityRecord,
        "videoArray"=>$videoArray
        );
    

//extracode    
        $optionArray2 = array();
        $optionText2 = array();
        $timeTaken2 = array(); //All 4 are per question arrays
        $state2 = array();
        $delta2 = array(); //default to 0?
        $userAbilityRecord2 = array();
    foreach ($questionIds as $key => $qid)
    {
        $optionText2[] = $optionText[$qid];
        $timeTaken2[] = $timeTaken[$qid];
        $state2[] = $state[$qid];
        $delta2[] = $delta[$qid];
        $userAbilityRecord2[] = $userAbilityRecord[$qid];
    }
    $response["data"] = array(
        "selectedAnswers"=>json_encode($optionText2),
        "timePerQuestion"=>json_encode($timeTaken2),
        "state"=>$state2,
        "delta"=>$delta2,
        "userAbilityRecord"=>$userAbilityRecord2,
        "videoArray"=>$videoArray
        );    
    updateUserResponseinResultsTable($accountId, $quizId, $responses["data"]["selectedAnswers"], $responses["data"]["timePerQuestion"]);
    sendResponse($response);
}
//<< END FRONT FACING

//>> RETRIEVING, UPDATING SCORES AND ABILITY
function getUserAbilityLevels($accountId, $l3id)
{
    $sql = "SELECT l1.id 'l1', l2.id 'l2', l2.weightage 'l2w', l3.weightage 'l3w' FROM " .
           "section_l1 l1, section_l2 l2, section_l3 l3 WHERE l3.id=:l3id AND l3.l2id = l2.id AND l2.l1id = l1.id";
    $l1id = 0;
    $l2id = 0;
    $l2w = 0;
    $l3w = 0;
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("l3id", $l3id);
        $stmt->execute();
        $ids = $stmt->fetch(PDO::FETCH_OBJ);
        $l1id = $ids->l1;
        $l2id = $ids->l2;
        $l2w = $ids->l2w;
        $l3w = $ids->l3w;
        $db = null;

    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
    
    $score = new stdClass();
    $score->l1id = $l1id;
    $score->l2id = $l2id;
    $score->l3id = $l3id;
    $score->l1score = getAbilityScore("l1",$l1id,$accountId);
    $score->l2score = getAbilityScore("l2",$l2id,$accountId);
    $score->l3score = getAbilityScore("l3",$l3id,$accountId);
    $score->l2weightage = $l2w;
    $score->l3weightage = $l3w;

    return $score;
}

function getAbilityScore($level, $id, $accountId)
{
    $sql = "SELECT score FROM ascores_".$level." WHERE ".$level."id=:id AND accountId = :acid"; 
   try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->bindParam("acid", $accountId);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if($result === false)
            return abilityScoreNotFound($level,$id,$accountId);
        else
            return $result->score;

    } catch (PDOException $e) {
        //in case the ability score does not exist
        
        phpLog($e->getMessage());
    }
}

function abilityScoreNotFound($level,$id,$accountId)
{
    $date = date("Y-m-d H:i:s", time());
    $streamId = 1;
    $defaultScore = analConst::ABILITY_DEFAULT_SCORE;
     $sql = "INSERT INTO ascores_".$level." (accountId, score, updatedOn, ".$level."id, numQuestions, numCorrect, numIncorrect, numUnattempted, streamId) VALUES (:acid,:score,:timeStamp,:id,0,0,0,0,:streamId)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("acid", $accountId);
        $stmt->bindParam("id", $id);
        $stmt->bindParam("timeStamp", $date);
        $stmt->bindParam("streamId",$streamId);
        $stmt->bindParam("score", $defaultScore);
        $stmt->execute();
        $db = null;
        return analConst::ABILITY_DEFAULT_SCORE;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}

function updateScore($accountId, $delta, $userAbility, $state)
{
    //this function updates l1, l2, l3 based on delta
    updateAbility($accountId,"l3",$userAbility->l3id, $delta, $state);
    updateAbility($accountId,"l2",$userAbility->l2id, $delta*$userAbility->l3weightage, $state);
    updateAbility($accountId,"l1",$userAbility->l1id, $delta*$userAbility->l3weightage*$userAbility->l2weightage, $state);
    //l2 is weighted average of l3s, l1 is weighted average of l1s
}

function updateAbility($accountId,$level,$id,$delta,$state)
{
    $date = date("Y-m-d H:i:s", time());
    $switched = "numUnattempted = numUnattempted + 1,";
    switch($state)
    {
        case analConst::CORRECT:
            $switched = "numCorrect = numCorrect + 1,";
            break;
        case analConst::INCORRECT:
            $switched = "numIncorrect = numIncorrect + 1,";
            break;
    }
    $sql = "UPDATE ascores_".$level." SET numQuestions = numQuestions + 1,".$switched." score = score + :delta, updatedOn = :timeStamp WHERE accountId = :acid AND ".$level."id = :id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("acid", $accountId);
        $stmt->bindParam("id", $id);
        $stmt->bindParam("timeStamp", $date);
        $stmt->bindParam("delta", $delta);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}
//<< END RETRIEVING, UPDATING SCORES AND ABILITY

//>> QUIZ/QUESTION DETAIL RETRIEVERS
function getStateOfQuiz($accountId, $quizId)
{
    $sql = "SELECT state,attemptedAs from results where accountId=:accountId and quizId=:quizId";
    $previousState = null;
    $attemptedAs = null;
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $previousState = $record->state;
        $attemptedAs = $record->attemptedAs;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
    return array("state"=>$previousState,"attemptedAs"=>$attemptedAs);
 // Code to get state and attempted as if needed.
}

function setStateOfQuiz($accountId, $quizId, $state)
{
    $sql = "UPDATE results SET state=:state where accountId=:accountId and quizId=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("state", $state);
        $stmt->execute();
        $db=null;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

function getQuestionDetails($qid)
{
    $sql = "SELECT * FROM questions WHERE id=:qid";
    $l1id = 0;
    $l2id = 0;
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("qid", $qid);
        $stmt->execute();
        $results = $stmt->fetch(PDO::FETCH_OBJ);        
        $db = null;
        return $results;

    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}
//<< END QUIZ/QUESTION DETAIL RETRIEVERS

//>> FUNCTIONS THAT OPERATE ON RAW LOGS
function splitLogsByQuestion($logData)
{
    $questionDataSet = array();
    foreach ($logData as $key => $value)
        if(isset($value['q']))
            $questionDataSet[$value['q']][]=$value;
    return $questionDataSet;
}

function updateResultsTable($accountId, $quizId, $logs)
{
    $date = date("Y-m-d H:i:s", time());  // tanujb:TODO: arbitrary?????

    $sql = "UPDATE results SET timestamp=:timeStamp, data=:data where accountId=:accountId and quizId=:quizId";
    try {
        $logsJSON = json_encode($logs);
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("timeStamp", $date);
        $stmt->bindParam("data", $logsJSON);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}

function updateUserResponseinResultsTable($accountId, $quizId, $selectedAnswers, $timePerQuestion)
{
    $date = date("Y-m-d H:i:s", time());  // tanujb:TODO: arbitrary?????

    $sql = "UPDATE results SET selectedAnswers = :selectedAnswers, timePerQuestion = :timePerQuestion where accountId=:accountId and quizId=:quizId";
    try {
        $logsJSON = json_encode($logs);
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("timePerQuestion", $timePerQuestion);
        $stmt->bindParam("selectedAnswers", $selectedAnswers);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}

function insertIntoResponsesTable($accountId, $qid, $optionText, $timeTaken,$abilityScore,$delta,$state)
{
    $date = date("Y-m-d H:i:s", time());

    $sql = "INSERT INTO responses (accountId,questionID, optionSelected, timeTaken, abilityScoreBefore, delta, status, timestamp) VALUES (:accountId,:qid,:otxt,:ttk,:ascore,:delta,:sts,:tstmp)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("qid", $qid);
        $stmt->bindParam("tstmp", $date);
        $stmt->bindParam("otxt", $optionText);
        $stmt->bindParam("ttk", $timeTaken);
        $stmt->bindParam("ascore", $abilityScore);
        $stmt->bindParam("delta", $delta);
        $stmt->bindParam("sts", $state);
        
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}
//<< END FUNCTIONS THAT OPERATE ON RAW LOGS

//>> FUNCTIONS THAT OPERATE ON LOGS PERTAINING TO A SINGLE QUESTION
function getTotalTime($questionData) //Can be optimized by combining these into one large loop.
{
    $totalTime = 0;
    $prevTimeStamp = 0;

    foreach ($questionData as $key => $value)
    {
        if($value['e']==testEvent::QUESTION_OPEN)
        {
             $prevTimeStamp = $value['t'];
        }
        elseif($value['e']==testEvent::QUESTION_CLOSE)
        {
             $totalTime += $value['t']-$prevTimeStamp;
        }
    }

    return $totalTime;
}

function getFinalOptionArray($questionData)
{
    $optionsArray = array();

    foreach ($questionData as $key => $value)
    {
        if($value['e']==testEvent::OPTION_SELECT)
        {
               $optionsArray[$value['o']] = true;
        }
        elseif($value['e']==testEvent::OPTION_DESELECT)
        {
                $optionsArray[$value['o']] = false;   
        }
    }

    return $optionsArray;
}
//<< END FUNCTIONS THAT OPERATE ON LOGS PERTAINING TO A SINGLE QUESTION

//>> HELPER FUNCTIONS

function getQuestionIdsForQuiz($quizId)
{
    $questionIds = "";
    $sql = "SELECT questionIds FROM quizzes WHERE id=:id ";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $quizId);
        $stmt->execute();
        $questionIds = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        return explode("|:",$questionIds->questionIds);

    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

function getOptionTextFromArray($optionsArray)
{
    $optionText = array();
    foreach ($optionsArray as $key => $value)
        if($value)
            $optionText[]=$key;

    $optionText = implode("|:",$optionText);
    return $optionText;
}

function getOptionArrayFromText($optionText, $optionLength)
{
    $answer = array();
    if(strpos($optionText,"|:|:") !== false)
    {
        //matrix type
        $optionText = explode("|:|:",$optionText);
        foreach ($optionText as $key => $value) {
            $temp = $optionText[$key];
            $answer[]=getOptionArrayFromText($temp,$optionLength);
        }
    }
    else{
        $optionText = explode("|:",$optionText);
        for($i=0;$i<$optionLength;$i++)
            $answer[$i] = false;
        foreach ($optionText as $key => $value)
            $answer[$value] = true;
    }
    return $answer;
}
//<< END HELPER FUNCTIONS

//>> QUESTION EVALUATION functions
function evaluateQuestion($qDetails, $optionText, $timeTaken, $userAbility)
{

    //Code here to calculate scores based on certain factors.
    //First check if attempted or not
    $result = array();
    $delta =0;
    $state = "";
    if($optionText == "")
    {
        //unattempted
        //If not attempted see if any time was spent on the question
        if($timeTaken <= analConst::UNSEEN_TOLERANCE)
        {
            //question went unseen. Code that way
            $delta = evalUnseen($qDetails,$userAbility);
            $state = analConst::UNSEEN;
        }
        else
        {
            //seen but skipped in $timeTaken seconds
            $delta = evalSkip($qDetails,$userAbility,$timeTaken);
            $state = analConst::SKIPPED;
        }
    }
    else
    {
        //If attempted, check if each option is in the state it is supposed to be
        if($optionText == $qDetails->correctAnswer)
        {
            //everything correct exactly
            $delta = evalCorrect($qDetails,$userAbility,$timeTaken);
            $state = analConst::CORRECT;
        }
        else
        {
            switch($qDetails->typeId)
            {
                case questionType::SINGLE_CHOICE:
                    $delta = evalIncorrect($qDetails,$userAbility,$timeTaken);
                    break;
                case questionType::MULTIPLE_CHOICE:
                    $optionLength = count(explode("|:",$qDetails->options));
                    $delta = evalOption($optionText,
                                        $qDetails->correctAnswer,
                                        $optionLength,
                                        $qDetails->correctScore,
                                        $qDetails->inCorrectScore);
                    break;
                case questionType::MATRIX_MATCH:
                    
                    $tmpOption = explode("|:|:",$qDetails->options);
                    $optionLength = count(explode("|:",$tmpOption[0]));

                    $optionSuperArray =  getOptionArrayFromText($optionText,$optionLength);
                    $correctSuperArray = getOptionArrayFromText($qDetails->correctAnswer,$optionLength);
                    
                    $delta = 0;
                    foreach ($correctSuperArray as $k => $v) {
                        $tmpCorrectText = $v;
                        $tmpOptionText = $optionSuperArray[$k];
                        $delta += evalOption($tmpCorrectText,
                                        $tmpOptionText,
                                        $optionLength,
                                        $qDetails->correctScore,
                                        $qDetails->inCorrectScore);
                    }
                    break;
                case questionType::INTEGER_TYPE:
                    $delta = evalIncorrect($qDetails,$userAbility,$timeTaken);
                    break;
            }
            $state = analConst::INCORRECT;
        }
            
    }

    return array($delta,$state);
}

function evalOption($optionText,$correctAnswerText, $optionLength, $correctScore, $incorrectScore)
{
    $optionsArray = getOptionArrayFromText($optionText,$optionLength);
    $correctArray = getOptionArrayFromText($correctAnswerText,$optionLength);
    $delta = 0;
    foreach ($correctArray as $key => $value) {
        if($optionsArray[$key] == $correctArray[$key])
            $delta += $correctScore; // add factor
        else
            $delta += $incorrectScore; //add factor
    }
    return $delta;
}

function evalUnseen($qDetails,$userAbility)
{
    $delta = $qDetails->unattemptedScore; //add factor
    return $delta;
}

function evalSkip($qDetails,$userAbility,$timeTaken)
{
    $delta = $qDetails->unattemptedScore; //add factor
    return $delta;
}

function evalCorrect($qDetails,$userAbility,$timeTaken)
{
    $delta = $qDetails->correctScore; //add factor
    return $delta;
}

function evalIncorrect($qDetails,$userAbility,$timeTaken)
{
    $delta = $delta = $qDetails->incorrectScore; //add factor
    return $delta;
}
function adjustDelta($qDetails,$userAbility,$timeTaken,$delta,$state,$attemptedAs)
{
    if($attemptedAs = analConst::ATTEMPTED_AS_PRACTICE)
    {
        $delta *= 0.5; 
    }
    return $delta;
}

function returnQuestionData()
{
    $accountId = $_POST['accountId']; 
    $qid = $_POST['qid'];
    $sql = "select optionSelected as o, timeTaken as t, abilityScoreBefore as a, delta as d, MAX(timeStamp) as m from responses where accountId :acid AND questionId = :qid GROUP BY questionId";

    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("acid", $accountId);
        $stmt->bindParam("qid", $qid);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
    $response["status"] = SUCCESS;
    $response["data"] = $record;
    sendResponse($response);
}
//<< QUESTION EVALAUATION FUNCTIONS END

function getVideoArray($accountId, $qDetails, $state, $delta)
{
    $videoArray = array();
    asort($delta);
    $count = 0;
    foreach ($delta as $key => $value) {
        $videoObject = new stdClass();
         
            $videoObject->videoSrc = $qDetails[$key]->videoSrc;
            $videoObject->posterSrc = $qDetails[$key]->posterSrc;
        $videoArray[] = $videoObject;
        $count += 1;
        if($count == 5 || $value > 0)
            break;
    }
    return $videoArray;
}

