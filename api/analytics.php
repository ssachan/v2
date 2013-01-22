<?php

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

class lscoreDataObject{
    public $lId;
    public $lType;
    public $numQ;
    public $numCorrect;
    public $numIncorrect;
    public $numUnattempted;
    public $scoreBefore;
    public $delta;

    function __construct($level, $lid, $lscore)
    {
        $this->lId = $lid;
        $this->lType = $level;
        $this->scoreBefore = $lscore;
        $this->numQ = 0;
        $this->numCorrect = 0;
        $this->numIncorrect = 0;
        $this->numUnattempted = 0;
        $this->delta = 0;
    }

    public function addCorrect($deltaForQuestion)
    {
        $this->numCorrect +=1;
        $this->numQ += 1;
        $this->delta += $deltaForQuestion;
    }
    public function addIncorrect($deltaForQuestion)
    {
        $this->numIncorrect +=1;
        $this->numQ += 1;
        $this->delta += $deltaForQuestion;
    }
    public function addUnattempted($deltaForQuestion)
    {
        $this->numUnattempted +=1;
        $this->numQ += 1;
        $this->delta += $deltaForQuestion;
    }
}

class questionObject{
public $id = null;
public $text = null;
public $options = null;
public $correctAnswer = null;
public $explanation = null;
public $l3Id = null;
public $typeId = null;
public $tagIds = null;
public $difficulty = null;
public $paraId = null;
public $resources = null;
public $averageTimeCorrect = null;
public $averageTimeIncorrect = null;
public $averageTimeUnattempted = null;
public $averageCorrect = null;
public $averageIncorrect = null;
public $averageUnattempted = null;
public $allotedTime = null;
public $correctScore = null;
public $incorrectScore = null;
public $optionInCorrectScore = null;
public $optionCorrectScore = null;
public $unattemptedScore = null;
public $mobileFlag = null;
public $availableFlag = null;
public $videoSrc = null;
public $posterSrc = null;
public $id = null;
public $text = null;
public $options = null;
public $correctAnswer = null;
public $explanation = null;
public $l3Id = null;
public $typeId = null;
public $tagIds = null;
public $difficulty = null;
public $paraId = null;
public $resources = null;
public $averageTimeCorrect = null;
public $averageTimeIncorrect = null;
public $averageTimeUnattempted = null;
public $averageCorrect = null;
public $averageIncorrect = null;
public $averageUnattempted = null;
public $allotedTime = null;
public $correctScore = null;
public $incorrectScore = null;
public $optionScore = null;
public $unattemptedScore = null;
public $mobileFlag = null;
public $availableFlag = null;

function __construct($qid)
{
    $this->id = $qid;
    $getQuestionDetails($this->id);
}

}

function videoList() {
    $response = array();
    $accountId = $_GET['accountId'];
    $quizId = $_GET['quizId'];
    $streamId = $_GET['streamId'];
}

//>> FRONT-FACING Functions
function testCode()
{
    $sql = "SELECT * FROM questions WHERE id=:qid";
    var_dump(doSQL($sql,true));
    /*
  for($i=1;$i<=6;$i++)
  {
    $rand = rand(0,10);
    $sql = "insert into ascores_l1 (accountId, score, updatedOn, l1id, numQuestions, numCorrect, numIncorrect, numUnattempted, streamId) values (7,0,".time().",".$i.",10,".$rand.",".(10-$rand).",0,1)";
    $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("lid", $i);
        $stmt->execute();
  }*/
  /*
  for($i=1;$i<=31;$i++)
   {
        $sql = "select weightage, l1id from section_l2 where id = :lid";
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("lid", $i);
        $stmt->execute();
        $results = $stmt->fetch(PDO::FETCH_OBJ);
        $weightage = $results->weightage;
        $l2id = $results->l1id;
        $sql = "select score from ascores_l2 where l2id = :lid and accountId = 7";
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("lid", $i);
        $stmt->execute();
        $results = $stmt->fetch(PDO::FETCH_OBJ);
        $l2score = $results->score*$weightage;
        $sql = "update ascores_l1 set score = score + ".$l2score." where l1id = :l2id and accountId = 7";
        $stmt = $db->prepare($sql);
        $stmt->bindParam("l2id", $l2id);
        $stmt->execute();
        $db = null;
   }*/
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
function processPractice()
{
    if($_POST["isLast"] == '1')
    {
        $response2 = practiceResultsView();
        sendResponse($response2);
    }
    else
    {
        $response = updateResultsForPractice();
        sendResponse($response);
    }
}

function practiceResultsView()
{
    $accountId = $_POST['accountId']; 
    $quizId = $_POST['quizId'];
    $questionIds = getQuestionIdsForQuiz($quizId);

    $maxScore = 0;
    $numCorrect = 0;
    $numIncorrect = 0;
    $delta = array();
    $delta2 = array();
    $state = array();
    $state2 = array();
    $aScoreRecord= array();
    $l3GraphData = null;
    $qDetails = array();

    foreach($questionIds as $key=>$qid)
    {
        //echo "The question id is".$qid;
        $qDetails[$qid] = getQuestionDetails($qid);
        $maxScore += intval($qDetails[$qid]->correctScore);
        $qrecord = getQuestionResponse($accountId, $qid);
        /*echo "QID: $qid";
        var_dump($qrecord);*/
        $delta[$qid] = $qrecord->d;
        $state[$qid] = $qrecord->s;
        $currentState = $qrecord->s;
        $aScoreBefore = new stdClass();
        $aScoreBefore->l3score = $qrecord->a;
        $aScoreRecord[$qid] = $aScoreBefore;
    }
    $l3GraphData = getL3GraphData($accountId, $qDetails, $state, $delta, $aScoreRecord);
    $videoArray = getVideoArray($accountId, $qDetails, $delta);
    $temp = getUserResponseFromResultsTable($accountId, $quizId);
    $selectedAnswers = $temp[0];
    $timePerQuestion = $temp[1];
    $testScore = $temp[2];
    $numCorrect = $temp[3];
    $numIncorrect = $temp[4];

    foreach ($questionIds as $key => $value) {
        
        $delta2[] = $delta[$value];
        $state2[] = $state[$value];

    }

    $response["status"] = SUCCESS;
    $response["data"] = array(

        "state"=>$state2,
        "delta"=>$delta2,
        //"userAbilityRecord"=>$userAbilityRecord2,
        "maxScore"=>$maxScore,

        "videoArray"=>$videoArray,
        "l3GraphData"=>$l3GraphData,

        "selectedAnswers"=>json_encode($selectedAnswers),
        "timePerQuestion"=>json_encode($timePerQuestion),
        "score"=>$testScore,
        "numCorrect"=>$numCorrect,
        "numIncorrect"=>$numIncorrect
        );
    return $response;
}

function updateResultsForPractice()
{
    $accountId = $_POST['accountId']; 
    $quizId = $_POST['quizId'];
    $logs = $_POST['logs'];
    
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
    $score = $result[2]; //do something with this
    $delta = adjustDelta($qDetails,$userAbility,$timeTaken,$delta,$state,$attemptedAs);

    insertIntoResponsesTable($accountId, $qid, $optionText, $timeTaken,$userAbility->l3score,$delta,$state);
    updateResultsTable($accountId,$quizId,$logs); //tanujb:TODO:this needs to be changed to amend
    updateScore($accountId, $delta, $userAbility,$state);
    setStateOfQuiz($accountId,$quizId,$_POST["state"]);
    $temp = getUserResponseFromResultsTable($accountId, $quizId);
    $selectedAnswers = $temp[0]; $timePerQuestion = $temp[1];
    if($selectedAnswers==null && $timePerQuestion==null){
        $selectedAnswers = array();
        $timePerQuestion = array();
    }
    $selectedAnswers[intval($_POST["state"])] = $optionText;
    $timePerQuestion[intval($_POST["state"])] = $timeTaken;
    updateUserResponseinResultsTable($accountId, $quizId, json_encode($selectedAnswers), json_encode($timePerQuestion));

    switch($state)
    {
        case analConst::CORRECT:
            updateScoreinResultsTableBy($accountId,$quizId, $score, 1, 0);
        break;
        case analConst::INCORRECT:
            updateScoreinResultsTableBy($accountId,$quizId, $score, 0, 1);
        break;
        default:
            updateScoreinResultsTableBy($accountId,$quizId, $score, 0, 0);
        break;
    }

    // tanujb:TODO: I can probably do all this updating later, adn send json first.
    $response["status"] = SUCCESS;
    $response["data"] = true;
    /*$response["data"] = array(
        "optionText"=>$optionText,
        "timeTaken "=>$timeTaken,
        "state"=>$state,
        "delta"=>$delta,
        "userAbilityRecord"=>$userAbility
        );*/
    return $response;
}

function updateResultsForTest()
{
    $accountId = $_POST['accountId']; 
    $quizId = $_POST['quizId'];
    $logs = $_POST['logs'];

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
    $qDetailsRecord = array();
    $testScore = 0;
    $maxScore = 0;
    $numCorrect = 0;
    $numIncorrect = 0;
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
        $qDetailsRecord[$qid]=$qDetails;
        //$result[0] is $delta, $result[1] is state;
        // optimization tip:  unseen questions can be evaluated faster.

        //now adding question to response table;
        insertIntoResponsesTable($accountId, $qid, $optionText[$qid], $timeTaken[$qid],$userAbility->l3score,$delta[$qid],$state[$qid]);
        updateScore($accountId, $delta[$qid], $userAbility,$state[$qid]);

        $testScore += $result[$qid][2];
        $maxScore += $qDetails->correctScore;
        switch($state[$qid])
        {
            case analConst::CORRECT :
                $numCorrect += 1;
            break;
            case analConst::INCORRECT :
                $numIncorrect += 1;
            break;
        }
    }
    setStateOfQuiz($accountId,$quizId,count($questionIds));
    $videoArray = getVideoArray($accountId, $qDetailsRecord, $delta);
    $l3GraphData = getL3GraphData($accountId, $qDetailsRecord, $state, $delta, $userAbilityRecord);
    
    $response["status"] = SUCCESS;
    /*
    $response["data"] = array(
        "optionText"=>$optionText,
        "timeTaken "=>$timeTaken,
        "state"=>$state,
        "delta"=>$delta,
        "userAbilityRecord"=>$userAbilityRecord,
        "videoArray"=>$videoArray
        ); */
    

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
        "videoArray"=>$videoArray,
        "l3GraphData"=>$l3GraphData,
        "score"=>$testScore,
        "maxScore"=>$maxScore,
        "numCorrect"=>$numCorrect,
        "numIncorrect"=>$numIncorrect
        );    
    updateResultsTable($accountId,$quizId,$logs);//tanuj:TODO:these two calls should club into one, and add score.
    updateUserResponseinResultsTable($accountId, $quizId, $response["data"]["selectedAnswers"], $response["data"]["timePerQuestion"]);
    updateScoreinResultsTable($accountId, $quizId, $response["data"]["score"], $response["data"]["numCorrect"], $response["data"]["numIncorrect"]);
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
    //$defaultScore = analConst::ABILITY_DEFAULT_SCORE;
    $defaultScore = rand(20,90);
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
        return $defaultScore;
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

function doSQL($params,$returnsData)
{
    $sql = array_pop($params);
   try{
        $db = getConnection();
        $stmt = $db->prepare($sql);
        foreach ($params as $key => $value) {
            $stmt->bindParam($key,$value);
        }
        $stmt->execute();
        $db = null;
        if($returnsData == true)
        {
            $results = $stmt->fetch(PDO::FETCH_OBJ);        
            return $results;
        }
    }
    catch (PDOException $e) {
        phpLog("doSqlError:".$sql.$e->getMessage());
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
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        //$stmt->bindParam("selectedAnswers", json_encode($selectedAnswers));
        //$stmt->bindParam("timePerQuestion", json_encode($timePerQuestion));
        $stmt->bindParam("selectedAnswers", $selectedAnswers);
        $stmt->bindParam("timePerQuestion", $timePerQuestion);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}
function updateScoreinResultsTable($accountId, $quizId, $score, $numCorrect, $numIncorrect)
{
    $sql = "UPDATE results SET score = :s, numCorrect = :c, numIncorrect = :i where accountId=:accountId and quizId=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("s", $score);
        $stmt->bindParam("c", $numCorrect);
        $stmt->bindParam("i", $numIncorrect);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}
function updateScoreinResultsTableBy($accountId, $quizId, $score, $numCorrect, $numIncorrect)
{
    $sql = "UPDATE results SET score =  score + :s, numCorrect = numCorrect + :c, numIncorrect = numIncorrect +  :i where accountId=:accountId and quizId=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("s", $score);
        $stmt->bindParam("c", $numCorrect);
        $stmt->bindParam("i", $numIncorrect);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}
function getUserResponseFromResultsTable($accountId, $quizId)
{
    $sql = "SELECT selectedAnswers s, timePerQuestion t, score sc, numCorrect c, numIncorrect i FROM results WHERE accountId =:accountId AND quizID = :quizId";
    try{
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        $s = json_decode($result->s);
        $t = json_decode($result->t);
        return array($s, $t, $result->sc, $result->c, $result->i);
    }
    catch (PDOException $e){
        //
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
    $score = 0;
    if($optionText == "")
    {
        //unattempted
        //If not attempted see if any time was spent on the question
        if($timeTaken <= analConst::UNSEEN_TOLERANCE)
        {
            //question went unseen. Code that way
            $delta = evalUnseen($qDetails,$userAbility);
            $score = $qDetails->unattemptedScore;
            $state = analConst::UNSEEN;
        }
        else
        {
            //seen but skipped in $timeTaken seconds
            $delta = evalSkip($qDetails,$userAbility,$timeTaken);
            $score = $qDetails->unattemptedScore;
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
            $score = $qDetails->correctScore;
            $state = analConst::CORRECT;
        }
        else
        {
            switch($qDetails->typeId)
            {
                case questionType::SINGLE_CHOICE:
                    $delta = evalIncorrect($qDetails,$userAbility,$timeTaken);
                    $score = $qDetails->incorrectScore;
                    break;
                case questionType::MULTIPLE_CHOICE:
                    $optionLength = count(explode("|:",$qDetails->options));
                    $temp = evalOption($optionText,
                                        $qDetails->correctAnswer,
                                        $optionLength,
                                        $qDetails->optionCorrectScore,
                                        $qDetails->optionInCorrectScore);
                    $delta = $temp[0];
                    $score = $temp[1];
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
                        $temp = evalOption($tmpCorrectText,
                                        $tmpOptionText,
                                        $optionLength,
                                        $qDetails->optionCorrectScore,
                                        $qDetails->optionInCorrectScore);

                        $delta += $temp[0];
                        $score += $temp[1];
                    }
                    break;
                case questionType::INTEGER_TYPE:
                    $delta = evalIncorrect($qDetails,$userAbility,$timeTaken);
                    $score = $qDetails->incorrectScore;
                    break;
            }
            $state = analConst::INCORRECT;
        }
            
    }

    return array($delta,$state,$score);
}

function evalOption($optionText,$correctAnswerText, $optionLength, $correctScore, $incorrectScore)
{
    $optionsArray = getOptionArrayFromText($optionText,$optionLength);
    $correctArray = getOptionArrayFromText($correctAnswerText,$optionLength);
    $score = 0;
    $delta = 0;
    foreach ($correctArray as $key => $value) {
        if($optionsArray[$key] == $correctArray[$key])
        {
             $score += $correctScore;
             $delta += $correctScore; // add factor
        }   
        else
        {
            $score += $correctScore;
            $delta += $incorrectScore; //add factor
        }
    }
    return array($delta,$score);
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
    $delta = $qDetails->incorrectScore; //add factor
    return $delta;
}

function adjustDelta($qDetails,$userAbility,$timeTaken,$delta,$state,$attemptedAs)
{
    if($attemptedAs == analConst::ATTEMPTED_AS_PRACTICE)
    {
        $delta *= 0.5; 
    }
    return $delta;
}

function returnQuestionData()
{
    $accountId = $_POST['accountId']; 
    $qid = $_POST['qid'];
    $sql = "select optionSelected as o, timeTaken as t, abilityScoreBefore as a, delta as d, MAX(timeStamp) as m from responses where accountId = :acid AND questionId = :qid GROUP BY questionId";

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

function getQuestionResponse($accountId, $qid)
{
    $sql = "select optionSelected as o, timeTaken as t, abilityScoreBefore as a, delta as d, MAX(timeStamp) as m, status as s FROM responses WHERE accountId = :acid AND questionId = :qid GROUP BY questionId";

    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("acid", $accountId);
        $stmt->bindParam("qid", $qid);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        return $record;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}
//<< QUESTION EVALAUATION FUNCTIONS END

function getVideoArray($accountId, $qDetails, $delta)
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
function getL3GraphData($accountId, $qDetailsRecord, $state, $delta, $userAbilityRecord)
{
    $l3Data = array();

    foreach ($qDetailsRecord as $qid => $qDetails) {
        $lid = $qDetails->l3Id;
        if(!isset($l3Data[$lid]))
        {
            $lscore = $userAbilityRecord[$qid]->l3score;
            $l3Data[$lid] = new lscoreDataObject("l3",$lid,$lscore);
        }
        switch($state[$qid])
        {
            case analConst::CORRECT:
                $l3Data[$lid]->addCorrect($delta[$qid]);
            break;
            case analConst::INCORRECT:
                $l3Data[$lid]->addIncorrect($delta[$qid]);
            break;
            case analConst::SKIPPED:
                $l3Data[$lid]->addUnattempted($delta[$qid]);
            break;
            case analConst::UNSEEN:
                $l3Data[$lid]->addUnattempted($delta[$qid]);
            break;
        }
    }
    $temp = array();
    foreach ($l3Data as $key => $value) {
        $temp[] = $value;
    }
    return $temp;
}

function generateWeightage($l2id)
{
    $sql = "select count(*) c from section_l2 where l1id = :l2id";
    $db = getConnection();
    $stmt = $db->prepare($sql);
    $stmt->bindParam("l2id", $l2id);
    $stmt->execute();
    $results = $stmt->fetch(PDO::FETCH_OBJ);
    $weightage = 1/($results->c);
    $sql = "update section_l2 set weightage = ".$weightage." where l1id = :l2id";
    $stmt = $db->prepare($sql);
    $stmt->bindParam("l2id", $l2id);
    $stmt->execute();
    $db = null;
}

function getPQ($accountId)
{
    $sql = "select avg(score) as s from ascores_l1 where accountId = :acid";
    $db = getConnection();
    $stmt = $db->prepare($sql);
    $stmt->bindParam("acid", $accountId);
    $stmt->execute();
    $results = $stmt->fetch(PDO::FETCH_OBJ);
    $db = null;   
    return $results->s;
}

