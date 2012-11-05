<?php
header("Access-Control-Allow-Origin: *");
require 'Slim/Slim.php';
$app = new Slim();

//GET route
/*
$app->get('/', function () {
    $template = "
<!DOCTYPE html>
    <html>
        <head>
            <meta charset='utf-8'/>
            <title>TestRex. Rawr at the CAT.</title>
            <style>
                html,body,div,span,object,iframe,
                h1,h2,h3,h4,h5,h6,p,blockquote,pre,
                abbr,address,cite,code,
                del,dfn,em,img,ins,kbd,q,samp,
                small,strong,sub,sup,var,
                b,i,
                dl,dt,dd,ol,ul,li,
                fieldset,form,label,legend,
                table,caption,tbody,tfoot,thead,tr,th,td,
                article,aside,canvas,details,figcaption,figure,
                footer,header,hgroup,menu,nav,section,summary,
                time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent;}
                body{line-height:1;}
                article,aside,details,figcaption,figure,
                footer,header,hgroup,menu,nav,section{display:block;}
                nav ul{list-style:none;}
                blockquote,q{quotes:none;}
                blockquote:before,blockquote:after,
                q:before,q:after{content:'';content:none;}
                a{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent;}
                ins{background-color:#ff9;color:#000;text-decoration:none;}
                mark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold;}
                del{text-decoration:line-through;}
                abbr[title],dfn[title]{border-bottom:1px dotted;cursor:help;}
                table{border-collapse:collapse;border-spacing:0;}
                hr{display:block;height:1px;border:0;border-top:1px solid #cccccc;margin:1em 0;padding:0;}
                input,select{vertical-align:middle;}
                html{ background: #EDEDED; height: 100%; }
                body{background:#FFF;margin:0 auto;min-height:100%;padding:0 30px;width:440px;color:#666;font:14px/23px Arial,Verdana,sans-serif;}
                h1,h2,h3,p,ul,ol,form,section{margin:0 0 20px 0;}
                h1{color:#333;font-size:20px;}
                h2,h3{color:#333;font-size:14px;}
                h3{margin:0;font-size:12px;font-weight:bold;}
                ul,ol{list-style-position:inside;color:#999;}
                ul{list-style-type:square;}
                code,kbd{background:#EEE;border:1px solid #DDD;border:1px solid #DDD;border-radius:4px;-moz-border-radius:4px;-webkit-border-radius:4px;padding:0 4px;color:#666;font-size:12px;}
                pre{background:#EEE;border:1px solid #DDD;border-radius:4px;-moz-border-radius:4px;-webkit-border-radius:4px;padding:5px 10px;color:#666;font-size:12px;}
                pre code{background:transparent;border:none;padding:0;}
                a{color:#70a23e;}
                header{padding: 30px 0;text-align:center;}
            </style>
        </head>
        <body>
            <h1>Welcome to TestRex!</h1>
            <a href='./questions'>Questions</a> <br />
            <a href='./quizzes'>tests</a> <br />
        </body>
    </html>
";
    echo $template;
});*/

//POST route
$app->post('/post', function () {
			echo 'This is a POST route';
		});

//PUT route
$app->put('/put', function () {
			echo 'This is a PUT route';
		});

//DELETE route
$app->delete('/delete', function () {
			echo 'This is a DELETE route';
		});

$app->get('/questions/', 'getQuestions');
$app->get('/questions/:id', 'getQuestion');

$app->get('/quizzes/', 'getQuizzes');
$app->get('/quizzes/:id', 'getQuiz');

$app->get('/questionsets/', 'getQuestionSets');
$app->get('/questionsets/:id', 'getQuestionSet');

$app->get('/practicetests/', 'getPracticeTests');
$app->get('/practicetests/:id', 'getPracticeTest');

$app->get('/flashcards/', 'getAllFlashCards');
$app->get('/flashcards/:id', 'getFlashCard');
$app->get('/flashcardlists/', 'getFlashCardLists');

$app->get('/l3/', 'getL3');

$app->get('/practicetests/', 'getPracticeTests');
$app->get('/practicetests/:id', 'getPracticeTest');
$app->get('/quizzes/sync/:uid', 'getSyncQuizIds');

$app->get('/quizzes/getnext/:accountId', 'getNextQuizzes');

$app->post('/responses/', 'addResponse');

$app->get('/getLastSync/:timestamp', 'getLastSync');

$app->get('/quizzesByStreamId/:id', 'getQuizzesByStreamId');

$app->get('/facByStreamId/:id', 'getFacByStreamId');

$app->get('/questionByQuizId/:id', 'getQuestionByQuizId');

$app->get('/l1Performance/:id', 'getL1Performance');

$app->get('/l2Performance/:id', 'getL2Performance');

$app->get('/l1ByStream/:id', 'getL1ByStream');

$app->get('/l2ByStream/:id', 'getL2ByStream');

$app->get('/l3ByStream/:id', 'getL3ByStream');

$app->get('/historyById/:id', 'getQuizzesHistory');

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
	$sql = "select q.id,q.questionIds,q.description,q.descriptionShort,q.difficulty,q.ratings,q.conceptsTested, q.tags, f.firstName,f.lastName from quizzes q, faculty f where q.facultyId=f.id and q.streamId=:id";
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

function getQuestionByQuizId($id) {
	$sql = "select * from questions where id IN(1,2,3,4,5,6,7,8,9)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		echo json_encode($quizzes);
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getLastSync($timestamp) {
	$sql = "SELECT quizId,optionsSelected,timeTaken from quizzes_pushed where accountId='1' and syncTimeStamp >"
			. $timestamp . " ; ";
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

/**
 * some dummy logic to update the scores. 
 */
function updateScores(){
    $sql = "SELECT quizId,optionsSelected,timeTaken from quizzes_pushed where accountId='1' and syncTimeStamp >"
            . $timestamp . " ; ";
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

function addResponse() {
	// error_log('addWine\n', 3, '/var/tmp/php.log');
	$request = Slim::getInstance()->request();
	$response = json_decode($request->getBody());
	$date = date("Y-m-d H:i:s", time());
	$sql = "INSERT INTO results (accountId, quizId, selectedAnswers, timePerQuestion, timestamp) VALUES (:accountId, :quizId, :selectedAnswers, :timePerQuestion, :timeStamp)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $response->accountId);
		$stmt->bindParam("quizId", $response->quizId);
		//$stmt->bindParam("questionId", $response->questionId);
		$stmt->bindParam("selectedAnswers", $response->selectedAnswers);
		$stmt->bindParam("timePerQuestion", $response->timePerQuestion);
		$stmt->bindParam("timeStamp", $date);
		$stmt->execute();
		$response->id = $db->lastInsertId();
		$db = null;
		echo json_encode($response);
	} catch (PDOException $e) {
		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}

	$qIds = explode("|:", $response->questionIds);
	$os = explode("|:", $response->optionsSelected);
	$tt = explode("|:", $response->timeTaken);
	$len = sizeof($qIds);
	for ($i = 0; $i < $len; $i++) {

		$sql = "INSERT INTO responses (accountId, quizId, questionId, optionSelected, timeTaken) VALUES (:accountId, :quizId, :questionId, :optionSelected, :timeTaken)";
		try {
			$db = getConnection();
			$stmt = $db->prepare($sql);
			$stmt->bindParam("accountId", $response->accountId);
			$stmt->bindParam("quizId", $response->quizId);
			$stmt->bindParam("questionId", $qIds[$i]);
			$stmt->bindParam("optionSelected", $os[$i]);
			$stmt->bindParam("timeTaken", $os[$i]);
			$stmt->execute();
			$response->id = $db->lastInsertId();
			$db = null;
			echo json_encode($response);
		} catch (PDOException $e) {
			error_log($e->getMessage(), 3, '/var/tmp/php.log');
			echo '{"error":{"text":' . $e->getMessage() . '}}';
		}
	}
}

function getQuizzesHistory($id){
	$ids = explode("|", $id);
	$sql = "select r.selectedAnswers,r.timePerQuestion,q.* from results r,quizzes q where accountId=:accountId and q.streamId=:streamId and r.quizId=q.id order by timestamp";
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

function objectToArray($object) {
	if (!is_object($object) && !is_array($object)) {
		return $object;
	}
	if (is_object($object)) {
		$object = get_object_vars($object);
	}
	return array_map('objectToArray', $object);
}

function generateQuizByUID($uid) {
	//quiz Generation Algorithm goes here
	$testIDs = array(1, 2, 3, 4, 5, 6);
	return $testIDs;

}

function getFlashCardLists() {
	$sql = "SELECT * from flash_cards_list";
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

function getSyncQuizIds($uid) {
	$sql = "SELECT id from quizzes WHERE accountid ='" . $uid . "'";
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

function getAllFlashCards() {
	$sql = "SELECT * from flash_cards";
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

function getFlashCard($id) {
	$sql = "SELECT * from flash_cards where id='$id'";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$projects = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo substr(json_encode($projects), 1,
					strlen(json_encode($projects)) - 2);
			//What fucking stupidity, 
			//if I don't implement workaround,
			//the attributes go into a subproperty. fucking shite. -TB.
			//echo json_encode($projects);

		} else {
			echo $_GET['callback'] . '(' . json_encode($projects) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getNextQuizzes($accountId) {

	$testIDs = generateQuizByUID($uid);
	$sql = "SELECT * from quizzes where id IN (" . implode(",", $testIDs) . ")";

	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$quizzes = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		$qListIDs = array();
		$qIDs = array();
		$question_sets_index = array();
		$output_quizzes = array();

		foreach ($quizzes as $quiz) {
			$qList = explode("|:", $quiz->question_list_ids);

			foreach ($qList as $tempqid) {
				$qListIDs[] = $tempqid;
			}
		}

		$sql2 = "select * from question_list where id IN ("
				. implode(",", $qListIDs) . ")";

		$db = getConnection();
		$stmt = $db->query($sql2);
		$question_sets = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		foreach ($question_sets as $question_set) {
			$qList = explode("|:", $question_set->question_id_list);

			$question_sets_index[$question_set->id] = $question_set;

			foreach ($qList as $tempqid) {
				$qIDs[] = $tempqid;
			}
		}

		$sql3 = "select * from questions where id IN (" . implode(",", $qIDs)
				. ")";

		$db = getConnection();
		$stmt = $db->query($sql3);
		$questions = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		$questions_index = array();

		foreach ($questions as $question) {
			$questions_index[$question->id] = $question;
		}

		foreach ($quizzes as $quiz) {

			$output_quiz["id"] = $quiz->id;
			$output_quiz["l1_id"] = $quiz->l1_id;
			$now = new DateTime('now');
			$output_quiz["send_time"] = $now->getTimestamp();
			$output_quiz["sync_time"] = $now->getTimestamp();
			$output_quiz["total_score"] = 0;

			$qListCollection = array();
			$qListIDMap = array(0);

			foreach (explode("|:", $quiz->question_list_ids) as $tempQListID) {
				$qListIDMap[$tempQListID] = $qListIDMap[0];
				$qListIDMap[0] += 1;

				$qListCollection[$qListIDMap[$tempQListID]] = objectToArray(
						$question_sets_index[$tempQListID]);
			}

			foreach ($qListCollection as $qList) {
				$questions_f = array();
				foreach (explode("|:", $qList["question_id_list"]) as $qid) {
					$questions_f[] = objectToArray($questions_index[$qid]);
				}
				$qListCollection[$qListIDMap[$qList["id"]]]["questions"] = $questions_f;
			}

			$output_quiz["questionLists"] = $qListCollection;
			$output_quizzes[] = $output_quiz;
		}

		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo json_encode($output_quizzes);
		} else {
			echo $_GET['callback'] . '(' . json_encode($output_quizzes) . ');';
		}

	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuestion($id) {
	//echo "Getting Question $id <br />";
	$sql = "SELECT * from questions where id='$id'";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$question = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// Include support for JSONP requests
		if (!isset($_GET['callback'])) {
			echo json_encode($question);
		} else {
			echo $_GET['callback'] . '(' . json_encode($question) . ');';
		}
	} catch (PDOException $e) {
		echo '{"error":{"text":' . $e->getMessage() . '}}';
	}
}

function getQuestions() {
	//echo "Getting Questions<br />";
	$sql = "SELECT * from questions where availableFlag='1'";
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

function getQuestionSet($id) {
	echo "Getting Test $id <br />";
	$sql = "SELECT * from question_sets where id='$id'";
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

function getQuestionSets() {
	$sql = "SELECT * from question_sets";
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

function getPracticeTest($id) {
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

function getPracticeTests() {
	$sql = "SELECT * from practice";
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

function getL2() {
	//echo "Getting Questions<br />";
	$sql = "SELECT * from section_l2 ";
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

include 'xkcd.php';

$app->run();
