<?php
include 'resources/sendgrid-php/SendGrid_loader.php';

/**
 * Helper functions
 */

$app->get('/mail', 'testMail');

function doSQL($params,$returnsData,$fetchAs = "obj",$callBack = ""){   /*
    $firephp = FirePHP::getInstance(true);
    $firephp->log($params, "SQL:");*/
    $sql = array_pop($params);
    try{
        $db   = getConnection();
        $stmt = $db->prepare($sql);
        foreach ($params as $key => $value) {
            $stmt->bindValue(":".$key,$value);
        }
        $stmt->execute();
        $db = null;
        if($returnsData === true)
            if($fetchAs === "obj")
            return $stmt->fetch(PDO::FETCH_OBJ);
        elseif($fetchAs === "all_array")
        return $stmt->fetchAll();
        elseif($fetchAs === "all_func")
        return $stmt->fetchAll(PDO::FETCH_FUNC,$callBack);
        elseif($fetchAs === "all_class")
        return $stmt->fetchAll(PDO::FETCH_CLASS,$callBack);
    }
    catch (PDOException $e) {
        //phpLog("doSqlError:".$sql.$e->getMessage());
        echo("doSqlError:".$sql.$e->getMessage());
    }
}

function sendEmail($to, $subject, $message) {
    $res = mail($to, $subject, $message);
    return $res;
}

function testMail(){
    echo 'hi';
    $sendgrid = new SendGrid('admin@prepsquare.com', 'Ptol3my1234');
    $mail = new SendGrid\Mail();
    $mail->
    addTo('shikhar.sachan@gmail.com')->
    setFrom('admin@prepsquare.com')->
    setSubject('Test Email')->
    setText('Hello World!')->
    setHtml('<strong>Hello World!</strong>');
    $sendgrid->smtp->send($mail);
}

function sendEmailSMTP() {
    require_once "/home/atestnqy/php/Mail.php";
    require_once "/home/atestnqy/php/Net/Socket.php";
    require_once "/home/atestnqy/php/Net/SMTP.php";

    $from = "shikhar@prepsquare.com";
    $to = "shikhar.sachan@gmail.com";
    $subject = "Hi!";
    $body = "test";

    $host = "ssl://smtp.gmail.com";
    $port = "465";
    $username = "shikhar@prepsquare.com"; //<> give errors
    $password = "****";

    $headers = array('From' => $from, 'To' => $to, 'Subject' => $subject);
    $smtp = Mail::factory('smtp', array('host' => $host, 'port' => $port,
            'auth' => true, 'username' => $username, 'password' => $password));

    $mail = $smtp->send($to, $headers, $body);

    if (PEAR::isError($mail)) {
        echo ("<p>" . $mail->getMessage() . "</p>");
    } else {
        echo ("<p>Message successfully sent!</p>");
    }
}

$app->get('/getQ/:id', 'getQ');

function getQ($id){
    $sql = "SELECT q.*,p.text as para from questions q left join para p on (p.id=q.paraId) where q.id=".$id.";";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $questions = $stmt->fetch(PDO::FETCH_OBJ);
        echo $questions->text;
        echo '<br>options:';
        echo $questions->options;
        echo '<br>explanation';
        echo $questions->explanation;
        
        echo '<br>1. Text:<br>';
        echo json_encode($questions->text);
        echo '<br>2. options:<br>';
        
        echo json_encode($questions->options);
        echo '<br>3. explanation:<br>';
                
        echo json_encode($questions->explanation);
        
        echo '<br>4. para:<br>';
        
        echo json_encode($questions->para);
        
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

$app->get("/delacc", function () use ($app) {
    $sqlArray = array("accountId"=>$accountId, "streamId"=>$streamId );
    $sqlArray["SQL"] = "SELECT quizzesRemaining from students where accountId=:accountId and streamId=:streamId";
    $record = doSQL($sqlArray,true);
    
});

