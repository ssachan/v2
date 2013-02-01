<?php
/** Comments:
Tanujb : Matrix type questions, code not tested.
adjustDelta needs to be modified.
*/
/*
set_include_path("..:.");
require_once('FirePHPCore/FirePHP.class.php');
ob_start();
$firephp=null;
//Debugging code =>
$firephp = FirePHP::getInstance(true);
$firephp->log($var, "Message");
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

    public static $enums = array(
        self::CORRECT => "CORRECT",
        self::INCORRECT => "INCORRECT",
        self::SKIPPED => "SKIPPED",
        self::UNSEEN => "UNSEEN"
        );
}

include ('constants.php');

class lscoreDataObject{
    public $lId;
    public $lType;
    public $numQ;
    public $numCorrect;
    public $numIncorrect;
    public $numUnattempted;
    public $scoreBefore;
    public $delta;

    function __construct($scoreObj){
        $this->lId = $scoreObj->id;
        $this->lType = $scoreObj->level;
        $this->scoreBefore = $scoreObj->score;
        $this->numQ = $scoreObj->numQ;
        $this->numCorrect = $scoreObj->numCorrect;
        $this->numIncorrect = $scoreObj->numIncorrect;
        $this->numUnattempted = $scoreObj->numUnattempted;
        $this->delta = $scoreObj->delta;
    }
}

class abilityLevels{

    public $l3Id;

    function __construct($l3Id){
        $this->l3Id = $l3Id;
        $this->getAbilityLevels();
    }
    function getAbilityLevels(){
        $sql = "SELECT l1.id 'l1', l2.id 'l2', l2.weightage 'l2w', l3.weightage 'l3w' FROM " .
               "section_l1 l1, section_l2 l2, section_l3 l3 WHERE l3.id=:l3id AND l3.l2id = l2.id AND l2.l1id = l1.id";
            
        $query= array(
            "l3id"=> $this->l3Id,
            "SQL"=>$sql);

        $ids = doSQL($query, true);
        
        $this->l1Id = $ids->l1;
        $this->l2Id = $ids->l2;
        $this->l2w = $ids->l2w;
        $this->l3w = $ids->l3w;
    }
    public function getIdOf($level){
        switch($level)
        {
            case "l1":
                return $this->l1Id;
            break;
            case "l2":
                return $this->l2Id;
            break;
            case "l3":
                return $this->l3Id;
            break;

        }
    }
    public function getWeightageOf($level){
        switch($level)
        {
            case "l1":
                return $this->l2w*$this->l3w;
            break;
            case "l2":
                return $this->l3w;
            break;
            case "l3":
                return 1;
            break;
        }
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
    function __construct($level, $id, $accountId){
        $this->currentDate = date("Y-m-d H:i:s", time());
        $this->level = $level;
        $this->id = $id;
        $this->accountId = $accountId;
        $this->getAbilityScore();
    }
    function getAbilityScore(){
            $query = array(
            "id"=> $this->id,
            "acid"=> $this->accountId,
            "SQL" => "SELECT score, numQuestions, numCorrect, numIncorrect, numUnattempted FROM ascores_".$this->level." WHERE ".$this->level."id=:id AND accountId = :acid" );
            $result = doSQL($query, true);
            $vars = array("score","numQuestions","numCorrect","numIncorrect","numUnattempted");
            if($result === false)
                {
                    foreach ($vars as $key => $value)
                        $this->{$value} = 0;
                    $this->score = $this->abilityScoreNotFound();    
                }
            else
                foreach ($vars as $key => $value)
                        $this->{$value} = $result->{$value};
    }
    function abilityScoreNotFound(){
        $streamId = 1;
        $date = date("Y-m-d H:i:s", time());
        //$defaultScore = analConst::ABILITY_DEFAULT_SCORE;
        $defaultScore = rand(20,90); //tanuj:TODO:change this
         $sql = "INSERT INTO ascores_".$this->level." (accountId, score, updatedOn, ".$this->level."id, numQuestions, numCorrect, numIncorrect, numUnattempted, streamId) VALUES (:acid,:score,:timeStamp,:id,0,0,0,0,:streamId)";
            $query = array(
            "acid"=> $this->accountId,
            "id"=> $this->id,
            "timeStamp"=> $date,
            "streamId"=>$streamId,
            "score"=> $defaultScore,
            "SQL"=>$sql);
        doSQL($query,false);
        return $defaultScore;
    }
    public function getScore(){
        return $this->score;
    }
    public function addCorrect($deltaForQuestion){
        $this->numCorrect +=1;
        $this->numQuestions += 1;
        $this->delta += $deltaForQuestion;
    }
    public function addIncorrect($deltaForQuestion){
        $this->numIncorrect +=1;
        $this->numQuestions += 1;
        $this->delta += $deltaForQuestion;
    }
    public function addUnattempted($deltaForQuestion){
        $this->numUnattempted +=1;
        $this->numQuestions += 1;
        $this->delta += $deltaForQuestion;
    }
    public function updateScore(){
        $this->currentDate = date("Y-m-d H:i:s", time());
        $this->score += $this->delta;

        $sql = "UPDATE ascores_".$this->level." SET score = :s , updatedOn = :u, numQuestions = :nQ, numCorrect = :nC, numIncorrect = :nI, numUnattempted = :nU WHERE ".$this->level."id = :lid AND accountId =:acid" ;

        $query = array(
            "s"=>$this->score,
            "u"=>$this->currentDate,
            "lid"=>$this->id,
            "nQ"=>$this->numQuestions,
            "nC"=>$this->numCorrect,
            "nU"=>$this->numUnattempted,
            "nI"=>$this->numIncorrect,
            "acid"=>$this->accountId,
            "SQL"=>$sql);

        doSQL($query,false);
    }
}

class abilityScoreCollections{
    public $accountId;
    public $abilityLevels;
    public $abilityScores;
    private $levels;

    function __construct($accountId){
        $this->accountId = $accountId;
        $this->abilityLevels = $this->abilityScores = array();
        $this->levels = array("l1","l2","l3");
    }
    function addL3($l3Id){
        if(!isset($this->abilityScores["l3".$l3Id]))
        {
            $tmpAbilityLevels = new abilityLevels($l3Id);
            $this->abilityLevels["l3".$l3Id] = $tmpAbilityLevels;
            foreach ($this->levels as $level)
                $this->abilityScores[$level.$tmpAbilityLevels->getIdOf($level)] =
                    new abilityScoreObject($level, $tmpAbilityLevels->getIdOf($level), $this->accountId);   

        }
    }
    function getScoresOf($level,$id){
        return $this->abilityScores[$level.$id]->getScore();
    }
    function setScoresOf($level,$id, $score){
        $this->abilityScores[$level.$id] = $score;
    }
    public function addCorrect($l3Id, $deltaForQuestion){
        $tmpAbilityLevels =& $this->abilityLevels["l3".$l3Id];
        foreach ($this->levels as $level) {
            $this->abilityScores[$level.$tmpAbilityLevels->getIdOf($level)]->addCorrect($deltaForQuestion*$tmpAbilityLevels->getWeightageOf($level));
        }
    }
    public function addIncorrect($l3Id, $deltaForQuestion){
        $tmpAbilityLevels = $this->abilityLevels["l3".$l3Id];
        foreach ($this->levels as $level) {
            $this->abilityScores[$level.$tmpAbilityLevels->getIdOf($level)]->addIncorrect($deltaForQuestion*$tmpAbilityLevels->getWeightageOf($level));
        }
    }
    public function addUnattempted($l3Id, $deltaForQuestion){
        $tmpAbilityLevels = $this->abilityLevels["l3".$l3Id];
        foreach ($this->levels as $level) {
            $this->abilityScores[$level.$tmpAbilityLevels->getIdOf($level)]->addUnattempted($deltaForQuestion*$tmpAbilityLevels->getWeightageOf($level));
        }
    }
    public function addAnswer($state, $l3Id, $delta){
        switch ($state)
        {
            case analConst::CORRECT:
                $this->addCorrect($l3Id, $delta);
            break;
            case analConst::INCORRECT:
                $this->addIncorrect($l3Id, $delta);
            break;
            case analConst::UNSEEN:
                $this->addUnattempted($l3Id, $delta);
            break;
            case analConst::SKIPPED:
                $this->addUnattempted($l3Id, $delta);
            break;
        }
    }
    public function updateScore(){
        foreach ($this->abilityScores as $key => $value)
            $this->abilityScores[$key]->updateScore();
    }
    public function getL3GraphData(){
        $l3Data = array();

        foreach ($this->abilityScores as $key => $scoreObj)
            if($scoreObj->level == "l3")
                $l3Data[] = new lscoreDataObject($scoreObj);
        
        return $l3Data;
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
    function __construct($qid){
        $this->id = $qid;
        $this->getQuestionDetails($this->id);
    }
    function getQuestionDetails($qid){
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

class questionEvalution{
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

    function __construct(){
         $a = func_get_args();
         $i = func_num_args();
         if($i==2)
         {
            $this->constructWithLogs($a[0],$a[1]);
         }
         else
         {
            $this->constructWithoutLogs($a[0],$a[1]);
         }   
    }
    function constructWithLogs($accountId,$logs){
        $this->accountId = $accountId;
        $this->qid = $logs[0]['q'];
        $this->logs = $logs;
        $this->qDetails = new questionObject($this->qid);
        $tmpOptions = explode("|:|:",$this->qDetails->options);
        $this->optionLength = count(explode("|:",$tmpOptions[0]));
        $this->getFinalOptionArray();
        $this->getOptionTextFromArray();
        $this->getTotalTime();
        $this->evaluateQuestion();
        //$this->adjustDelta(); //needs UserAbility and attempted as
        $this->delta = 1;    //temp
        //$this->insertIntoResponsesTable();
    }
    public function setAbilityScoreBefore($score){
        $this->abilityScoreBefore = $score;
    }
    function constructWithoutLogs($accountId, $qid){
        $this->accountId = $accountId;
        $this->qid = $qid;
        $this->qDetails = new questionObject($this->qid);
        
        $this->evaluateAsUnseen();
        $this->delta = 0;    //temp
     //   $this->adjustDelta(); //needs UserAbility and attempted as
        //$this->insertIntoResponsesTable();
    }

    function getFinalOptionArray(){
        $optionsArray = array();
        
        for($i=0;$i<$this->optionLength;$i++)
            $optionsArray[$i] = false;

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
        $this->optionArray = $optionsArray;
    }

    private function getOptionTextFromArray(){
        $optionText = array();
        foreach ($this->optionArray as $key => $value)
            if($value)
                $optionText[]=$key;

        $optionText = implode("|:",$optionText);
        $this->optionText = $optionText;
    }

    public function set($key, $value){
        $this->{$key} = $value;
    }
    public function get($key){
        return $this->{$key};
    }
    private function getTotalTime() //Can be optimized by combining these into one large loop.
    {
        $prevTimeStamp = $totalTime = 0;
        foreach ($this->logs as $key => $value)
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

    public function evaluateQuestion(){
        //Code here to calculate scores based on certain factors.
        //First check if attempted or not
        if($this->optionText == "")
        {
            //unattempted
            //If not attempted see if any time was spent on the question
            $this->score = $this->qDetails->unattemptedScore;
            if($this->timeTaken <= analConst::UNSEEN_TOLERANCE)
            {
                //question went unseen. Code that way
                $this->state = analConst::UNSEEN;
            }
            else
            {
                //seen but skipped in $timeTaken seconds
                $this->state = analConst::SKIPPED;
            }
        }
        else
        {

            //If attempted, check if each option is in the state it is supposed to be
            if($this->optionText == $this->qDetails->correctAnswer)
            {

                //everything correct exactly
                $this->score = $this->qDetails->correctScore;
                $this->state = analConst::CORRECT;

            }
            else
            {
                
                switch($this->qDetails->typeId)
                {
                    case questionType::SINGLE_CHOICE:
                        $this->score = $this->qDetails->incorrectScore;
                    break;
                    case questionType::MULTIPLE_CHOICE:
                        $this->evalOption();
                    break;
                    case questionType::MATRIX_MATCH:
                        //tanujb:TODO: following code may or may not work. needs unit tests.

                       /* $tmpOption = explode("|:|:",$qDetails->options);
                        $originalOptionText = $this->optionText;
                        $originalCorrectAnswer = $this->qDetails->correctAnswer;
                        $optionSuperArray =  getOptionArrayFromText($this->optionText,$this->optionLength);
                        $correctSuperArray = getOptionArrayFromText($this->qDetails->correctAnswer,$this->optionLength);
                        
                        foreach ($correctSuperArray as $k => $v) {

                            $this->qDetails->correctAnswer = $v;
                            $this->optionText = $optionSuperArray[$k];
                            $this->evalOption();
                        }
                        $this->qDetails->correctArray = $originalCorrectAnswer;
                        $this->optionText = $originalOptionText;
                        */
                    break;
                    case questionType::INTEGER_TYPE:
                        $this->score = $this->qDetails->incorrectScore;
                    break;
                }
                $this->state = analConst::INCORRECT;
            }
                
        }
    }
    function evaluateAsUnseen(){
        $this->optionText = "";
        $this->optionArray = array();
        $this->timeTaken = 0;
        $this->score = $this->qDetails->unattemptedScore;
        $this->state = analConst::UNSEEN;
    }
    function evalOption(){
        foreach ($this->qDetails->correctArray as $key => $value) {
            if($this->optionArray[$key] == $this->qDetails->correctArray[$key])
                $this->score += $this->qDetails->optionCorrectScore;
            else
                $this->score += $this->qDetails->optionInCorrectScore;
        }
    }
    function adjustDelta($userAbility,$attemptedAs){
        
        $state =& $this->state;
        $aScore =& $this->userAbility->score;
        $timeTaken =& $this->timeTaken;
        //$qScore =& $this->qDetails->qScore;
        switch($attemptedAs)
        {

        case analConst::ATTEMPTED_AS_TIMED_TEST :    
            switch ($state)
            {
                case analConst::CORRECT : 
                    $avgTime =& $this->qDetails->averageTimeCorrect;
                    //$sigmaTime =& $this->qDetails->sigmaTimeCorrect;
                break;
                case analConst::INCORRECT :
                    $avgTime =& $this->qDetails->averageTimeIncorrect
                    //$sigmaTime =& $this->qDetails->sigmaTimeIncorrect;
                break;
                case analConst::SKIPPED :
                    $avgTime =& $this->qDetails->averageTimeUnattempted
                    //$sigmaTime =& $this->qDetails->sigmaTimeUnattempted;
                break;
                case analConst::UNSEEN :
                    $avgTime =& $this->qDetails->averageTimeUnattempted
                    //$sigmaTime =& $this->qDetails->sigmaTimeUnattempted;
                break;
            }
            return deltaCalculator::calculate($state, $aScore, $qScore, $timeTaken, $avgTime, $sigmaTime);
        break;
        case analConst::ATTEMPTED_AS_PRACTICE :

        break;
        }
    }
    public function insertIntoResponsesTable(){
        $date = date("Y-m-d H:i:s", time());
        
        $query = array(
            "acid"=> $this->accountId,
            "qid"=> $this->qid,
            "tstmp"=> $date,
            "otxt"=> $this->optionText,
            "ttk"=> $this->timeTaken,
            "ascore"=> $this->abilityScoreBefore,
            "delta"=> $this->delta,
            "sts"=> $this->state,
            "SQL" => "INSERT INTO responses (accountId, questionID, optionSelected, timeTaken, abilityScoreBefore, delta, status, timestamp) VALUES (:acid,:qid,:otxt,:ttk,:ascore,:delta,:sts,:tstmp)"
            );

        doSQL($query,false);
    }
    public function generateInsert(){
        return array(
            ("acid".$this->qid) => $this->accountId,
            ("qid".$this->qid) => $this->qid,
            ("otxt".$this->qid) => $this->optionText,
            ("ttk".$this->qid) => $this->timeTaken,
            ("ascore".$this->qid) => $this->abilityScoreBefore,
            ("delta".$this->qid) => $this->delta,
            ("sts".$this->qid) => $this->state,
            "INSERT" => "(:acid".$this->qid.",:qid".$this->qid.",:otxt".$this->qid.",:ttk".$this->qid.",:ascore".$this->qid.",:delta".$this->qid.",:sts".$this->qid.",:tstmp)"
            );
    }
}

class quizResponseDetails{

    //{ Declarations  
        public $accountId;
        public $id;
        public $questionIds;
        public $state;
        public $attemptedAs;
        public $logs;
        public $logsByQuestion;
        public $selectedAnswers;
        public $timePerQuestion;
        public $numCorrect;
        public $numIncorrect;
        public $testScore;
        public $maxScore;
        public $qEvaluated;
        public $videoArray;
        public $l3GraphData;
    // } Declarations End

    function __construct($accountId, $quizId, $logs, $attemptedAs, $isLast = 0){
        $this->accountId = $accountId;
        $this->id = $quizId;
        $this->logs = $logs;
        $this->attemptedAs = $attemptedAs;
        $this->questionIds = $this->getQuestionIdsForQuiz();
        $this->logsByQuestion = $this->splitLogsByQuestion();
        $this->evaluateQuestions();
        if($attemptedAs == analConst::ATTEMPTED_AS_TIMED_TEST)
        {
            $this->generateQuizSummary();
        }
        elseif($attemptedAs == analConst::ATTEMPTED_AS_PRACTICE)
        {
            $this->state = $_POST['state'];
            $this->getQuizSummary();
            if($isLast == 0)
            {
                $this->updateQuizSummary();
            }
            else
            {
                $this->generateVideoArray();
                
            }
        }
        $this->updateResultsTable();
    }
    private function getQuestionIdsForQuiz(){
        $query = array(
            "id"=>$this->id,
            "SQL"=>"SELECT questionIds FROM quizzes WHERE id=:id ");
        return explode("|:",doSQL($query, true)->questionIds);
    }
    public function getMaxScore(){
        $query = array(
            "SQL"=>"SELECT SUM(correctScore) as s FROM questions WHERE id IN (".implode(",",$this->questionIds).")");
        return doSQL($query,true);
    }
    public function generateQuizSummary(){
        $selectedAnswers = $timePerQuestion = array();
        $score = $maxScore = $numCorrect = $numIncorrect = $delta = $timeTaken = 0;

        foreach ($this->qEvaluated as $qid => $q) {
            $selectedAnswers[]= $q->optionText;
            $timePerQuestion[] = $q->timeTaken;
            $delta += $q->delta; 
            $score += $q->score;
            $maxScore += $q->qDetails->correctScore;
            $timeTaken += $q->timeTaken; 
            switch($q->state)
            {
                case analConst::CORRECT:
                    $numCorrect += 1;
                break;
                case analConst::INCORRECT:
                    $numIncorrect += 1;
                break;
            }
        }

        $this->selectedAnswers = json_encode($selectedAnswers);
        $this->timePerQuestion = json_encode($timePerQuestion);
        $this->delta = $delta;
        $this->testScore = $score;
        $this->maxScore = $maxScore;
        $this->numCorrect = $numCorrect;
        $this->numIncorrect = $numIncorrect;
        $this->state = count($this->questionIds);
        $this->timeTaken = $timeTaken;
    }
    function getQuizSummary(){
        $query = array(
            "acid"=>$this->accountId,
            "qzid"=>$this->id,
            "SQL"=>"SELECT selectedAnswers, timePerQuestion, score as testScore, data as logs, numCorrect, numIncorrect, timeTaken FROM results WHERE accountID = :acid AND quizID = :qzid");
        $result = doSQL($query, true);
        $vars = array("selectedAnswers","timePerQuestion","testScore","numCorrect","numIncorrect","timeTaken");
        foreach ($vars as $key => $value)
                $this->{$value} = $result->{$value};
        
        $oldLogs =  is_null($result->logs)?null:json_decode($result->logs);
        if(!is_null($oldLogs) && is_array($oldLogs))
            $this->logs = array_merge($oldLogs,$this->logs);
    }
    function updateQuizSummary(){
        $qid=$this->questionIds[intval($this->state)];
        $this->testScore += $this->qEvaluated[$qid]->score;
        $this->selectedAnswers = json_decode($this->selectedAnswers);
        $this->timePerQuestion = json_decode($this->timePerQuestion);
        $this->selectedAnswers[intval($this->state)] = $this->qEvaluated[$qid]->optionText;
        $this->timePerQuestion[intval($this->state)] = $this->qEvaluated[$qid]->timeTaken;
        $this->selectedAnswers = json_encode($this->selectedAnswers);
        $this->timePerQuestion = json_encode($this->timePerQuestion);

        $this->timeTaken = is_null($this->timeTaken)?0:$this->timeTaken;
        $this->timeTaken += $this->qEvaluated[$qid]->timeTaken;

        switch ($this->qEvaluated[$qid]->state) {
            case analConst::CORRECT:
                $this->numCorrect +=1;
            break;
            case analConst::INCORRECT:
                $this->numIncorrect +=1;
            break;
        }
    }
    public function updateResultsTable(){
        $date = date("Y-m-d H:i:s", time());
        $query = array(
            "accountId"=> $this->accountId,
            "quizId"=> $this->id,
            "timeStamp"=> $date,
            "selectedAnswers" => $this->selectedAnswers,
            "timePerQuestion" => $this->timePerQuestion,
            "s"=> $this->testScore,
            "c"=> $this->numCorrect,
            "i"=> $this->numIncorrect,
            "st" => $this->state,
            "ttk" => $this->timeTaken,
            "data"=> json_encode($this->logs),
            "SQL" => "UPDATE results SET selectedAnswers = :selectedAnswers, timePerQuestion = :timePerQuestion, timestamp=:timeStamp, data=:data, score = :s, numCorrect = :c, numIncorrect = :i, state = :st, timeTaken = :ttk where accountId=:accountId and quizId=:quizId");
        doSQL($query, false);
    }
    function splitLogsByQuestion(){
        $questionDataSet = array();
        foreach ($this->logs as $key => $value)
            if(isset($value['q']))
                $questionDataSet[$value['q']][]=$value;
        return $questionDataSet;
    }
    function evaluateQuestions(){
        $qEvaluated = array(); $dummy = 0;
        foreach ($this->questionIds as $key => $qid) {
            if(isset($this->logsByQuestion[$qid]))
                $qEvaluated[$qid] = new questionEvalution($this->accountId,$this->logsByQuestion[$qid]);
            elseif($this->attemptedAs == analConst::ATTEMPTED_AS_TIMED_TEST)
                $qEvaluated[$qid] = new questionEvalution($this->accountId,$qid,$dummy);
        }
        $this->qEvaluated = $qEvaluated;
    }
    public function updateResponsesTable(){
        $date = date("Y-m-d H:i:s", time());
        $query = array("tstmp" => $date);
        $valuesString = "";
        foreach ($this->qEvaluated as $qid => $q) {
            $tmpArray = $q->generateInsert();
            $valuesString = $valuesString . ($valuesString == "" ? "" : ", ") . array_pop($tmpArray);
            $query = array_merge($query,$tmpArray);
        }
        $query[] = "INSERT INTO responses (accountId, questionID, optionSelected, timeTaken, abilityScoreBefore, delta, status, timestamp) VALUES " . $valuesString;
        
        
        doSQL($query, false);
    }
    public function generateVideoArray(){
        $videoArray = array();
        $deltas = $this->getDeltas();
        asort($deltas);
        $count = 0;
        foreach ($deltas as $qid => $value) {
            $videoObject = new stdClass();
                $videoObject->videoSrc = $this->qEvaluated[$qid]->qDetails->videoSrc;
                $videoObject->posterSrc = $this->qEvaluated[$qid]->qDetails->posterSrc;
            $videoArray[] = $videoObject;
            $count += 1;
            if($count == 5 || $value > 0)
                break;
        }
        $this->videoArray = $videoArray;
    }
    public function sendResponse(){
        $response["status"] = SUCCESS;

        $response["data"] = array(
            "selectedAnswers"=>$this->selectedAnswers,
            "timePerQuestion"=>$this->timePerQuestion,
            "state"=>$this->state,
            "delta"=>$this->delta,
           // "userAbilityRecord"=>$userAbilityRecord,
            "videoArray"=>$this->videoArray,
            "l3GraphData"=>$this->l3GraphData,
            "score"=>$this->testScore,
            "maxScore"=>$this->maxScore,
            "numCorrect"=>$this->numCorrect,
            "numIncorrect"=>$this->numIncorrect
            );
        sendResponse($response);
    }
    function getDeltas()
    {
        $deltas = array();
        foreach ($this->qEvaluated as $qid => $q) {
           $deltas[$qid] = $q->delta;
        }
        return $deltas;
    }
}
//>> FRONT-FACING Functions
function testCode(){
}

function processPractice(){
    if($_POST["isLast"] == '1')
        sendResponse(practiceResultsView());
    else
        sendResponse(updateResultsForPractice());
}

function practiceResultsView(){
    $accountId = $_POST['accountId']; $quizId = $_POST['quizId'];
    $questionIds = getQuestionIdsForQuiz($quizId);


    $maxScore = $numCorrect = $numIncorrect = 0;
    $delta = $delta2 = $state = $state2 = $aScoreRecord = $qDetails = array();
    $l3GraphData = null;

    foreach($questionIds as $key=>$qid)
    {
        $qDetails[$qid] = getQuestionDetails($qid);
        $maxScore += intval($qDetails[$qid]->correctScore);
        $qrecord = getQuestionResponse($accountId, $qid);   
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

    $quiz->sendResponse();
}

function updateResultsForPractice(){
    $accountId = $_POST['accountId']; $quizId = $_POST['quizId']; $logs = $_POST['logs'];

    $aScores = new abilityScoreCollections($accountId);
    $quiz =  new quizResponseDetails($accountId, $quizId, $logs, analConst::ATTEMPTED_AS_PRACTICE);
    
    $qEvaluated =& $quiz->qEvaluated[$quiz->questionIds[$quiz->state]];
        $aScores->addL3($qEvaluated->qDetails->l3Id);
        $qEvaluated->setAbilityScoreBefore($aScores->getScoresOf("l3",$qEvaluated->qDetails->l3Id));
        $aScores->addAnswer($qEvaluated->state,$qEvaluated->qDetails->l3Id,$qEvaluated->delta);

    $qEvaluated->insertIntoResponsesTable();
    
    $aScores->updateScore();

    return array("status" => SUCCESS, "data" => true);
}

function updateResultsForTest(){
    $accountId = $_POST['accountId']; $quizId = $_POST['quizId']; $logs = $_POST['logs'];

    $aScores = new abilityScoreCollections($accountId);
    $quiz = new quizResponseDetails($accountId, $quizId, $logs, analConst::ATTEMPTED_AS_TIMED_TEST);

    foreach ($quiz->qEvaluated as $qid => &$qEvaulated){
        $aScores->addL3($qEvaulated->qDetails->l3Id);
        $qEvaluated->setAbilityScoreBefore($aScores->getScoresOf("l3",$qEvaulated->qDetails->l3Id));
        $aScores->addAnswer($qEvaulated->state,$qEvaulated->qDetails->l3Id,$qEvaulated->delta);
    }
    
    $quiz->updateResponsesTable();

    $quiz->l3GraphData = $aScores->getL3GraphData();
    $quiz->generateVideoArray();

    $aScores->updateScore();
    
    $quiz->sendResponse();
}

function getPQ($accountId){
    $query = array(
        "acid"=>$accountId,
        "SQL"=>"select avg(score) as s from ascores_l1 where accountId = :acid");
    $results = doSQL($query, true);
    $response["status"] = SUCCESS;
    $response["data"] = round($results->s);
    sendResponse($response);
}

//***Functions that will remain

function getOptionArrayFromText($optionText, $optionLength){
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

function doSQL($params,$returnsData){   /*
    $firephp = FirePHP::getInstance(true);
    $firephp->log($params, "SQL:");*/
    $sql = array_pop($params);
   try{
        $db = getConnection();
        $stmt = $db->prepare($sql);
        foreach ($params as $key => $value) {
            $stmt->bindValue(":".$key,$value);
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
        //phpLog("doSqlError:".$sql.$e->getMessage());
        //echo("doSqlError:".$sql.$e->getMessage());
    }
}
