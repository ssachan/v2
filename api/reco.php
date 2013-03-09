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

	/*function __construct($quizid, $dataSet = null)
	{
		echo "in constructor";
		$this->quizid = $quizid;
		$this->loadData($dataSet);
	}*/

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
			"SQL"=>"SELECT id as quizid, descriptionShort, averageQScore, questionIds, averageDifficulty, l3Ids, l2Ids, l1Ids, facultyId FROM quizzes WHERE available = 1"),
			true,"all_class","quizRecoModel");
	}

	private function markAttemptedQuizzes()
	{
		$data = doSQL(array("id"=> $this->accountId,
			"SQL"=>"SELECT quizId, score, attemptedAs, timeStamp FROM results WHERE accountId = :id ORDER BY timeStamp DESC"),
			true,"all_array");
		foreach ($data as $key => $row)
			$this->moveToAttempted($row["quizId"], $row);
	}
	private function moveToAttempted($qid, $row)
	{
		foreach ($this->unattemptedQuizzes as $key => $quiz)
			if($quiz->quizid == $qid)
			{	
				$quiz->addAttemptData($row);
				$this->attemptedQuizzes[] = $quiz;
				array_splice($this->unattemptedQuizzes, $key, 1);
				break;
			}
	}
	public function listRecos()
	{
		usort($this->recos,'cmp');
		$temp = array();
		$j = 0;
		for($i=0;$i<count($this->recos) && $j <= 3;$i++)
			$temp[$j++]=$this->recos[$i]->toJSON();
		return $temp;
	}
	function getRecommendations()
	{
		$attemptCount = count($this->attemptedQuizzes);
		$recoByQuizId = array();
		$i = 20;
		foreach ($this->attemptedQuizzes as $key => $aquiz) {
			foreach ($this->unattemptedQuizzes as $key => $uquiz) {
				if($aquiz->facultyId == $uquiz->facultyId)
					{
						$this->recos[] = new recoObject($aquiz->quizid,$aquiz->timeStamp,$aquiz->descriptionShort);
						$kee = count($this->recos)-1;
						$this->recos[$kee]->setFacultyRecommendation($uquiz->quizid, $aquiz->facultyId, 20 +$i);
						$recoByQuizId[$uquiz->quizid][] = $kee;
					}
			}
			$i -= $i>0 ? 10 : 0;	
		}
		$i =30;
		if($attemptCount == 0 || count($this->recos) == 0)
		{
			foreach ($this->unattemptedQuizzes as $key => $uquiz) {
						$this->recos[] = new recoObject();
						$kee = count($this->recos)-1;
						$this->recos[$kee]->setDefaultRecommendation($uquiz->quizid, 20 +$i);
						$recoByQuizId[$uquiz->quizid][] = $kee;
						$i -= $i>0 ? 10 : 0;
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

	function __construct($sourceQuizId = 1, $sourceQuizDate = null, $sourceQuizDescription ="no quizzes attempted")
	{
		$this->sourceQuizId = $sourceQuizId;
		$this->sourceQuizDate = $sourceQuizDate;
		$this->sourceQuizDescription = $sourceQuizDescription;
	}
	function setDefaultRecommendation($recoQuizId, $confidence)
	{
		$this->reasonText = "Since you haven't taken any tests, we recommend starting with this test.";
		$this->recoQuizId = $recoQuizId;
		$this->confidence = $confidence;
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
	function setLongTimeRecommendation($recoQuizId, $lid, $attemptTime, $confidence)
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


function testcode1($accountId)
{
	//$accountId = $_POST['accountId'];
	$temp = new quizRecoCollection($accountId);
	$temp = $temp->listRecos();
	echo "\n\nDumping : quizRecoCollection";
	
	$data = array();
	foreach ( $temp as $key => &$item) {
		$dataobj = (object) doSQL(array("id"=>$item->qid,
		"SQL" => "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.allotedTime,q.maxScore,q.rec,q.conceptsTested, q.l2Ids, q.l3Ids, q.typeId, a.id as fid, a.firstName,a.lastName,f.bioShort,f.education from quizzes q, accounts a, faculty f where q.facultyId=a.id and f.accountId=a.id and q.available=1 and q.id = :id"
			),true);
		$dataobj->id = $item->qid;
		$dataobj->reason = $item->reason;
		$data[] = $dataobj;
	}
	var_dump($data);
	$response["data"] = $data;
	$response["status"] = SUCCESS;

	sendResponse($response);
}

function cmp($a, $b)
{
	return ($a->confidence - $b->confidence);
}

function makeRecos()
{
	$accountId = $_POST['accountId'];
	$temp = new quizRecoCollection($accountId);
	$temp = $temp->listRecos();
	$data = array();
	foreach ( $temp as $key => &$item) {
		$dataobj = (object) doSQL(array("id"=>$item->qid,
		"SQL" => "select q.*, a.id as fid, a.firstName,a.lastName,f.bioShort,f.education from quizzes q, accounts a, faculty f where q.facultyId=a.id and f.accountId=a.id and q.available<>0 and q.id = :id"
			),true);
		$dataobj->id = $item->qid;
		$dataobj->reason = $item->reason;
		$data[] = $dataobj;
	}

	$response["data"] = $data;
	$response["status"] = SUCCESS;

	sendResponse($response);
}

