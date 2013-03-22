<?php
include '../sendgrid-php/SendGrid_loader.php';

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

function sendMail($to, $subject, $message) {
    $sendgrid = new SendGrid('admin@prepsquare.com', 'Ptol3my1234');
    $mail = new SendGrid\Mail();
    $mail->
    addTo($to)->
    setFrom('Tanuj Bhojwani','tanuj@prepsquare.com>')->
    setSubject($subject)->setHtml($message);
    $sendgrid->smtp->send($mail);
}

function testMail(){
    echo 'hi';
    sendMail('shikhar.sachan@gmail.com','sub','<b>This is good</b><br>Lets see<br>break');
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

