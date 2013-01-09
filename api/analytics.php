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

function testCode()
{
    $accountId = 4; 
    $quizId = 2;
    echo "Hello!";
    var_dump(getQuestionIdsForQuiz($quizId));
}

function updateResults2()
{
    $response = array();
    //$streamId = $_POST['streamId']; // why is this required??
    
    $accountId = $_POST['accountId']; 
    $quizId = $_POST['quizId'];
    $logs = $_POST['logs'];


    updateResultsTable(); //storing to database

    $questionIds = getQuestionIdsForQuiz($quizId);
    $logsByQuestion = splitLogsByQuestion($logs);

    $optionArray = array();
    $optionText = array();
    $timeTaken = array(); //All 3 are per question arrays

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
        }

        $qDetails = getQuestionDetails($qid);
        $userAbility = getUserAbilityLevels($accountId, $qDetails->l3id);
        $delta = evaluateQuestion($qid,$optionText[$qid], $timeTaken[$qid],$accountId);

        updateScore($accountId, $delta, $userAbility);


    }

}

function updateScore($accountId, $delta, $userAbility)
{
    //this function updates l1, l2, l3 based on delta

    //l2 is weighted average of l3s, l1 is weighted average of l1s

}

function evaluateQuestion($qDetails, $optionText, $timeTaken, $userAbility)
{

    //Code here to calculate scores based on certain factors.

    //First check if attempted or not

    //If attempted, check if each option is in the state it is supposed to be


    //If not attempted see if any time was spent on the question
    //if time spent, scoring type 1, if not attempted scoring type 2


    return $delta;

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

function getUserAbilityLevels($accountId, $l3id)
{
    $sql = "SELECT l1.id 'l1', l2.id 'l2', l2.weightage 'l2w', l3.weightage 'l3w' FROM " +
           "section_l1 l1, section_l2 l2, section_l3 l3 WHERE l3.id=:l3id AND l3.l2id = l2.id AND l2.id = l1.id";

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
    $score->l1_id = $l1id;
    $score->l2_id = $l2id;
    $score->l3_id = $l3id;
    
    $score->l1_score = getAbilityScore("l1",$l1id);
    $score->l2_score = getAbilityScore("l2",$l2id);
    $score->l3_score = getAbilityScore("l3",$l3id);
    $score->l2_weightage = $l2w;
    $score->l3_weightage = $l3w;

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
        return $result->score;
        $db = null;

    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

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

function splitLogsByQuestion($logData)
{
    $questionDataSet = array();

    foreach ($logData as $key => $value)
        $questionDataSet[$value['q']][]=$value;

    return $questionDataSet;
}

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
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }

    return array("state"=>$previousState,"attemptedAs"=>$attemptedAs);
 // Code to get state and attempted as if needed.
}

function updateResultsTable($accountId, $quizId, $logs)
{
    $date = date("Y-m-d H:i:s", time());
    $state = 11; //arbitrary?????

    $sql = "UPDATE results SET timestamp=:timeStamp, state=:state, data=:data where accountId=:accountId and quizId=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("timeStamp", $date);
        $stmt->bindParam("state", $state);
        $stmt->bindParam("data", json_encode($logs));
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
}

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

function getOptionTextFromArray($optionsArray)
{
    $optionsText = array();
    foreach ($optionsArray as $key => $value)
        if($value)
            $optionsText[]=$key;

    $optionsText = implode("|:",$optionsText);
    return $optionsText;
}

function getOptionArrayFromText($optionsText, $optionLength)
{
    $optionsText = explode("|:",$optionsText);

    foreach ($variable as $key => $value) {
       // code missing
    }
}

