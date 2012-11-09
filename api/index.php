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

$app->get('/quizzes/', 'getQuizzes');
$app->get('/quizzes/:id', 'getQuiz');

$app->get('/questions/', 'getQuestions');
$app->get('/questions/:id', 'getQuestion');
$app->post('/getQuestions/', 'getQ');

$app->get('/l3/', 'getL3');

$app->post('/responses/', 'addResponse');

$app->get('/quizzesByStreamId/:id', 'getQuizzesByStreamId');

$app->get('/quizzesByFac/:id', 'getQuizzesByFac');

$app->get('/facByStreamId/:id', 'getFacByStreamId');

$app->get('/fac/:id', 'getFac');

$app->get('/questionByQuizId/:id', 'getQuestionByQuizId');

$app->get('/l1Performance/:id', 'getL1Performance');

$app->get('/l2Performance/:id', 'getL2Performance');

$app->get('/l1ByStream/:id', 'getL1ByStream');

$app->get('/l2ByStream/:id', 'getL2ByStream');

$app->get('/l3ByStream/:id', 'getL3ByStream');

$app->get('/historyById/:id', 'getQuizzesHistory');

$app->get('/getAccount/:id', 'getAccount');

$app->get('/resetDB/', 'resetDB');

function getAccount($id){
	$ids = explode("|", $id);
    $sql = "select a.id as id,a.userName, a.firstName,a.lastName,a.email,s.* from accounts a, students s where a.id= s.accountId and s.streamId=:streamId and a.userName=:userName";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("userName", $ids[0]);
        $stmt->bindParam("streamId", $ids[1]);
        $stmt->execute();
        $account = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        if (!isset($_GET['callback'])) {
            echo json_encode($account);
        } else {
            echo $_GET['callback'] . '(' . json_encode($account) . ');';
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function getFac($id){
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
	$request = Slim::getInstance()->request();
	$response = json_decode($request->getBody());
	$date = date("Y-m-d H:i:s", time());
	$ids = explode("|", $response->accountId);
	$sql = "INSERT INTO results (accountId, quizId, selectedAnswers, score, timePerQuestion, timestamp) VALUES (:accountId, :quizId, :selectedAnswers, :score, :timePerQuestion, :timeStamp)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("accountId", $ids[0]);
		$stmt->bindParam("quizId", $response->quizId);
		//$stmt->bindParam("questionId", $response->questionId);
		$stmt->bindParam("selectedAnswers", $response->selectedAnswers);
		$stmt->bindParam("score", $response->score);
		$stmt->bindParam("timePerQuestion", $response->timePerQuestion);
		$stmt->bindParam("timeStamp", $date);
		$stmt->execute();
		$response->id = $db->lastInsertId();
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
		$db = null;
		$response->id = $db->lastInsertId();
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

/**
 * the post method
 */
function getQ() {
    //echo "Getting Questions<br />";
    $request = Slim::getInstance()->request();
    $response = json_decode($request->getBody());
    $sql = "SELECT * from questions where id IN(".implode(",", $response).")";
    //echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo json_encode($questions);
        /*if (!isset($_GET['callback'])) {
            echo json_encode($projects);
        } else {
            echo $_GET['callback'] . '(' . json_encode($projects) . ');';
        }*/
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}


function getQuestions() {
    //$request = $_GET['id']
    //echo "hello";
    $re = $app->request()->get('data');
    echo $re;
    //$response = json_decode($app->request()->get('data'));
    //echo $response;
    //$response = json_decode( $_GET['data']);
    //$sql = "SELECT * from questions where id IN(".implode(",", $response).")";
    //echo $sql;
    
	//echo "Getting Questions<br />";
	/*$sql = "SELECT * from questions where availableFlag='1'";
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
	}*/
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

function resetDB() {
    //echo "Getting Questions<br />";
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




include 'xkcd.php';

$app->run();
