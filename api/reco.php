<?php

/* classes and other things for recommendations.
*/

class quizData
{
	public $quizid;
	public $questionIds;
	public $averageQScore;
	public $averageDifficulty;

	function __construct($quizid)
	{
		$this->quizid = $quizid;
		$this->questionIds       = $this->getQuestionIds();
		$this->averageQScore     = $this->getAverageQScore();
		$this->averageDifficulty = $this->getAverageDifficulty();
		$this->l3Ids = $this->getL3Ids();
	}

	private function getQuestionIds(){
        $query = array(
            "id"=>$this->quizid,
            "SQL"=>"SELECT questionIds FROM quizzes WHERE id=:id ");
        return explode("|:",doSQL($query, true)->questionIds);
    }
    function getAverageQScore()
	{
		return doSQL(array(
			"id"=>$this->quizid,
			"SQL"=>"SELECT avg(qScore) as q FROM questions WHERE id IN (".implode(",",$this->questionIds).")"
			),true)->q;
	}
	function getAverageDifficulty()
	{
		return doSQL(array(
			"id"=>$this->quizid,
			"SQL"=>"SELECT avg(difficulty) as q FROM questions WHERE id IN (".implode(",",$this->questionIds).")"
			),true)->q;
	}
    private function getL3Ids()
    {
    	
    }
    
}

function testcode1()
{
	$a = new quizData(1);
	var_dump($a);
}


