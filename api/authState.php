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

$app
        ->add(
                new \Slim\Middleware\SessionCookie(
                        array('expires' => '59 minutes', 'path' => '/',
                                'domain' => null, 'secure' => false,
                                'httponly' => false, 'name' => 'slim_session',
                                'secret' => 'CHANGE_ME',
                                'cipher' => MCRYPT_RIJNDAEL_256,
                                'cipher_mode' => MCRYPT_MODE_CBC)));

$authenticate = function ($app) {
    return function () use ($app) {
        if (!isset($_SESSION['user'])) {
            $app->redirect('../../client/#landing');
            //echo 'not set session';
        } else {
            if (isset($_GET['accountId'])) {
                //echo 'accountId'.$_GET['accountId'];
                // check if accountId is same as sessionId
                if ($_GET['accountId'] != $_SESSION['user']) {
                    $app->redirect('../../client/#landing');
                }
            }
        }
    };
};

function sendEmail($content, $email) {
    $from = "<from.gmail.com>";
    $to = $email;
    $subject = "Hi!";
    $body = $content;

    $host = "ssl://smtp.gmail.com";
    $port = "465";
    $username = "myaccount@gmail.com"; //<> give errors
    $password = "password";

    $headers = array('From' => $from, 'To' => $to, 'Subject' => $subject);
    $smtp = Mail::factory('smtp',
            array('host' => $host, 'port' => $port, 'auth' => true,
                    'username' => $username, 'password' => $password));

    $mail = $smtp->send($to, $headers, $body);

    if (PEAR::isError($mail)) {
        echo ("<p>" . $mail->getMessage() . "</p>");
    } else {
        echo ("<p>Message successfully sent!</p>");
    }
}

function getStudentByAccountId($accountId, $streamId) {
    $sql = "SELECT a.id as id,a.email,a.firstName,a.lastName,s.ascoreL1 as ascore from accounts a,students s where a.id='"
            . $accountId . "' AND s.streamId='" . $streamId
            . "' AND a.id=s.accountId";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $account = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        return $account;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}
;

function emailExists($email) {
    $sql = "SELECT id from accounts where email='" . $email . "'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        //echo $id->id;
        if ($record && $record->id) {
            return $record->id;
        } else {
            return 0;
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}
;

function fbAccountExists($accountId) {
    $sql = "SELECT count(*) as count from account_fb where accountId='"
            . $accountId . "'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $count = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        return $count[0]->count;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}
;

function googleAccountExists($accountId) {
    $sql = "SELECT count(*) as count from account_google where accountId='"
            . $accountId . "'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $count = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        return $count[0]->count;
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function insertStudent($accountId, $streamId) {
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

function insertFb($info) {
    $sql = "INSERT INTO accounts_fb (accountId,facebookId, bio, education, firstName, gender, lastName, link,locale) VALUES (:accountId,:facebookId, :bio,:education, :firstName, :gender, :lastName, :link,:locale)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("facebookId", $accountId);
        $stmt->bindParam("bio", $accountId);
        $stmt->bindParam("firstName", $accountId);
        $stmt->bindParam("gender", $accountId);
        $stmt->bindParam("lastName", $accountId);
        $stmt->bindParam("link", $accountId);
        $stmt->bindParam("locale", $accountId);
        $stmt->execute();
        $response->id = $db->lastInsertId();
        return $response->id;
    } catch (PDOException $e) {
        error_log($e->getMessage(), 3, '/var/tmp/php.log');
    }
    /*bio: "find my scribbling here - http://greypad.thinkpluto.com/"
    education: Array[2]
    email: "shikhar.sachan@gmail.com"
    first_name: "Shikhar"
    gender: "male"
    id: "675467514"
    last_name: "Sachan"
    link: "https://www.facebook.com/shikhar.sachan"
    locale: "en_US"
    name: "Shikhar Sachan"
    pictures: Object
    quotes: "you loose 100 % of the shots you don't take ..."
    timezone: 5.5
    updated_time: "2012-08-18T16:31:31+0000"
    username: "shikhar.sachan"
    verified: true
    work: Array[1]
     */
}

function createAccount($firstName, $lastName, $email, $password) {
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
        $id = $db->lastInsertId();
        $db = null;
        return $id;
    } catch (PDOException $e) {
        error_log($e->getMessage(), 3, '/var/tmp/php.log');
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function fbSignUp() {

}
/*$app->hook('slim.before.dispatch', function() use ($app) {
    $user = null;
    if (isset($_SESSION['user'])) {
        $user = $_SESSION['user'];
    }
    $app->view()->setData('user', $user);
});*/

$app
        ->post("/signup",
                function () use ($app) {
                    $accountType = $_POST['type'];
                    switch ($accountType) {
                    case 1:
                    //our custom sign-up
                        $firstName = $_POST['firstName'];
                        $lastName = $_POST['lastName'];
                        $email = $_POST['email'];
                        $password = $_POST['password'];
                        $streamId = $_POST['streamId'];
                        if (emailExists($email) != 0) {
                            // email exists
                            $msg = 'email already exists. you should probably try forgot password';
                            //echo json_encode('{"error":{"text":' . $msg . '}}');
                            echo '{"error":{"text":' . $msg . '}}';
                        } else {
                            $response->id = createAccount($firstName,
                                    $lastName, $email, $password);
                            insertStudent($response->id, $streamId);
                            $response->firstName = $firstName;
                            $response->lastName = $lastName;
                            $response->email = $email;
                            $response->streamId = $streamId;
                            $response->ascore = 0;
                            $_SESSION['user'] = $response->id;
                            echo json_encode($response);
                        }
                        break;
                    case 2:
                        $firstName = $_POST['first_name'];
                        $lastName = $_POST['last_name'];
                        $email = $_POST['email'];
                        $streamId = $_POST['streamId'];
                        if (emailExists($email) != 0) {
                            // email exists
                            //check if fb account is linked 
                            if (fbAccountExists($email) != 0) {
                                // fb account exists

                            } else {
                                // insert into fb
                            }

                        } else {
                            // create account
                            $response->id = createAccount($firstName,
                                    $lastName, $email, $password);
                            // push into fb
                            //insertFb($_POST);
                            // push into students
                            insertStudent($response->id, $streamId);
                        }
                        $response->firstName = $firstName;
                        $response->lastName = $lastName;
                        $response->email = $email;
                        $response->streamId = $streamId;
                        $response->ascore = 0;
                        $_SESSION['user'] = $response->id;
                        echo json_encode($response);
                        break;
                    case 3:
                    //google sign-up

                        break;
                    }
                });

$app
        ->get("/logout",
                function () use ($app) {
                    if (isset($_SESSION['user'])) {
                        unset($_SESSION['user']);
                        echo json_encode(true);
                    } else {
                        $msg = 'Already logged out';
                        echo '{"error":{"text":' . $msg . '}}';
                    }
                });

$app
        ->post("/login",
                function () use ($app) {
                    $email = $app->request()->post('email');
                    $password = $app->request()->post('password');
                    $streamId = $app->request()->post('streamId');
                    $sql = "SELECT a.id as id,a.email,a.firstName,a.lastName,s.ascoreL1 as ascore from accounts a,students s where a.email='"
                            . $email . "' AND a.password='" . $password
                            . "' AND s.streamId='" . $streamId
                            . "' AND a.id=s.accountId";
                    try {
                        $db = getConnection();
                        $stmt = $db->query($sql);
                        $account = $stmt->fetch(PDO::FETCH_OBJ);
                        $db = null;
                        if ($account != null && $account->id != null) {
                            echo json_encode($account);
                            $_SESSION['user'] = $account->id;
                        }
                    } catch (PDOException $e) {
                        echo '{"error":{"text":' . $e->getMessage() . '}}';
                    }
                    $errors = array();
                });

$app
        ->get("/isAuth",
                function () use ($app) {
                    $id = null;
                    if (isset($_SESSION['user'])) {
                        $id = $_SESSION['user'];
                        $account = getStudentByAccountId($id, 1);
                        echo json_encode($account);
                    } else {
                        echo json_encode(false);
                    }
                });

$app
        ->post("/forgotpass",
                function () use ($app) {
                    $email = $_POST['email'];
                    $status = "OK";
                    $msg = "";
                    //error_reporting(E_ERROR | E_PARSE | E_CORE_ERROR);
                    // You can supress the error message by un commenting the above line
                    if (!stristr($email, "@") OR !stristr($email, ".")) {
                        $msg = 'email address is not correct';
                        echo '{"error":{"text":' . $msg . '}}';
                        $status = "NOTOK";
                    }

                    if ($status == "OK") { // validation passed now we will check the tables
                        $sql = "SELECT email,password FROM accounts WHERE email = '$email'";
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
                            echo '{"error":{"text":' . $msg . '}}';
                        }
                        sendMail($email,
                                "your password is " . $account->password . "");
                    }
                });

$app
        ->post("/changepass", $authenticate($app),
                function () use ($app) {
                    $oldpassword = $_POST['oldpassword'];
                    $newpassword = $_POST['newpassword'];
                    $sql = "UPDATE accounts SET password=:newpassword WHERE password=:oldpassword";
                    try {
                        $db = getConnection();
                        $stmt = $db->prepare($sql);
                        $stmt->bindParam("newpassword", $newpassword);
                        $stmt->bindParam("oldpassword", $oldpassword);
                        $stmt->execute();
                        $db = null;
                        echo json_encode(true);
                    } catch (PDOException $e) {
                        echo '{"error":{"text":' . $e->getMessage() . '}}';
                    }
                    // we can send an email here too. 
                });

$app
        ->get("/private/about", $authenticate($app),
                function () use ($app) {
                    $app->render('privateAbout.php');
                });

$app
        ->get("/private/goodstuff", $authenticate($app),
                function () use ($app) {
                    $app->render('privateGoodStuff.php');
                });

