<?php
header("Access-Control-Allow-Origin: *");
require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

include 'helper.php';
include 'authState.php';

// the L1,L2,L3
$app->get('/l1ByStream/:id', 'getL1ByStream');
$app->get('/l2ByStream/:id', 'getL2ByStream');
$app->get('/l3ByStream/:id', 'getL3ByStream');

//quiz library
$app->get('/quizzesByStreamId/:id', 'getQuizzesByStreamId');

// the fac pages
$app->get('/facByStreamId/:id', 'getFacByStreamId');
$app->get('/fac/:id', 'getFac');
$app->get('/quizzesByFac/:id', 'getQuizzesByFac');

//dashboard page
$app->get('/l1Performance/', $authenticate($app), 'getL1Performance');
$app->get('/l2Performance/', $authenticate($app), 'getL2Performance');
$app->get('/historyById/', $authenticate($app), 'getQuizzesHistory');

//quiz
$app->get('/processQuiz/', $authenticate($app), 'processQuiz');

// responses
$app->post('/responses', 'addResults');

// responses
$app->post('/facContact/', 'facContact');

//packages
$app->get('/packagesByStreamId/:id', 'getPackagesByStreamId');
$app->post('/purchase/:id', 'addPurchase');

define('SUCCESS', "success"); // returns the requested data.
define('FAIL', "fail"); // logical error.
define('ERROR', "error"); // system error.
define('EXCEPTION_MSG', "Something went wrong. Please send an email to ..."); // system error.

define('DP_PATH', "resources/accounts/"); // DP PATH.

/**
 * All responses routed through this function
 * @param Object $response
 */
function sendResponse($response) {
    // maintaining a queue/ including any checks
    // Include support for JSONP requests
    if (!isset($_GET['callback'])) {
        echo json_encode($response);
    } else {
        echo $_GET['callback'] . '(' . json_encode($response) . ');';
    }
}

/**
 * Handle server side exceptions and errors. Maintain logs
 * @param $msg
 */
function phpLog($msg) {
    //error_log($msg, 3, '/var/tmp/php.log');
    echo $msg;
}

function getL1ByStream($id) {
    $response = array();
    $sql = "select * from section_l1 where streamId=:id";
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

function getL2ByStream($id) {
    $response = array();
    $sql = "select * from section_l2 where streamId=:id";
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

function getL3ByStream($id) {
    $response = array();
    $sql = "SELECT * from section_l3 where streamId=:id";
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

//
// The dashboard page 
//

function getL1Performance() {
    $response = array();
    $accountId = $_GET['accountId'];
    $streamId = $_GET['streamId'];
    $sql = "select a.l1Id as id, a.score,MAX(a.updatedOn) as updatedOn from ascores_l1 a where a.accountId=:accountId and streamId=:streamId group by l1Id";
    //$sql = "select l.id,l.displayName,T.score from section_l1 l LEFT JOIN (select a.l1Id, a.score,MAX(a.updatedOn) from ascores_l1 a where a.accountId=:id and streamId='1' group by l1Id) as T on l.id=T.l1Id where l.streamId='1'";
    //$sql = "SELECT * from section_l1 where streamId=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
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

function getL2Performance() {
    $response = array();
    $accountId = $_GET['accountId'];
    $streamId = $_GET['streamId'];
    $sql = "select a.l2Id as id, a.score,MAX(a.updatedOn) as updatedOn from ascores_l2 a where a.accountId=:accountId and streamId=:streamId group by a.l2Id";
    // $sql = "select l.id,l.displayName,T.score,l.l1Id from section_l2 l LEFT JOIN (select a.l2Id, a.score,MAX(a.updatedOn) from ascores_l2 a where a.accountId=:id and streamId='1' group by a.l2Id) as T on l.id=t.l2Id where l.streamId='1'";
    //$sql = "select l.id,l.displayName,l.l1Id,l.streamId,a.streamId as st, a.score from section_l2 l LEFT JOIN ascores_l2 a ON a.l2Id=l.id where l.streamId=1 and (a.streamId IS NULL OR a.streamId=1) order by l.l1Id ";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
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

function getQuizzesHistory() {
    $response = array();
    $accountId = $_GET['accountId'];
    $streamId = $_GET['streamId'];
    $sql = "select r.selectedAnswers,r.timePerQuestion,r.score,q.* from results r,quizzes q where accountId=:accountId and q.streamId=:streamId and r.quizId=q.id order by timestamp";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
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

//
// The quiz library page
//
function getQuizzesByStreamId($id) {
    $response = array();
    $sql = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.allotedTime,q.maxScore,q.rec,q.conceptsTested, q.l2Ids, q.l3Ids, q.typeId, f.id as fid, f.firstName,f.lastName from quizzes q, faculty f where q.facultyId=f.id and q.streamId=:id";
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

//
// The fac directory page
//

function getFacByStreamId($id) {
    $response = array();
    $sql = "select * from faculty where streamIds like '%" . $id
            . "' or streamIds like '" . $id . "%' or streamIds like '%|:" . $id
            . "|:%'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
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

//
// The fac profile page
//

function getFac($id) {
    $response = array();
    $sql = "select * from faculty where id=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if ($record != null && $record->id != null) {
            $response["status"] = SUCCESS;
            $response["data"] = $record;
        } else {
            $response["status"] = FAIL;
            $response["data"] = "data doesn't exist";
        }
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    sendResponse($response);
}

function getQuizzesByFac($id) {
    $response = array();
    $ids = explode("|", $id);
    $sql = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.allotedTime,q.maxScore,q.rec,q.conceptsTested, q.l2Ids, q.l3Ids, q.typeId from quizzes q where q.facultyId=:facId and q.streamId=:streamId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("facId", $ids[0]);
        $stmt->bindParam("streamId", $ids[1]);
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

function getFollowers($id) {
    $response = array();
    $sql = "select * from faculty where id=:id";
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

function getQuestions($qids) {
    $qids = explode("|:", $qids);
    $sql = "SELECT * from questions where id IN(" . implode(",", $qids) . ")";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        return $questions;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

/**
 * The function where the quiz processing takes place. We check for all the 
 * packages available and then substract from the appropriate one.
 * 
 */
function processQuiz() {
    $response = array();
    $accountId = $_GET['accountId'];
    $quizId = $_GET['quizId'];
    // for now just return the questions from the quiz if quiz is not a part of the history.
    $sql = "SELECT count(*) as count FROM results where quizId=:quizId and accountId=:accountId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("accountId", $accountId);
        $stmt->execute();
        $count = $stmt->fetchObject();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    if ($count->count == 0) {
        // this quiz hasn't been taken.
        // logic for package redemption at this point its null.

    } else {
        // you have already taken this quiz, this seems to be a call for fetching questions 
        // for the results
    }
    $sql = "SELECT questionIds FROM quizzes where id=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $quizId);
        $stmt->execute();
        $questionIds = $stmt->fetchObject();
        $db = null;
        if ($questionIds->questionIds != null) {
            $questions = getQuestions($questionIds->questionIds);
            $response["status"] = "success";
            $response["data"] = $questions;
        } else {
            $response["status"] = "fail";
            $response["data"] = "Something went wrong! Please drop in an email to admin@ps.com";
        }
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    sendResponse($response);
}

function addResponse() {

}

function addResults() {
    $response = array();
    $streamId = $_POST['streamId'];
    $accountId = $_POST['accountId'];
    $quizId = $_POST['quizId'];
    $score = $_POST['score'];
    $selectedAnswers = stripslashes($_POST['selectedAnswers']);
    $timePerQuestion = $_POST['timePerQuestion'];
    $date = date("Y-m-d H:i:s", time());
    $sql = "INSERT INTO results (accountId, quizId, selectedAnswers, score, timePerQuestion, timestamp) VALUES (:accountId, :quizId, :selectedAnswers, :score, :timePerQuestion, :timeStamp)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("quizId", $quizId);
        $stmt->bindParam("selectedAnswers", $selectedAnswers);
        $stmt->bindParam("score", $score);
        $stmt->bindParam("timePerQuestion", $timePerQuestion);
        $stmt->bindParam("timeStamp", $date);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    
    /*$sql = "INSERT INTO responses (accountId, questionId, selectedAnswer, score, timePerQuestion, timestamp) VALUES (:accountId, :quizId, :selectedAnswers, :score, :timePerQuestion, :timeStamp)";
    // loop through 
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("questionId", $accountId);
        $stmt->bindParam("questionId", $questionId);
        $stmt->bindParam("selectedAnswer", $selectedAnswer);
        $stmt->bindParam("timeTaken", timeTaken);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
     */
    $sql = "SELECT quizzesAttempted from students where accountId=:accountId and streamId=:streamId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        if ($record->quizzesAttempted == null) {
            $quizzesAttempted = array();
        } else {
            $quizzesAttempted = json_decode($record->quizzesAttempted);
        }
        if (!(in_array($quizId, $quizzesAttempted))) {
            array_push($quizzesAttempted, $quizId);
        }
        $quizzesAttemptedJson = json_encode($quizzesAttempted);
        $sql = "UPDATE students SET quizzesAttempted=:quizzesAttempted where accountId=:accountId and streamId=:streamId";
        try {
            $db = getConnection();
            $stmt = $db->prepare($sql);
            $stmt->bindParam("quizzesAttempted", $quizzesAttemptedJson);
            $stmt->bindParam("accountId", $accountId);
            $stmt->bindParam("streamId", $streamId);
            $stmt->execute();
            $db = null;
        } catch (PDOException $e) {
            $response["status"] = ERROR;
            $response["data"] = EXCEPTION_MSG;
            phpLog($e->getMessage());
        }
        // insert it back in the table
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }

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
    if (!isset($response["status"])) {
        $response["status"] = SUCCESS;
        $response["data"] = true;
    }
    sendResponse($response);
}

/**
 * some dummy logic to update the scores. 
 */
function updateScores($accId, $streamId) {
    $sql2 = "UPDATE students SET ascoreL1=ascoreL1+1 where accountId=:accountId and streamId=:streamId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql2);
        $stmt->bindParam("accountId", $accId);
        $stmt->bindParam("streamId", $streamId);
        $stmt->execute();
        $db = null;
        $response->id = $db->lastInsertId();
        echo json_encode($response->id);
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getPackagesByStreamId($id) {
    $sql = "SELECT p.id as id,p.name,p.details,p.price from packages p where p.streamId='"
            . $id . "'";
    //echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $packages = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        // Include support for JSONP requests
        if (!isset($_GET['callback'])) {
            echo json_encode($packages);
        } else {
            echo $_GET['callback'] . '(' . json_encode($packages) . ');';
        }
        return;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function facContact() {
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid email address";
        break;
    }
    if (!isset($_POST['firstName']) || $_POST['firstName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your first name";
        break;
    }
    if (!isset($_POST['lastName']) || $_POST['lastName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your last name";
        break;
    }
    if (!isset($_POST['phoneNumber']) || $_POST['phoneNumber'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your phone number";
        break;
    }
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $email = $_POST['email'];
    $phoneNumber = $_POST['phoneNumber'];
    $about = $_POST['about'];
    $sql = "INSERT INTO fac_contact (firstName, lastName, email, phoneNumber, about) VALUES (:firstName, :lastName, :email, :phoneNumber, :about)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("firstName", $firstName);
        $stmt->bindParam("lastName", $lastName);
        $stmt->bindParam("phoneNumber", $phoneNumber);
        $stmt->bindParam("email", $email);
        $stmt->bindParam("about", $about);
        $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    if (!isset($response["status"])) {
        $response["status"] = SUCCESS;
        $response["data"] = true;
    }
    sendResponse($response);
}

include 'xkcd.php';

$app->run();
