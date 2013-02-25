<?php

/* classes and other things for recommendations.
*/

/*
	l3 ids, then corresponding l2 ids, l1 ids, average l3score,
	facid
	not attempted since.
*/

class quizRecoModel
{
	public $quizid;
	public $questionIds;
	public $averageQScore;
	public $averageDifficulty;
	public $descriptionShort;
	public $l3Ids;
	public $l2Ids;
	public $l1Ids;
	public $facultyId;
	public $isAttempted; // omit?

	function __construct($quizid, $dataSet = null)
	{
		echo "in constructor";
		$this->quizid = $quizid;
		$this->loadData($dataSet);
	}

	private function loadData($temp = null){
		if(is_null($temp))
			$temp =  doSQL(array(
				"id"=>$this->quizid,
				"SQL"=>"SELECT descriptionShort, averageQScore, questionIds, averageDifficulty, l3Ids, l2Ids, l1Ids, facultyId FROM quizzes WHERE id = :id"
				),true);

		$list = array("questionIds","l3Ids","l2Ids","l1Ids","facultyId");
		
		foreach ($list as $key => $item)
			$temp->{$item} = explode("|:",$temp->{$item});	

		foreach ($temp as $key => $value)
			$this->{$key} = $value;
	}
	
	public function setAttempted($bool)
	{
		$this->isAttempted = $bool;
	}
	public function addAttemptData($row)
	{
		foreach ($row as $key => $value)
			$this->{$key} = $value;
	}



}

class quizRecoCollection
{
	public $accountId;
	public $unattemptedQuizzes;
	public $attemptedQuizzes;
	public $recos;

	function __construct($uid)
	{
		$this->accountId = $uid;
		$this->unattemptedQuizzes = $this->getQuizData();
		$this->attemptedQuizzes = $this->recos = array();
		$this->markAttemptedQuizzes();
		$this->getRecommendations();
	}

	private function getQuizData()
	{
		return doSQL(array("id"=> 1,
			"SQL"=>"SELECT quizId, descriptionShort, averageQScore, questionIds, averageDifficulty, l3Ids, l2Ids, l1Ids, facultyId FROM quizzes"),
			true,"all_class","quizRecoModel");
	}

	private function markAttemptedQuizzes()
	{
		$data = doSQL(array("id"=> $this->accountId,
			"SQL"=>"SELECT quizId, score, attemptedAs, timeStamp FROM responses WHERE accountId = :id ORDER BY timeStamp DESC"),
			true,"all_array");
		foreach ($data as $key => $row)
			$this->moveToAttempted($row->quizId, $row);
	}
	private function moveToAttempted($qid, $row)
	{
		foreach ($this->unattemptedQuizzes as $key => $quiz)
			if($quiz->quizId == $qid)
			{	
				$quiz->addAttemptData($row);
				$this->attemptedQuizzes[] = $quiz;
				$this->unattemptedQuizzes
					= array_splice($this->unattemptedQuizzes, $key, 1);
				break;
			}
	}
	public function listRecos()
	{
		usort($this->recos,'cmp');
		$temp = array();
		$j = 0;
		for($i=0;$i<count($recos) && $j <= 3;$i++)
			$temp[$j++]=$recos[$i]->toJSON();
	}
	function getRecommendations()
	{
		$attemptCount = count($this->attemptedQuizzes);
		$recoByQuizId = array();



		foreach ($this->attemptedQuizzes as $key => $aquiz) {
			foreach ($this->unattemptedQuizzes as $key => $uquiz) {
				if($aquiz->facultyId == $uquiz->facultyId)
					{
						$this->recos[] = new recoObject($aquiz->quizid,$aquiz->timeStamp,$aquiz->)
					}
			}	
		}
	}

}

class recoObject
{
	public $sourceQuizId;
	public $sourceQuizDescription;
	public $sourceQuizDate;
	public $recoQuizId;
	public $reasonText;
	public $confidence;

	function __construct($sourceQuizId, $sourceQuizDate, $sourceQuizDescription)
	{
		$this->sourceQuizId = $sourceQuizId;
		$this->sourceQuizDate = $sourceQuizDate;
		$this->sourceQuizDescription = $sourceQuizDescription;
	}

	function setFacultyRecommendation($recoQuizId, $facultyId, $confidence)
	{
		$this->reasonText = "Recommended since you took the test ".$this->sourceQuizDescription
							." by Prof. ".$this->getFacultyName($facultyId)
							." try another test by the same faculty";

		$this->recoQuizId = $recoQuizId;
		$this->confidence = $confidence;
	}
	function setTopicRecommendation($recoQuizId, $level, $lid, $confidence)
	{
		$this->reasonText = "Recommended since you took the test ".$this->sourceQuizDescription
							." on topic ".$this->getTopicName($level,$lid)
							.". try another test on a similar topic";
		$this->recoQuizId = $recoQuizId;
		$this->confidence = $confidence;	
	}
	function setLongTimeRecommendation($recoQuizId, $lid, $attemptTime)
	{
		$this->reasonText = "Recommended because you haven't attempted a test on ".getTopicName("l1",$lid)
							."since ".date("d-M",$attemptTime);
		$this->recoQuizId = $recoQuizId;
		$this->confidence = $confidence;
	}
	function getTopicName($level, $lid)
	{
		return doSQL(array("lid"=>$lid,
			"SQL"=>"SELECT displayName as d FROM section_".$level." WHERE id=:lid"),true)->d;
	}
	function getFacultyName($facultyId)
	{
		$temp = doSQL(array("id"=>$facultyId,
			"SQL"=>"SELECT firstName as f, lastName as l FROM accounts WHERE id=:id"),true);
		return $temp->f." ".$temp->l;
	}
	function getQuizName($facultyId)
	{
		$temp = doSQL(array("id"=>$facultyId,
			"SQL"=>"SELECT firstName as f, lastName as l FROM accounts WHERE id=:id"),true);
		return $temp->f." ".$temp->l;
	}
	public function toJSON()
	{
		$temp = array(
			"qid" => $this->recoQuizId,
			"reason"=>$this->reasonText
			);
		return (object) $temp;
	}
}


function testcode1()
{
	$a = new quizData(1);
	var_dump($a);
}

function cmp($a, $b)
{
	return ($a->confidence - $b->confidence);
}

function makeRecos()
{
	$accountId = $_POST['accountId'];
	$temp = new quizRecoCollection($accountId);

	$response["data"] = $temp->listRecos();
	$response["success"] = "SUCCESS";

	sendResponse($response);
}

