<?php


/*
Functions for analytics

*/


function template_send()
{

   $response = array();
    $sql = "SELECT * from section_l3 where streamId=:id";
    $sql = "SELECT a.id as id,a.firstName,a.lastName,f.* from faculty f, accounts a where a.id=:id and a.id=f.accountId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $records = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        $response["status"] = SUCCESS;
        $response["data"] = $records;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    sendResponse($response);

 }

function template_update()
{
	$response = array();
    $accountId = $_POST['accountId'];
    $quizId = $_POST['quizId'];
    $attemptedAs = $_POST['attemptedAs'];
    $sql = "update results set attemptedAs=:attemptedAs where quizId=:quizId and accountId=:accountId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("attemptedAs", $attemptedAs);
        $stmt->execute();
        $db = null;
        $response["status"] = SUCCESS;
        $response["data"] = $attemptedAs;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    sendResponse($response);
}






function updateResults() {
    $response = array();
    $streamId = $_POST['streamId'];
    $accountId = $_POST['accountId'];
    $quizId = $_POST['quizId'];
    $score = $_POST['score'];
    $state = $_POST['state'];
    $logs = json_encode($_POST['logs']);
    $selectedAnswers = stripslashes($_POST['selectedAnswers']);
    $timePerQuestion = $_POST['timePerQuestion'];
    $date = date("Y-m-d H:i:s", time());
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
    $sql = "UPDATE results SET selectedAnswers=:selectedAnswers, score=:score, timePerQuestion=:timePerQuestion, timestamp=:timeStamp,state=:state,data=:data where accountId=:accountId and quizId=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("selectedAnswers", $selectedAnswers);
        $stmt->bindParam("score", $score);
        $stmt->bindParam("timePerQuestion", $timePerQuestion);
        $stmt->bindParam("timeStamp", $date);
        $stmt->bindParam("state", $state);
        $stmt->bindParam("data", $logs);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }

    $sql = "INSERT INTO responses (accountId, questionId, optionSelected, timeTaken) VALUES (:accountId, :questionId, :selectedAnswer, :timeTaken)";
    $qIds = getQuestionIdsByQuiz($quizId);
    $selectedAnswersArray = json_decode($selectedAnswers);
    $timePerQuestionArray = json_decode($timePerQuestion);
    $len = sizeof($selectedAnswersArray);
    // clearly separate depending on attempted as
    if ($attemptedAs == '1') {
        for ($i=0; $i < $len; $i++) {
            try {
                $db = getConnection();
                $stmt = $db->prepare($sql);
                $stmt->bindParam("accountId", $accountId);
                $stmt->bindParam("questionId", $qIds[$i]);
                $stmt->bindParam("selectedAnswer", $selectedAnswersArray[$i]);
                $stmt->bindParam("timeTaken", $timePerQuestionArray[$i]);
                $stmt->execute();
                $db = null;
            } catch (PDOException $e) {
                $response["status"] = ERROR;
                $response["data"] = EXCEPTION_MSG;
                phpLog($e->getMessage());
            }
        }
    } else {
        $i = 0;
        if ($previousState!=null){
            // start from where the questions haven't come
            $i = $previousState + 1;
        }
        if ($state != null) {
            $len = $state;
        }
        for ($i; $i <= $len; $i++) {
            try {
                $db = getConnection();
                $stmt = $db->prepare($sql);
                $stmt->bindParam("accountId", $accountId);
                $stmt->bindParam("questionId", $qIds[$i]);
                $stmt->bindParam("selectedAnswer", $selectedAnswersArray[$i]);
                $stmt->bindParam("timeTaken", $timePerQuestionArray[$i]);
                $stmt->execute();
                $db = null;
            } catch (PDOException $e) {
                $response["status"] = ERROR;
                $response["data"] = EXCEPTION_MSG;
                phpLog($e->getMessage());
            }
        }
    }
    /*
    //not sure if we want to do it.  
    $sql = "UPDATE quizzes SET totalAttempts=totalAttempts+1 where id=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("quizId", $quizId);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
     */
    if (!isset($response["status"])) {
        $response["status"] = SUCCESS;
        $response["data"] = true;
    }
    sendResponse($response);
}



?>
