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

$app->add(new \Slim\Middleware\SessionCookie(
        array('expires' => '59 minutes', 'path' => '/', 'domain' => null,
                'secure' => false, 'httponly' => false,
                'name' => 'slim_session', 'secret' => 'CHANGE_ME',
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

function fbAccountExists($accountId) {
    $sql = "SELECT count(*) as count from accounts_fb where accountId='"
            . $accountId . "'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if ($record->count) {
            return true;
        } else {
            return false;
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
}

function googleAccountExists($accountId) {
    $sql = "SELECT count(*) as count from accounts_google where accountId='"
            . $accountId . "'";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if ($record->count) {
            return true;
        } else {
            return false;
        }
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

function insertFb($accountId) {
    $date = date("Y-m-d H:i:s", time());
    $sql = "INSERT INTO accounts_fb (accountId,facebookId, linkedOn, bio, education, firstName, gender, lastName, link,locale, timezone, username) VALUES (:accountId,:facebookId,:linkedOn, :bio,:education, :firstName, :gender, :lastName, :link,:locale,:timezone,:username)";
    $edu = "test";
    //$stmt->bindParam("pictures", $_POST['pictures']);
    //$stmt->bindParam("quotes", $_POST['quotes']);
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("facebookId", $_POST['id']);
        $stmt->bindParam("linkedOn", $date);
        $stmt->bindParam("bio", $_POST['bio']);
        $stmt->bindParam("education", $edu);
        $stmt->bindParam("firstName", $_POST['first_name']);
        $stmt->bindParam("gender", $_POST['gender']);
        $stmt->bindParam("lastName", $_POST['last_name']);
        $stmt->bindParam("link", $_POST['link']);
        $stmt->bindParam("locale", $_POST['locale']);
        //$stmt->bindParam("pictures", $_POST['pictures']);
        //$stmt->bindParam("quotes", $_POST['quotes']);
        $stmt->bindParam("timezone", $_POST['timezone']);
        $stmt->bindParam("username", $_POST['username']);
        //$stmt->bindParam("work", $_POST['work']);
        return $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        error_log($e->getMessage(), 3, '/var/tmp/php.log');
        echo $e->getMessage();
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

/*function createStudentAccount($firstName, $lastName, $email, $password) {
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

}*/

function createAccount($firstName, $lastName, $email, $password = null) {
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

/*$app->hook('slim.before.dispatch', function() use ($app) {
    $user = null;
    if (isset($_SESSION['user'])) {
        $user = $_SESSION['user'];
    }
    $app->view()->setData('user', $user);
});*/

$app->post("/signup", function () use ($app) {
    $response = array();
    $accountType = $_POST['type'];
    switch ($accountType) {
    case 1: //our custom sign-up
    //validate inputs
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
        if (!isset($_POST['password']) || $_POST['password'] == '') {
            $response["status"] = FAIL;
            $response["data"] = "Please enter a valid password";
            break;
        }
        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $email = $_POST['email'];
        $password = $_POST['password'];
        $streamId = $_POST['streamId'];
        if (emailExists($email) != 0) {
            // email exists
            $response["status"] = FAIL;
            $response["data"] = "Email already exists. you should probably try forgot password";
        } else {
            $account->id = createAccount($firstName, $lastName, $email, $password);
            insertStudent($account->id, $streamId);
            $account->firstName = $firstName;
            $account->lastName = $lastName;
            $account->email = $email;
            $account->streamId = $streamId;
            $account->ascore = 0;
            $_SESSION['user'] = $account->id;
            $response["status"] = SUCCESS;
            $response["data"] = $account;
        }
        break;
    case 2:// fb log-in
        if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
            $response["status"] = FAIL;
            $response["data"] = "Please give appropriate permission to access your email";
            break;
        }
        if (!isset($_POST['first_name']) || $_POST['first_name'] == '') {
            $response["status"] = FAIL;
            $response["data"] = "No first name set. Try Again.";
            break;
        }
        if (!isset($_POST['last_name']) || $_POST['last_name'] == '') {
            $response["status"] = FAIL;
            $response["data"] = "No last name set. Try Again.";
            break;
        }
        $firstName = $_POST['first_name'];
        $lastName = $_POST['last_name'];
        $email = $_POST['email'];
        $streamId = $_POST['streamId'];
        if (($account->id = emailExists($email)) != 0) {
            // email exists
            //check if fb account is linked 
            if (fbAccountExists($account->id) == 0) {
                insertFb($account->id);
            }
            $account = getStudentByAccountId($account->id, 1);
        } else {
            // create account
            $account->id = createAccount($firstName, $lastName, $email);
            // push into fb
            insertFb($account->id);
            // push into students
            insertStudent($account->id, $streamId);
            $account->firstName = $firstName;
            $account->lastName = $lastName;
            $account->email = $email;
            $account->streamId = $streamId;
            $account->ascore = 0;
        }
        $_SESSION['user'] = $account->id;
        $response["status"] = SUCCESS;
        $response["data"] = $account;
        break;
    case 3:
        //google sign-up
        break;
    }
    sendResponse($response);
});

$app->get("/logout", function () use ($app) {
    $response = array();
    if (isset($_SESSION['user'])) {
        unset($_SESSION['user']);
        $response["status"] = SUCCESS;
        $response["data"] = "Logged Out";
    } else {
        $response["status"] = FAIL;
        $response["data"] = "Already logged out";
    }
    sendResponse($response);
});

$app->post("/login", function () use ($app) {
    $response = array();
    $email = $app->request()->post('email');
    $password = $app->request()->post('password');
    $streamId = $app->request()->post('streamId');
    $sql = "SELECT a.id as id,a.email,a.firstName,a.lastName,s.ascoreL1 as ascore from accounts a,students s where a.email='"
            . $email . "' AND a.password='" . $password . "' AND s.streamId='"
            . $streamId . "' AND a.id=s.accountId";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        if ($record != null && $record->id != null) {
            $response["status"] = SUCCESS;
            $response["data"] = $record;
            $_SESSION['user'] = $record->id;
        } else {
            $response["status"] = FAIL;
            $response["data"] = "Email and Password dont match.";
        }
    } catch (PDOException $e) {
        echo '{"error":{"text":' . $e->getMessage() . '}}';
    }
    sendResponse($response);
});

$app->get("/isAuth", function () use ($app) {
    $id = null;
    if (isset($_SESSION['user'])) {
        $id = $_SESSION['user'];
        $account = getStudentByAccountId($id, 1);
        echo json_encode($account);
    } else {
        echo json_encode(false);
    }
});

$app->post("/forgotpass", function () use ($app) {
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
        sendMail($email, "your password is " . $account->password . "");
    }
});

$app->post("/changepass", $authenticate($app), function () use ($app) {
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
});
