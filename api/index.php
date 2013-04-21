<?php
header("Access-Control-Allow-Origin: *");
// set timezones
date_default_timezone_set('Asia/Calcutta');
require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

include 'helper.php';
include 'authState.php';

// the L1,L2,L3
$app->get('/topics/:level/:id', 'getTopics');

//quiz library
$app->get('/quizzesByStreamId/:id', 'getQuizzesByStreamId');

//questions
$app->get('/question/:id', 'getQuestion');

// the fac pages
$app->get('/facByStreamId/:id', 'getFacByStreamId');
$app->get('/fac/:id', 'getFac');
$app->get('/quizzesByFac/:id', 'getQuizzesByFac');
$app->post('/facContact/', 'facContact');

//dashboard page
$app->get('/scores/:level', $authenticate($app), 'getScores');
$app->get('/historyById/', $authenticate($app), 'getQuizzesHistory');
$app->get('/pq/:id', $authenticate($app), 'getPQ');

//quiz
$app->post('/attemptedAs/', 'updateAttemptedAs');
$app->get('/processQuiz/', $authenticate($app), 'processQuiz');
$app->get('/getVideos/', $authenticate($app), 'videoList');

// responses
$app->post('/submitQuiz', 'updateResultsForTest');
$app->post('/submitPractice', 'processPractice');

$app->get('/testcode', 'testCode');
$app->get('/testcode1/:id', 'testcode1');

$app->get('/attemptedQuestions/', 'getAttemptedQuestions');

//testing
$app->get('/testDelta', 'testDelta');
$app->post('/reco/', 'makeRecos');

//packages
$app->get('/packagesByStreamId', 'getPackagesByStreamId');
$app->post('/purchase', 'purchasePackage');

// add recos for quizzes and faculty
$app->post('/addQuizReco', 'addQuizReco');
$app->post('/addFacReco', 'addFacReco');

define('SUCCESS', "success"); // returns the requested data.
define('FAIL', "fail"); // logical error.
define('ERROR', "error"); // system error.
define('EXCEPTION_MSG', "Something went wrong. Please send an email to ..."); // system error.

define('DP_PATH', "../resources/accounts/"); // DP PATH.


define('EBS_ACC_ID', '12274'); // free tests
define('EBS_KEY', '240827f49a38d4bd4444323d55ebcc58'); // free tests
define('EBS_RETURN_URL', 'http://prepsquare.com/app/api/response.php?DR={DR}'); // free tests

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

function getTopics($level, $id) {
    $response = array();
    $sql = "SELECT * from section_" . $level . " where streamId=:id";
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

function getScores($level) {
    $response = array();
    $accountId = $_GET['accountId'];
    $streamId = $_GET['streamId'];
    $sql = "select *, " . $level
            . "id as id, MAX(updatedOn) as timeUpdated from ascores_" . $level
            . " a where a.accountId=:accountId and streamId=:streamId group by "
            . $level . "Id";

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
    $sql = "select r.selectedAnswers,r.timePerQuestion,r.score,r.startTime,r.state, r.attemptedAs,r.numCorrect,r.numIncorrect, q.*, (select count(*) as count from quiz_recos where quizId=q.id) as rec, a.id as fid, a.firstName,a.lastName,f.bioShort,f.education from results r,quizzes q,accounts a,faculty f where r.accountId=:accountId and q.streamId=:streamId and r.quizId=q.id and q.facultyId=a.id and q.available<>0 and f.accountId=a.id order by timestamp";
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
    $sql = "select q.*, (select count(*) as count from quiz_recos where quizId=q.id) as rec, a.id as fid, a.firstName,a.lastName,f.bioShort,f.education from quizzes q, accounts a, faculty f where q.facultyId=a.id and q.streamId=:id and f.accountId=a.id and q.available<>0 order by q.available,q.id";
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
    $sql = "select a.id as id, a.firstName,a.lastName,f.*,(select count(*) as count from fac_recos where facId=a.id) as rec,(select count(*) as count from quizzes where facultyId=a.id) as totalQuizzes  from faculty f,accounts a where (f.streamIds like '%"
            . $id . "' or f.streamIds like '" . $id
            . "%' or f.streamIds like '%|:" . $id
            . "|:%') and a.id=f.accountId and a.roles='3'";
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
    $sql = "select a.id as id,a.firstName,a.lastName,f.*,(select count(*) as count from fac_recos where facId=a.id) as rec,(select count(*) as count from quizzes where facultyId=a.id) as totalQuizzes from faculty f, accounts a where a.id=:id and a.id=f.accountId";
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
    $sql = "select q.*,(select count(*) as count from quiz_recos where quizId=q.id) as rec from quizzes q where q.facultyId=:facId and q.streamId=:streamId order by q.available,q.id";
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

function getQuestion($id) {
    $response = array();
    $accountId = $_GET['accountId'];
    $sql = "SELECT q.*,r.optionSelected,r.timeTaken,p.id as paraId, p.text as para from questions q left join para p on (p.id=q.paraId) left join responses r on (q.id=r.questionId) where q.id=:qId and r.accountId=:accountId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("qId", $id);
        $stmt->bindParam("accountId", $accountId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if ($record) {
            $response["status"] = SUCCESS;
            $response["data"] = $record;
        } else {
            $response["status"] = FAIL;
            $response["data"] = "No record found";
        }
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    sendResponse($response);
}

function getQuestions($qids) {
    $qids = explode("|:", $qids);
    $sql = "SELECT q.*,p.id as paraId, p.text as para from questions q left join para p on (p.id=q.paraId) where q.id IN("
            . implode(",", $qids) . ")";
    //echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        return $questions;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

function getQuestionIdsByQuiz($quizId) {
    $response = array();
    // for now just return the questions from the quiz if quiz is not a part of the history.
    $sql = "SELECT questionIds FROM quizzes where id=:quizId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("quizId", $quizId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        //echo $record;
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    if ($record->questionIds) {
        $qIdArray = explode("|:", $record->questionIds);
        return $qIdArray;
    }
}

function updateAttemptedAs() {
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

function getAttemptedQuestions() {
    $response = array();
    $accountId = $_GET['accountId'];
    $streamId = $_GET['streamId'];
    $sql = "select r.optionSelected,r.timeTaken,q.* from responses r,questions q where r.accountId=:accountId and r.questionId=q.Id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        //$stmt->bindParam("streamId", $streamId);
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

/**
 * The function where the quiz processing takes place. We check for all the 
 * packages available and then substract from the appropriate one.
 * 
 */
function processQuiz() {
    $response = array();
    $sucessData = array();
    $response['data'] = array();
    $accountId = $_GET['accountId'];
    $quizId = $_GET['quizId'];
    $streamId = $_GET['streamId'];
    $date = date("Y-m-d H:i:s", time());
    //check if the quiz has already been taken. 

    $sqlArray = array("accountId" => $accountId, "quizId" => $quizId);

    $sqlArray["SQL"] = "SELECT count(*) as count FROM results where quizId=:quizId and accountId=:accountId";
    $count = doSQL($sqlArray, true);
    if ($count->count == 0) {
        // this quiz hasn't been purchased.
        // check if that account has credits by reading the quizzesRemaining.
        $sqlArray = array("accountId" => $accountId, "streamId" => $streamId);
        $sqlArray["SQL"] = "SELECT quizzesRemaining from students where accountId=:accountId and streamId=:streamId";
        $record = doSQL($sqlArray, true);

        $quizzesRemaining = intval($record->quizzesRemaining);
        if ($quizzesRemaining <= 0) {
            // there are no credits
            $response["status"] = FAIL;
            $response["data"] = "You don't have enough credits. Please purchase a package from the purchase page";
            sendResponse($response);
            return;
        }

        $sqlArray["SQL"] = "UPDATE students SET quizzesRemaining=(quizzesRemaining-1) where accountId=:accountId and streamId=:streamId";
        doSQL($sqlArray, false);

        $sqlArray = array("accountId" => $accountId, "startTime" => $date,
                "quizId" => $quizId);
        $sqlArray["SQL"] = "INSERT INTO results (accountId, quizId, startTime) VALUES (:accountId, :quizId, :startTime)";
        doSQL($sqlArray, false);

        // update auizzesAttempted 
        // tanujb:TODO: quizzes attempted should come from elsewhere?
        $sqlArray = array("accountId" => $accountId, "streamId" => $streamId);
        $sqlArray["SQL"] = "SELECT quizzesAttempted from students where accountId=:accountId and streamId=:streamId";
        $record = doSQL($sqlArray, true);
        if ($record->quizzesAttempted == null)
            $quizzesAttempted = array();
        else
            $quizzesAttempted = json_decode($record->quizzesAttempted);

        if (!(in_array($quizId, $quizzesAttempted)))
            array_push($quizzesAttempted, $quizId);

        $quizzesAttemptedJson = json_encode($quizzesAttempted);
        array_pop($sqlArray);
        $sqlArray["quizzesAttempted"] = $quizzesAttemptedJson;
        $sqlArray["SQL"] = "UPDATE students SET quizzesAttempted=:quizzesAttempted where accountId=:accountId and streamId=:streamId";
        doSQL($sqlArray, false);

        $sqlArray = array("streamId" => $streamId, "quizId" => $quizId);
        $sqlArray["SQL"] = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.allotedTime,q.maxScore,q.conceptsTested, q.l2Ids, q.l3Ids, q.typeId, a.id as fid, a.firstName,a.lastName,f.bioShort from quizzes q, accounts a, faculty f where q.facultyId=a.id and q.streamId=:streamId and f.accountId=a.id and q.id=:quizId";
        $sucessData['quiz'] = doSQL($sqlArray, true);
    } else {
        // this quiz has been purchased before. It either is an ongoing or completed
        $sqlArray = array("accountId" => $accountId, "streamId" => $streamId,
                "quizId" => $quizId);
        $sqlArray["SQL"] = "select r.selectedAnswers,r.timePerQuestion,r.score,r.startTime,r.state, r.attemptedAs, r.numCorrect, r.numIncorrect, q.*,a.id as fid, a.firstName,a.lastName,f.bioShort from results r,quizzes q,accounts a,faculty f where r.accountId=:accountId and q.streamId=:streamId and r.quizId=q.id and q.facultyId=a.id and f.accountId=a.id and r.quizId=:quizId";
        $sucessData['quiz'] = doSQL($sqlArray, true);
        // you have already taken this quiz, this seems to be a call for fetching questions 
        // for the results
    }
    $sqlArray = array("quizId" => $quizId);
    $sqlArray["SQL"] = "SELECT questionIds FROM quizzes where id=:quizId";
    $questionIds = doSQL($sqlArray, true)->questionIds;

    if ($questionIds != null) {
        $questions = getQuestions($questionIds);
        $sucessData["questions"] = $questions;
        $response["status"] = "success";
        $response["data"] = $sucessData;
    } else {
        $response["status"] = "fail";
        $response["data"] = "Something went wrong! Please drop in an email to admin@prepsquare.com";
    }
    sendResponse($response);
}

/**
 * some dummy logic to update the scores. 
 */

function getPackagesByStreamId() {
    $sql = "SELECT * from packages p where p.streamId=:streamId";
    //echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("streamId", $_GET['streamId']);
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

function updateQuizzesRemaining($number, $accountId, $streamId) {
    $response = array();
    $sql = "SELECT quizzesRemaining from students where accountId=:accountId and streamId=:streamId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $quizzesRemaining = intval($record->quizzesRemaining);
        $quizzesRemaining += $number;
        $sql = "UPDATE students SET quizzesRemaining=:quizzesRemaining where accountId=:accountId and streamId=:streamId";
        try {
            $db = getConnection();
            $stmt = $db->prepare($sql);
            $stmt->bindParam("quizzesRemaining", $quizzesRemaining);
            $stmt->bindParam("accountId", $accountId);
            $stmt->bindParam("streamId", $streamId);
            $stmt->execute();
            $db = null;
        } catch (PDOException $e) {
            $response["status"] = ERROR;
            $response["data"] = EXCEPTION_MSG;
            phpLog($e->getMessage());
        }
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    if (array_key_exists("status", $response) != ERROR) {
        $response["status"] = SUCCESS;
        $response["data"] = $quizzesRemaining;
    }
    return $response;
}

function purchasePackage() {
    $response = array();
    $date = date("Y-m-d H:i:s", time());
    $streamId = $_POST['streamId'];
    $accountId = $_POST['accountId'];
    $sql = "INSERT INTO purchases (accountId, packageId, purchasedOn) VALUES (:accountId, :packageId, :purchasedOn);";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("packageId", $_POST['packageId']);
        $stmt->bindParam("purchasedOn", $date);
        $stmt->execute();
        echo $app->render('pay.php', array('id' => '1'));
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
        sendResponse($response);
    }
    // get the number to be added
    /*$sql = "SELECT number from packages where id=:packageId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("packageId", $_POST['packageId']);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $number = intval($record->number);
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
        sendResponse($response);
    }
    $response = updateQuizzesRemaining($number, $accountId, $streamId);
    // get the current number of packages
    sendResponse($response);
     */
}

function addQuizReco() {
    $response = array();
    $sqlArray = array("accountId" => $_POST['accountId'],
            "quizId" => $_POST['quizId']);
    $sqlArray["SQL"] = "select count(*) as count FROM quiz_recos where quizId=:quizId and accountId=:accountId";
    doSQL($sqlArray, true);
    $count = doSQL($sqlArray, true);
    if ($count->count == 0) {
        // not recommended before
        $sqlArray = array("accountId" => $_POST['accountId'],
                "quizId" => $_POST['quizId']);
        $sqlArray["SQL"] = "INSERT INTO quiz_recos (quizId, accountId) VALUES (:quizId, :accountId)";
        doSQL($sqlArray, false);
        /*$sqlArray = array("accountId"=>$_POST[accountId], "quizId"=>$_POST[quizId] );
        $sqlArray["SQL"] = "INSERT INTO quiz_recos (quizId, accountId) VALUES (:quizId, :accountId)";
        doSQL($sqlArray,false);*/
        $response["status"] = SUCCESS;
        $response["data"] = "Thanks for recommending this quiz.";
    } else {
        // aready recommended
        $response["status"] = FAIL;
        $response["data"] = "Already recommended by you.";
    }
    sendResponse($response);
}

function addFacReco() {
    $response = array();
    $sqlArray = array("accountId" => $_POST['accountId'],
            "facId" => $_POST['facId']);
    $sqlArray["SQL"] = "select count(*) as count FROM fac_recos where facId=:facId and accountId=:accountId";
    doSQL($sqlArray, true);
    $count = doSQL($sqlArray, true);
    if ($count->count == 0) {
        // not recommended before
        $sqlArray = array("accountId" => $_POST['accountId'],
                "facId" => $_POST['facId']);
        $sqlArray["SQL"] = "INSERT INTO fac_recos (facId, accountId) VALUES (:facId, :accountId)";
        doSQL($sqlArray, false);
        /*$sqlArray = array("accountId"=>$_POST[accountId], "quizId"=>$_POST[quizId] );
         $sqlArray["SQL"] = "INSERT INTO quiz_recos (quizId, accountId) VALUES (:quizId, :accountId)";
        doSQL($sqlArray,false);*/
        $response["status"] = SUCCESS;
        $response["data"] = "Thanks for recommending this faculty.";
    } else {
        // aready recommended
        $response["status"] = FAIL;
        $response["data"] = "Already recommended by you.";
    }
    sendResponse($response);
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

/*$app->get("/response", function () use ($app) {
    $secret_key = "ebskey";	 // Your Secret Key
    if(isset($_GET['DR'])) {
        require('pay/Rc43.php');
        $DR = preg_replace("/\s/","+",$_GET['DR']);
    
        $rc4 = new Crypt_RC4($secret_key);
        $QueryString = base64_decode($DR);
        $rc4->decrypt($QueryString);
        $QueryString = split('&',$QueryString);
    
        $response = array();
        foreach($QueryString as $param){
            $param = split('=',$param);
            $response[$param[0]] = urldecode($param[1]);
            echo $response[$param[0]];
        }
    }
});
*/    
    
$app->get('/pay/:id', $authenticate($app) ,function ($id) use ($app) {
    // insert to get the purchaseId
    $response = array();
    $date = date("Y-m-d H:i:s", time());
    $streamId = '1';
    $accountId = $_SESSION['user'];
    $packageId = $id;
    $mode = 'LIVE';
    // first get the account information and the price of the package
    $sql = "select * from account where id=:id";
    // first get the amount and the number 
    $sql = "INSERT INTO purchases (accountId, packageId, purchasedOn) VALUES (:accountId, :packageId, :purchasedOn);";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("packageId", $packageId);
        $stmt->bindParam("purchasedOn", $date);
        $stmt->execute();
        $referenceNo = $db->lastInsertId();
        $db = null;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
        sendResponse($response);
    }
    //get the package details
    $sql = "SELECT * from packages where id=:packageId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("packageId", $packageId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $numQuizzes = intval($record->number);
        $amount = intval($record->price);
        $description = $record->displayName;
     } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
        sendResponse($response);
    }
    
    $sql = "SELECT firstName from accounts where id=:accountId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $name = $record->firstName;
    } catch (PDOException $e) {
        $response["status"] = ERROR;
        $response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
        sendResponse($response);
    }
    // get the account
    $hash = EBS_KEY."|".EBS_ACC_ID."|".$amount."|".$referenceNo."|".EBS_RETURN_URL."|".$mode;
    $secure_hash = md5($hash);
    //$response = updateQuizzesRemaining($number, $accountId, $streamId);
    // get the current number of packages
    //sendResponse($response);
    $app->render('pay.php', array('reference_no' => $referenceNo, 'description'=>$description, 'number'=>$numQuizzes,
            'account_id' => EBS_ACC_ID,'amount' =>$amount, 'secure_hash'=>$secure_hash,'return_url'=>EBS_RETURN_URL,'name'=>$name));
});

include 'xkcd.php';
include 'analytics.php';

$app->run();
