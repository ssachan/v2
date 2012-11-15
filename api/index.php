<?php
header("Access-Control-Allow-Origin: *");
require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

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
$app->get('/l1Performance/:id', 'getL1Performance');
$app->get('/l2Performance/:id', 'getL2Performance');
$app->get('/historyById/:id', 'getQuizzesHistory');

//quiz
$app->get('/processQuiz/',$authenticate($app), 'processQuiz');

$app->get('/questions/',$authenticate($app), 'getQuestionsByIds');

$app->post('/responses', 'addResponse');

$app->get('/packagesByStreamId/:id', 'getPackagesByStreamId');

$app->post('/purchase/:id', 'addPurchase');

// the resets
$app->get('/resetResults/', 'resetResults');
$app->get('/resetResults/', 'resetResults');

function getFac($id){
    $sql = "select * from faculty where id=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $fac = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if (!isset($_GET['callback'])) {
            echo json_encode($fac);
        } else {
            echo $_GET['callback'] . '(' . json_encode($fac) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getLastQuizzes($id){
    $sql = "select * from faculty where id=:id";
    //$sql = "SELECT * from section_l1 where streamId=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $fac = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        if (!isset($_GET['callback'])) {
            echo json_encode($fac);
        } else {
            echo $_GET['callback'] . '(' . json_encode($l1) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getFollowers($id){
    $sql = "select * from faculty where id=:id";
    //$sql = "SELECT * from section_l1 where streamId=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $fac = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        if (!isset($_GET['callback'])) {
            echo json_encode($fac);
        } else {
            echo $_GET['callback'] . '(' . json_encode($l1) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}
function getL1ByStream($id) {
	$sql = "select * from section_l1 where streamId=:id";
	//$sql = "SELECT * from section_l1 where streamId=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$l1 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($l1);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l1) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getL2ByStream($id) {
	$sql = "select * from section_l2 where streamId=:id";
	//$sql = "SELECT * from section_l1 where streamId=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$l2 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($l2);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l2) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getL3ByStream($id) {
	//echo "Getting Questions<br />";
	$sql = "SELECT * from section_l3 where streamId=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$l3 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo json_encode($l3);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l3) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}


function getL1Performance($id) {
	$ids = explode("|", $id);
	$sql = "select a.l1Id as id, a.score,MAX(a.updatedOn) as updatedOn from ascores_l1 a where a.accountId=:accountId and streamId=:streamId group by l1Id";
	//$sql = "select l.id,l.displayName,T.score from section_l1 l LEFT JOIN (select a.l1Id, a.score,MAX(a.updatedOn) from ascores_l1 a where a.accountId=:id and streamId='1' group by l1Id) as T on l.id=T.l1Id where l.streamId='1'";
	//$sql = "SELECT * from section_l1 where streamId=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $ids[0]);
		$stmt->bindParam("streamId", $ids[1]);
		$stmt->execute();
		$l1 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($l1);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l1) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getL2Performance($id) {
	$ids = explode("|", $id);
	$sql = "select a.l2Id as id, a.score,MAX(a.updatedOn) as updatedOn from ascores_l2 a where a.accountId=:accountId and streamId=:streamId group by a.l2Id";
	// $sql = "select l.id,l.displayName,T.score,l.l1Id from section_l2 l LEFT JOIN (select a.l2Id, a.score,MAX(a.updatedOn) from ascores_l2 a where a.accountId=:id and streamId='1' group by a.l2Id) as T on l.id=t.l2Id where l.streamId='1'";
	//$sql = "select l.id,l.displayName,l.l1Id,l.streamId,a.streamId as st, a.score from section_l2 l LEFT JOIN ascores_l2 a ON a.l2Id=l.id where l.streamId=1 and (a.streamId IS NULL OR a.streamId=1) order by l.l1Id ";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $ids[0]);
		$stmt->bindParam("streamId", $ids[1]);
		$stmt->execute();
		$l2 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($l2);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l2) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuizzesByStreamId($id) {
	$sql = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.rec,q.conceptsTested, q.l2Ids, q.l3Ids, f.firstName,f.lastName from quizzes q, faculty f where q.facultyId=f.id and q.streamId=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($quizzes);
		} else {
			echo $_GET['callback'] . '(' . json_encode($quizzes) . ');';
		}
		//echo json_encode($quizzes);
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuizzesByFac($id) {
    $ids = explode("|", $id);
    $sql = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.rec,q.conceptsTested, q.tags from quizzes q where q.facultyId=:facId and q.streamId=:streamId";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("facId", $ids[0]);
        $stmt->bindParam("streamId", $ids[1]);
        $stmt->execute();
        $quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        if (!isset($_GET['callback'])) {
            echo json_encode($quizzes);
        } else {
            echo $_GET['callback'] . '(' . json_encode($quizzes) . ');';
        }
        //echo json_encode($quizzes);
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getFacByStreamId($id) {
	$sql = "select * from faculty where streamIds like '%".$id."' or streamIds like '".$id."%' or streamIds like '%|:".$id."|:%'";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$stmt->execute();
		$quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($quizzes);
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getFacById($id) {
    $sql = "select * from faculty where id=:id";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $stmt->execute();
        $quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo json_encode($quizzes);
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getQuestions($qids){
    $qids = explode("|:", $qids);
    $sql = "SELECT * from questions where id IN(".implode(",", $qids).")";
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

function getQuestionsByIds(){
    $qids = $_GET['qids'];
    
    $questions = getQuestions($qids) ;
    if (!isset($_GET['callback'])) {
        echo json_encode($questions);
    } else {
        echo $_GET['callback'] . '(' . json_encode($questions) . ');';
    }
}

/**
 * The function where the quiz processing takes place. We check for all the 
 * packages available and then substract from the appropriate one.
 * 
 */
function processQuiz(){
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
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
    if($count->count==0){
        // this quiz hasn't been taken go ahead and fetch the questions
        $sql = "SELECT questionIds FROM quizzes where id=:id";
        try {
            $db = getConnection();
            $stmt = $db->prepare($sql);
            $stmt->bindParam("id", $quizId);
            $stmt->execute();
            $questionIds = $stmt->fetchObject();
            $db = null;
            if($questionIds->questionIds!=null){
                $questions = getQuestions($questionIds->questionIds) ;
                if (!isset($_GET['callback'])) {
                    echo json_encode($questions);
                } else {
                    echo $_GET['callback'] . '(' . json_encode($questions) . ');';
                }
            }
        } catch(PDOException $e) {
            echo '{"error":{"text":'. $e->getMessage() .'}}';
        }
    }else{
        $msg = "Quiz already taken";
        echo '{"error":{"text":'. $msg .'}}';
    }
}

/**
 * some dummy logic to update the scores. 
 */
function updateScores($accId, $streamId){
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
	} catch(PDOException $e) {
	    echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
}

function addResponse() {
	// error_log('addWine\n', 3, '/var/tmp/php.log');
	//$request = Slim::getInstance()->request();
	//$response = json_decode($request->getBody());
	$date = date("Y-m-d H:i:s", time());
	//$ids = explode("|", $response->accountId);
	$streamId = $_POST['streamId'];
	$accountId = $_POST['accountId'];
	$quizId =  $_POST['quizId'];
	$score = $_POST['score'];
	$selectedAnswers = stripslashes($_POST['selectedAnswers']);
	$timePerQuestion = $_POST['timePerQuestion'];
	$sql = "INSERT INTO results (accountId, quizId, selectedAnswers, score, timePerQuestion, timestamp) VALUES (:accountId, :quizId, :selectedAnswers, :score, :timePerQuestion, :timeStamp)";
	//echo $sql;
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $accountId);
		$stmt->bindParam("quizId", $quizId);
		//$stmt->bindParam("questionId", $response->questionId);
		$stmt->bindParam("selectedAnswers", $selectedAnswers);
	    $stmt->bindParam("score", $score);
		$stmt->bindParam("timePerQuestion", $timePerQuestion);
		$stmt->bindParam("timeStamp", $date);
		$stmt->execute();
		//$response->id = $db->lastInsertId();
		$db = null;
		//echo json_encode($response);
	} catch (PDOException $e) {
		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		//echo '{"error":{"text":' . $e->getMessage() . '}}';
	}

	$sql2 = "UPDATE quizzes SET totalAttempts=totalAttempts+1 where id=:quizId";	
	try {
	    $db = getConnection();
		$stmt = $db->prepare($sql2);
		$stmt->bindParam("quizId", $response->quizId);
		$stmt->execute();	    
		$response->id = $db->lastInsertId();
		$db = null;
		//echo json_encode($response->id);
	} catch(PDOException $e) {
	    //echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
	
    /*$sql3 = "UPDATE students SET ascoreL1=ascoreL1+1 where accountId=:accountId and streamId=:streamId";	
	try {
	    $db = getConnection();
		$stmt = $db->prepare($sql3);
		$stmt->bindParam("accountId", $ids[0]);
		$stmt->bindParam("streamId", $ids[1]);
		$stmt->execute();	    
		$db = null;
		///$response->id = $db->lastInsertId();
	    echo json_encode($response);
	} catch(PDOException $e) {
	    echo '{"error":{"text":'. $e->getMessage() .'}}';
	}*/
}

function getQuizzesHistory($id){
	$ids = explode("|", $id);
	$sql = "select r.selectedAnswers,r.timePerQuestion,r.score,q.* from results r,quizzes q where accountId=:accountId and q.streamId=:streamId and r.quizId=q.id order by timestamp";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $ids[0]);
		$stmt->bindParam("streamId", $ids[1]);
		$stmt->execute();
		$l2 = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if (!isset($_GET['callback'])) {
			echo json_encode($l2);
		} else {
			echo $_GET['callback'] . '(' . json_encode($l2) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuiz($id) {
	echo "Getting Test $id <br />";
	$sql = "SELECT * from quizzes where id='$id'";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$projects = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo json_encode($projects);
		} else {
			echo $_GET['callback'] . '(' . json_encode($projects) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuizzes() {
	$sql = "SELECT * from quizzes";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$projects = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo json_encode($projects);
		} else {
			echo $_GET['callback'] . '(' . json_encode($projects) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getPackagesByStreamId($id){
    $sql = "SELECT p.id as id,p.name,p.details,p.price,t.name from packages p, package_type t where p.streamId='".$id."' AND p.type=t.id";
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
        return ;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
};

function resetResults() {
    $sql = "TRUNCATE table results  ";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $projects = $stmt->execute();
        $db = null;
        // Include support for JSONP requests
        if (!isset($_GET['callback'])) {
            echo json_encode($projects);
        } else {
            echo $_GET['callback'] . '(' . json_encode($projects) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function resetUsers() {
    $sql = "TRUNCATE table students";
    
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $projects = $stmt->execute();
        $db = null;
        // Include support for JSONP requests
        if (!isset($_GET['callback'])) {
            echo json_encode($projects);
        } else {
            echo $_GET['callback'] . '(' . json_encode($projects) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

include 'xkcd.php';

$app->run();
