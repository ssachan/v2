<?php

/*$config = array(
        'provider' => 'PDO',
        'dsn' => 'mysql:host=localhost;dbname=nero',
        'dbuser' => 'root',
        'dbpass' => 'trial',
        'auth.type' => 'form',
        'security.urls' => array(
                array('path' => '/test'),
                //array('path' => '/about/.+'),
        ),
);

$app->add(new StrongAuth($config));
*/

//require_once "Mail.php";

$app->add(new \Slim\Middleware\SessionCookie(array(
        'expires' => '2 minutes',
        'path' => '/',
        'domain' => null,
        'secure' => false,
        'httponly' => false,
        'name' => 'slim_session',
        'secret' => 'CHANGE_ME',
        'cipher' => MCRYPT_RIJNDAEL_256,
        'cipher_mode' => MCRYPT_MODE_CBC
)));

$authenticate = function ($app) {
    return function () use ($app) {
        if (!isset($_SESSION['user'])) {
           $app->redirect('../client/#login');
        }else {
            // If a user is not logged in at all, return a 401
            $app->halt(401, 'Dude, you aren\'t logged in...sign in, will you?');
        }
    };
};

function emailExists($email){
    $sql = "SELECT count(*) as count from accounts where email='".$email."'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $count = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        return $count[0]->count;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
};

function insertStudent($accountId, $streamId){
    $sql = "INSERT INTO students (accountId,streamId) VALUES (:accountId, :streamId)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
        $stmt->execute();
        return $response->id = $db->lastInsertId();
    } catch (PDOException $e) {
        error_log($e->getMessage(), 3, '/var/tmp/php.log');
    }
}

function sendEmail($content, $email){
    $from = "<from.gmail.com>";
    $to = $email;
    $subject = "Hi!";
    $body = $content;
    
    $host = "ssl://smtp.gmail.com";
    $port = "465";
    $username = "myaccount@gmail.com";  //<> give errors
    $password = "password";
    
    $headers = array ('From' => $from,
            'To' => $to,
            'Subject' => $subject);
    $smtp = Mail::factory('smtp',
            array ('host' => $host,
                    'port' => $port,
                    'auth' => true,
                    'username' => $username,
                    'password' => $password));
    
    $mail = $smtp->send($to, $headers, $body);
    
    if (PEAR::isError($mail)) {
        echo("<p>" . $mail->getMessage() . "</p>");
    } else {
        echo("<p>Message successfully sent!</p>");
    }
}
/*$app->hook('slim.before.dispatch', function() use ($app) {
    $user = null;
    if (isset($_SESSION['user'])) {
        $user = $_SESSION['user'];
    }
    $app->view()->setData('user', $user);
});*/

$app->post("/signup", function () use ($app) {
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $email =  $_POST['email'];
    $password = $_POST['password'];
    $streamId = $_POST['streamId'];
    
    if(emailExists($email) != 0){
        // email exists
        $msg = 'email already exists. you should probably try forgot password';
        echo '{"error":{"text":' . $msg . '}}';
        //return;
    }
    $sql = "INSERT INTO accounts (firstName,lastName,email,password, createdOn) VALUES (:firstName, :lastName, :email, :password, :createdOn)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("firstName", $firstName);
        $stmt->bindParam("lastName", $lastName);
        $stmt->bindParam("email", $email);
        $stmt->bindParam("password", $password);
        $stmt->bindParam("createdOn", date("Y-m-d H:i:s", time()));
        $stmt->execute();
        $response->id = $db->lastInsertId();
        $db = null;
        insertStudent($response->id, $streamId);
        $response->firstName = $firstName;
        $response->lastName = $firstName;
        $response->email = $firstName;
        $response->streamId = $streamId;
        $response->ascore = 0;
        $_SESSION['user'] = $email;
        echo json_encode($response);
    } catch (PDOException $e) {
        error_log($e->getMessage(), 3, '/var/tmp/php.log');
        //echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
});
    
$app->get("/logout", function () use ($app) {
    unset($_SESSION['user']);
    $app->redirect('../client/#login');
});

$app->post("/login", function () use ($app) {
    $email = $app->request()->post('email');    
    $password = $app->request()->post('password');
    $streamId = $app->request()->post('streamId');
    $sql = "SELECT a.id as id,a.email,a.firstName,a.lastName,s.ascoreL1 as ascore from accounts a,students s where a.email='".$email."' AND a.password='".$password."' AND s.streamId='".$streamId."' AND a.id=s.accountId";
    //echo $sql;
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $account = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        $_SESSION['user'] = $email;
        echo json_encode($account);
     } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
    $errors = array();    
});

$app->post("/forgotpass", function () use ($app) {
    
    $email=$_POST['email'];
    $email=mysql_real_escape_string($email);
    $status = "OK";
    $msg="";
    //error_reporting(E_ERROR | E_PARSE | E_CORE_ERROR);
    // You can supress the error message by un commenting the above line
    if (!stristr($email,"@") OR !stristr($email,".")) {
        $msg = 'email address is not correct';
        echo '{"error":{"text":' .$msg. '}}';
        $status= "NOTOK";
    }
    
    if($status=="OK"){  // validation passed now we will check the tables
        $query="SELECT email,password FROM accounts WHERE email = '$email'";
        try {
            $db = getConnection();
            $stmt = $db->query($sql);
            $account = $stmt->fetch(PDO::FETCH_OBJ);
            $db = null;
        } catch (PDOException $e) {
            echo '{"error":{"text":' . $e->getMessage() . '}}';
        }
        if ($account == NULL) { // No records returned, so no email address in our table
            // let us show the error message
            $msg = "Your email doesn't exist. You can signup and login to use our site";
            echo '{"error":{"text":' .$msg. '}}';
        }
        sendMail($email, "your password is ".$account->password.""); 
    } 
});
        
$app->get("/private/about", $authenticate($app), function () use ($app) {
    $app->render('privateAbout.php');
});

$app->get("/private/goodstuff", $authenticate($app), function () use ($app) {
    $app->render('privateGoodStuff.php');
});


/*
   // formating the mail posting
            // headers here
         /*   $headers="admin@sitename.com";  // Change this address within quotes to your address
            $headers.="Reply-to: $headers4\n";
            $headers .= "From: $headers4\n";
            $headers .= "Errors-to: $headers4\n";
            //$headers = "Content-Type: text/html; charset=iso-8859-1\n".$headers;// for html mail
            // mail funciton will return true if it is successful
            if(mail("$em","Your Request for login details","This is in response to your request for login detailst at
                site_name \n \nLogin ID: $row->userid \n
                Password: $row->password \n\n Thank You \n \n siteadmin","$headers"))
                {echo "<center><b>THANK YOU</b> <br>Your password is posted to your emil address .
Please check your mail after some time. </center>";}
            else{// there is a system problem in sending mail
                    echo " <center>There is some system problem in sending login details to your address.
Please contact site-admin. <br><br><input type='button' value='Retry' onClick='history.go(-1)'></center>";}
                }
        else {// Validation failed so show the error message
            echo "<center>$msg
    <br><br><input type='button' value='Retry' onClick='history.go(-1)'></center>";
    */
