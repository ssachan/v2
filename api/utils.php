<?php

/**
 * helper methods for server side
 */

/**
 * ensure that the resources are correctly set in questions
 */
function sanitizeQuestions() {
    $sql = "SELECT * FROM questions where id='" . $id . "'";
    echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo "\n \n Outputting question text ----====";
        echo json_encode($questions[0]->text);
        echo "\n \n Outputting option text ----====";
        echo json_encode($questions[0]->options);
        echo "\n \n Outputting description text ----====";
        echo json_encode($questions[0]->explanation);
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}


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

// the resets
$app->get('/resetResults/', 'resetResults');

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

$app->get('/testq/:id', 'testQuestion');

function testQuestion($id) {
    $sql = "SELECT * FROM questions where id='" . $id . "'";
    echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo "\n \n Outputting question text ----====";
        echo json_encode($questions[0]->text);
        echo "\n \n Outputting option text ----====";
        echo json_encode($questions[0]->options);
        echo "\n \n Outputting description text ----====";
        echo json_encode($questions[0]->explanation);
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}