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
    //{ Declarations      
        public $id;
        public $text;
        public $options;
        public $correctAnswer;
        public $explanation;
        public $l3Id;
        public $typeId;
        public $tagIds;
        public $difficulty;
        public $paraId;
        public $resources;
        public $averageTimeCorrect;
        public $averageTimeIncorrect;
        public $averageTimeUnattempted;
        public $averageCorrect;
        public $averageIncorrect;
        public $averageUnattempted;
        public $allotedTime;
        public $correctScore;
        public $incorrectScore;
        public $optionInCorrectScore;
        public $optionCorrectScore;
        public $unattemptedScore;
        public $mobileFlag;
        public $availableFlag;
        public $videoSrc;
        public $posterSrc;
        //Following are not in SQL
        public $optionLength;
        public $correctArray;
    // } Declarations End
    function __construct($qid)
    {
        $this->id = $qid;
        $this->getQuestionDetails($this->id);
    }

    function getQuestionDetails($qid)
    {
        $query = array(
            "qid" => $qid,
            "SQL" => "SELECT * FROM questions WHERE id=:qid");
        $results =  doSQL($query, true);
        foreach ($results as $key => $value) {
            $this->{$key} = $value;
        }
        $this->optionLength = count(explode("|:",$this->options));
        $this->correctArray = getOptionArrayFromText($this->correctAnswer,$this->optionLength);
    }

}

class abilityScoreObject{
 //{Declarations 
        public $accountId;
        public $id;
        public $currentDate;
        public $score;
        public $numQuestions;
        public $numCorrect;
        public $numIncorrect;
        public $numUnattempted;
        public $updatedOn;
        public $streamId;

        public $level;
        public $delta;
 //}Declarations 
    function __construct($level, $id, $accountId)
    {
        $this->currentDate = date("Y-m-d H:i:s", time());
        $this->level = $level;
        $this->id = $id;
        $this->accountId = $accountId;

        $this->getAbilityScore();
    }

    function getAbilityScore()
    {
            $query = array(
            "id"=> $this->id,
            "acid"=> $this->accountId,
            "SQL" => "SELECT score FROM ascores_".$this->level." WHERE ".$this->level."id=:id AND accountId = :acid" );
            $result = doSQL($query, true);
            $score = 0;
            if($result === false)
                $this->score = $this->abilityScoreNotFound();
            else
                $this->score = $result->score;
    }
    function abilityScoreNotFound($level,$id,$accountId)
    {
        $streamId = 1;
        //$defaultScore = analConst::ABILITY_DEFAULT_SCORE;
        $defaultScore = rand(20,90); //tanuj:TODO:change this
         $sql = "INSERT INTO ascores_".$level." (accountId, score, updatedOn, ".$level."id, numQuestions, numCorrect, numIncorrect, numUnattempted, streamId) VALUES (:acid,:score,:timeStamp,:id,0,0,0,0,:streamId)";
            $query = array(
            "acid"=> $accountId,
            "id"=> $id,
            "timeStamp"=> $date,
            "streamId"=>$streamId,
            "score"=> $defaultScore,
            "SQL"=>$sql);
        doSQL($query,false);
        return $defaultScore;
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
    public function 
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

class questionEvalution
{
    //{ Declarations      
        public $accountId;
        public $quizId;
        public $qid;
        public $qDetails;
        public $optionArray;
        public $optionText;
        public $optionLength;
        public $timeTaken;
        public $logs;
        public $delta;
        public $state;
        public $score;
        public $abilityScoreBefore;
    // } Declarations End    
    function __construct($accountId,$quizId,$logs)
    {
        $this->accountId = $accountId;
        $this->quizId = $quizId;
        $this->qid = $logs[0]['q'];
        $qDetails = new questionObject($this->qid);
        $this->optionLength = count(explode("|:",$qDetails->options));

        $this->getFinalOptionArray();
        $this->getOptionTextFromArray();
        $this->getTotalTime();

    }

    function getFinalOptionArray()
    {
        $optionsArray = array();
        foreach ($this->logs as $key => $value)
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
        $this->optionsArray = $optionsArray;
    }

    private function getOptionTextFromArray()
    {
        $optionText = array();
        foreach ($this->optionsArray as $key => $value)
            if($value)
                $optionText[]=$key;

        $optionText = implode("|:",$optionText);
        $this->optionText = $optionText;
    }

    public function set($key, $value)
    {
        $this->{$key} = $value;
    }
    public function get($key)
    {
        return $this->{$key};
    }
    private function getTotalTime() //Can be optimized by combining these into one large loop.
    {
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
        $this->timeTaken = $totalTime;
    }

    public function evaluateQuestion($userAbility)
    {

        //Code here to calculate scores based on certain factors.
        //First check if attempted or not
        if($this->optionText == "")
        {
            //unattempted
            //If not attempted see if any time was spent on the question
            if($this->timeTaken <= analConst::UNSEEN_TOLERANCE)
            {
                //question went unseen. Code that way
                //$delta = evalUnseen($qDetails,$userAbility);
                $this->score = $this->qDetails->unattemptedScore;
                $this->state = analConst::UNSEEN;
            }
            else
            {
                //seen but skipped in $timeTaken seconds
                //$delta = evalSkip($qDetails,$userAbility,$timeTaken);
                $this->score = $this->qDetails->unattemptedScore;
                $this->state = analConst::SKIPPED;
            }
        }
        else
        {
            //If attempted, check if each option is in the state it is supposed to be
            if($this->optionText == $this->qDetails->correctAnswer)
            {
                //everything correct exactly
                //$delta = evalCorrect($qDetails,$userAbility,$timeTaken);
                $this->score = $this->$qDetails->correctScore;
                $this->state = analConst::CORRECT;
            }
            else
            {
                switch($this->qDetails->typeId)
                {
                    case questionType::SINGLE_CHOICE:
                        $this->score = $qDetails->incorrectScore;
                    break;
                    case questionType::MULTIPLE_CHOICE:
                        $this->evalOption();
                    break;
                    case questionType::MATRIX_MATCH:
                        //tanujb:TODO: figure out how this will work
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
                        }
                        break;
                    case questionType::INTEGER_TYPE:
                        $this->score = $this->qDetails->incorrectScore;
                    break;
                }
                $state = analConst::INCORRECT;
            }
                
        }

        return array($delta,$state,$score);
    }
    function evalOption()
    {
        foreach ($this->qDetails->correctArray as $key => $value) {
            if($optionsArray[$key] == $correctArray[$key])
                 $this->score += $this->qDetails->optionCorrectScore;
            else
                $this->score += $this->qDetails->optionInCorrectScore;
        }
    }
    function adjustDelta($userAbility,$attemptedAs)
    {
        //$qDetails
        //$timeTaken
        //$attemptedAs
        switch($this->state)
        {

        }

        if($attemptedAs == analConst::ATTEMPTED_AS_PRACTICE)
        {
            $delta *= 0.5; 
        }
        return $delta;
    }
    function insertIntoResponsesTable()
    {
        $date = date("Y-m-d H:i:s", time());
        $query = array(
            "accountId"=> $this->accountId,
            "qid"=> $this->qid,
            "tstmp"=> $date,
            "otxt"=> $this->optionText,
            "ttk"=> $this->timeTaken,
            "ascore"=> $this->abilityScoreBefore,
            "delta"=> $this->delta,
            "sts"=> $this->state,
            "SQL" => "INSERT INTO responses (accountId,questionID, optionSelected, timeTaken, abilityScoreBefore, delta, status, timestamp) VALUES (:accountId,:qid,:otxt,:ttk,:ascore,:delta,:sts,:tstmp)"
            );
        doSQL($query,false);
    }
}
//<< END FRONT FACING

//>> RETRIEVING, UPDATING SCORES AND ABILITY
function getUserAbilityLevels($accountId, $l3id)
{
    $sql = "SELECT l1.id 'l1', l2.id 'l2', l2.weightage 'l2w', l3.weightage 'l3w' FROM " .
           "section_l1 l1, section_l2 l2, section_l3 l3 WHERE l3.id=:l3id AND l3.l2id = l2.id AND l2.l1id = l1.id";
        
    $query= array(
        "l3id"=> $l3id,
        "SQL"=>$sql);

    $ids = doSQL($query, true);
    
    $score = new stdClass();
    $score->l1id = $ids->l1;
    $score->l2id = $ids->l2;
    $score->l3id = $ids->l3;
    $score->l1score = getAbilityScore("l1",$l1id,$accountId);
    $score->l2score = getAbilityScore("l2",$l2id,$accountId);
    $score->l3score = getAbilityScore("l3",$l3id,$accountId);
    $score->l2weightage = $ids->l2w;
    $score->l3weightage = $ids->l3w;

    return $score;
}
/*
    function getAbilityScore($level, $id, $accountId)
    {
            $query = array(
            "id"=> $id,
            "acid"=> $accountId,
            "SQL" => "SELECT score FROM ascores_".$level." WHERE ".$level."id=:id AND accountId = :acid" );
            $result = doSQL($query, true);

            if($result === false)
                return abilityScoreNotFound($level,$id,$accountId);
            else
                return $result->score;
    }

    function abilityScoreNotFound($level,$id,$accountId)
    {
        $date = date("Y-m-d H:i:s", time());
        $streamId = 1;
        //$defaultScore = analConst::ABILITY_DEFAULT_SCORE;
        $defaultScore = rand(20,90);
         $sql = "INSERT INTO ascores_".$level." (accountId, score, updatedOn, ".$level."id, numQuestions, numCorrect, numIncorrect, numUnattempted, streamId) VALUES (:acid,:score,:timeStamp,:id,0,0,0,0,:streamId)";
            $query = array(
            "acid"=> $accountId,
            "id"=> $id,
            "timeStamp"=> $date,
            "streamId"=>$streamId,
            "score"=> $defaultScore,
            "SQL"=>$sql);
        doSQL($query,false);
        return $defaultScore;
    }
*/
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
    
    $query = array("acid" => $accountId,
        "id" => $id,
        "timeStamp" => $date,
        "delta" => $delta,
        "SQL" => $sql);
    doSQL($query, false);
}
//<< END RETRIEVING, UPDATING SCORES AND ABILITY

//>> QUIZ/QUESTION DETAIL RETRIEVERS
class quizResponseDetails{

    //{ Declarations  
        public $accountId;
        public $id;
        public $questionIds;
        public $state;
        public $attemptedAs;
        public $logs;
        public $selectedAnswers;
        public $timePerQuestion;
        public $numCorrect;
        public $numIncorrect;
    // } Declarations End
    function __construct($accountId, $quizId)
    {
        $this->accountId = $accountId;
        $this->id = $quizId;
        $this->questionIds = $this->getQuestionIdsForQuiz();
    }
    function __construct($accountId, $quizId, $logs)
    {
        $this->accountId = $accountId;
        $this->id = $quizId;
        $this->logs = $logs;
        $this->questionIds = $this->getQuestionIdsForQuiz();
        $this->updateResultsTable();
    }
    private function getQuestionIdsForQuiz()
    {
        $query = array(
            "id"=>$this->id,
            "SQL"=>"SELECT questionIds FROM quizzes WHERE id=:id ");
        return explode("|:",doSQL($query, true));
    }
    public function getStateOfQuiz()
    {
        $query = array(
                "accountId"=> $accountId,
                "quizId"=> $quizId,
                "SQL" => "SELECT state as s,attemptedAs as a from results where accountId=:accountId and quizId=:quizId");
        $record = doSQL($query, true);
        $this->state = $record->s;
        $this->attemptedAs = $record->a;
    }
    public function setStateOfQuiz($state)
    {
        $this->state = $state;
        $this->updateStateOfQuiz();
    }
    public function updateStateOfQuiz()
    {
        $query = array(
            "accountId"=> $this->accountId,
            "quizId"=> $this->id,
            "state"=> $this->state,
            "SQL"=>"UPDATE results SET state=:state where accountId=:accountId and quizId=:quizId");
        doSQL($query, false);
    }
    public function updateResultsTable() //logs
    {
        $date = date("Y-m-d H:i:s", time());  // tanujb:TODO: arbitrary?????
        $query = array(
            "accountId"=> $this->accountId,
            "quizId"=> $this->id,
            "timeStamp"=> $date,
            "data"=> json_encode($logs),
            "SQL" => "UPDATE results SET timestamp=:timeStamp, data=:data where accountId=:accountId and quizId=:quizId");
        doSQL($query, false);
    }    
    public function updateUserResponseinResultsTable($accountId, $quizId, $selectedAnswers, $timePerQuestion)
    {
       $query = array(
            "accountId" => $this->accountId,
            "quizId" => $this->id,
            "selectedAnswers" => $this->selectedAnswers,
            "timePerQuestion" => $this->timePerQuestion,
            "SQL" => "UPDATE results SET selectedAnswers = :selectedAnswers, timePerQuestion = :timePerQuestion where accountId=:accountId and quizId=:quizId" );
       doSQL($query, false);
    }
    public function updateScoreinResultsTable($accountId, $quizId, $score, $numCorrect, $numIncorrect)
    {
       $query = array( 
            "accountId"=> $this->accountId,
            "quizId"=> $this->id,
            "s"=> $this->score,
            "c"=> $this->numCorrect,
            "i"=> $this->numIncorrect,
            "SQL" => "UPDATE results SET score = :s, numCorrect = :c, numIncorrect = :i where accountId=:accountId and quizId=:quizId");
        doSQL($query, false);
    }
    public function updateScoreinResultsTableBy($accountId, $quizId, $score, $numCorrect, $numIncorrect)
    {
        $query = array( 
            "accountId"=> $this->accountId,
            "quizId"=> $this->id,
            "s"=> $this->score,
            "c"=> $this->numCorrect,
            "i"=> $this->numIncorrect,
            "SQL" => "UPDATE results SET score = score + :s, numCorrect = numCorrect + :c, numIncorrect = numIncorrect + :i where accountId=:accountId and quizId=:quizId");
        doSQL($query, false);
    }
    public function getUserResponseFromResultsTable($accountId, $quizId)
    {
        $query = array(
            "acid" => $accountId,
            "qid" => $qid,
            "SQL" => "SELECT selectedAnswers s, timePerQuestion t, score sc, numCorrect c, numIncorrect i FROM results WHERE accountId =:acid AND quizID = :qid");
            
            $result = doSQL($query,true);

            return array(
                json_decode($result->s),
                json_decode($result->t),
                $result->sc,
                $result->c,
                $result->i );
    }
}
//<< END QUIZ/QUESTION DETAIL RETRIEVERS

function insertIntoResponsesTable($accountId, $qid, $optionText, $timeTaken,$abilityScore,$delta,$state)
{
    $date = date("Y-m-d H:i:s", time());

    $query = array(
        "accountId"=> $accountId,
        "qid"=> $qid,
        "tstmp"=> $date,
        "otxt"=> $optionText,
        "ttk"=> $timeTaken,
        "ascore"=> $abilityScore,
        "delta"=> $delta,
        "sts"=> $state,
        "SQL" => "INSERT INTO responses (accountId,questionID, optionSelected, timeTaken, abilityScoreBefore, delta, status, timestamp) VALUES (:accountId,:qid,:otxt,:ttk,:ascore,:delta,:sts,:tstmp)"
        );
    doSQL($query,false);
}

//TO EVALUATE
function returnQuestionData()
{
    $accountId = $_POST['accountId']; 
    $qid = $_POST['qid'];
    
    $query = array(
        "acid"=>$accountId,
        "qid"=>$qid,
        "SQL"=>"select optionSelected as o, timeTaken as t, abilityScoreBefore as a, delta as d, MAX(timeStamp) as m from responses where accountId = :acid AND questionId = :qid GROUP BY questionId");

    $response["status"] = SUCCESS;
    $response["data"] = $record;
    sendResponse($response);
}

function getQuestionResponse($accountId, $qid)
{
    $query = array(
        "acid"=>$accountId,
        "qid"=>$qid,
        "SQL"=>"SELECT optionSelected as o, timeTaken as t, abilityScoreBefore as a, delta as d, MAX(timeStamp) as m, status as s FROM responses WHERE accountId = :acid AND questionId = :qid GROUP BY questionId"
        );
    return doSQL($query, true);
}

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

function getPQ($accountId)
{
    $query = array(
        "acid"=>$accountId,
        "SQL"=>"select avg(score) as s from ascores_l1 where accountId = :acid");
    $results = doSQL($query, true);
    return $results->s;
}

//***Functions that will remain

function splitLogsByQuestion($logData)
{
    $questionDataSet = array();
    foreach ($logData as $key => $value)
        if(isset($value['q']))
            $questionDataSet[$value['q']][]=$value;
    return $questionDataSet;
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

//Functions that are temp
function generateWeightage($lid)
{
    $query = array(
        "lid"=>$lid,
        "SQL"=>"SELECT count(*) c FROM section_l2 WHERE l1id = :lid");
    $results = doSql($query,true);
    
    $weightage = 1/($results->c);

    $query = array(
        "wt"=>$weightage,
        "lid"=>$lid,
        "SQL"=>"update section_l2 set weightage =:wt where l1id = :l2id");
    doSQL($query, false);
}
