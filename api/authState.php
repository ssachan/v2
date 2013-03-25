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

/*$app->hook('slim.before.dispatch', function() use ($app) {
 $user = null;
        if (isset($_SESSION['user'])) {
        $user = $_SESSION['user'];
        }
        $app->view()->setData('user', $user);
        });*/

//account types
define('CUSTOM', 1); // custom sign up
define('FB', 2); // FB sign up.
define('GOOGLE', 3); // google.

//define('CCODE', "Test2"); // ccode.
define('FREE_TESTS', 3); // free tests.
define('SIGN_UP_SUB', 'Welcome to PrepSquare'); // free tests
define('SIGN_UP_MSG', 'Congratulations!!!<br>You are now a registered user. We are really excited to have you with us.'); // free tests

$app->add(new \Slim\Middleware\SessionCookie(
        array('expires' => '120 minutes', 'path' => '/', 'domain' => null,
                'secure' => false, 'httponly' => false,
                'name' => 'slim_session', 'secret' => 'CHANGE_ME',
                'cipher' => MCRYPT_RIJNDAEL_256,
                'cipher_mode' => MCRYPT_MODE_CBC)));

$authenticate = function ($app) {
    return function () use ($app) {
        if (!isset($_SESSION['user'])) {
            echo 'not set session';
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

function copyImage($url) {
    //copy($url, );
}

function getStudentByAccountId($accountId, $streamId) {
    $sql = "SELECT a.id as id,a.email,a.firstName,a.lastName,s.ascoreL1 as ascore,s.quizzesAttempted,s.quizzesRemaining,s.paid from accounts a,students s where a.id='"
            . $accountId . "' AND s.streamId='" . $streamId
            . "' AND a.id=s.accountId AND a.flag=1";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $account = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        return $account;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

function getAccountByEmail($email) {
    $sql = "SELECT id,password from accounts where email=:email";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("email", $email);
        $stmt->execute();
        $record = $stmt->fetch(PDO::FETCH_OBJ);
        $db = null;
        return $record;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
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
        phpLog($e->getMessage());
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
        phpLog($e->getMessage());
    }
}

function insertStudent($accountId, $streamId) {
    $sql = "INSERT INTO students (accountId,streamId) VALUES (:accountId, :streamId)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("accountId", $accountId);
        $stmt->bindParam("streamId", $streamId);
        return $stmt->execute();
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

function insertFb($accountId) {
    $date = date("Y-m-d H:i:s", time());
    $sql = "INSERT INTO accounts_fb (accountId,facebookId, linkedOn, bio, education, firstName, gender, lastName, link,locale, timezone, username,pictures,work) VALUES (:accountId,:facebookId,:linkedOn, :bio,:education, :firstName, :gender, :lastName, :link,:locale,:timezone,:username,:pics,:work)";
    if (array_key_exists('education', $_POST)) {
        $edu = json_encode($_POST['education']);
    } else {
        $edu = NULL;
    }
    if (array_key_exists('work', $_POST)) {
        $work = json_encode($_POST['work']);
    } else {
        $work = NULL;
    }
    if (array_key_exists('pictures', $_POST)) {
        $pictures = json_encode($_POST['pictures']);
    } else {
        $pictures = NULL;
    }
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
        $stmt->bindParam("pics", $pictures);
        //$stmt->bindParam("quotes", $_POST['quotes']);
        $stmt->bindParam("timezone", $_POST['timezone']);
        $stmt->bindParam("username", $_POST['username']);
        $stmt->bindParam("work", $work);
        return $stmt->execute();
        $db = null;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
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

function createAccount($firstName, $lastName, $email, $password = null, $flag = 1) {
    $date = date("Y-m-d H:i:s", time());
    $sql = "INSERT INTO accounts (firstName,lastName,email,password, createdOn, flag) VALUES (:firstName, :lastName, :email, :password, :createdOn, :flag)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("firstName", $firstName);
        $stmt->bindParam("lastName", $lastName);
        $stmt->bindParam("email", $email);
        $stmt->bindParam("password", $password);
        $stmt->bindParam("createdOn", $date);
        $stmt->bindParam("flag", $flag);
        $stmt->execute();
        $id = $db->lastInsertId();
        $db = null;
        return $id;
    } catch (PDOException $e) {
        phpLog($e->getMessage());
    }
}

$app->post("/fblogin", function () use ($app) {
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Email not valid. Try Again.";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['first_name']) || $_POST['first_name'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "No first name set. Try Again.";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['last_name']) || $_POST['last_name'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "No last name set. Try Again.";
        sendResponse($response);
        break;
    }
    $firstName = $_POST['first_name'];
    $lastName = $_POST['last_name'];
    $email = $_POST['email'];
    $streamId = $_POST['streamId'];
    $account = getAccountByEmail($email);
    if ($account != null) {
        // email exists
        //check if fb account is linked
        if (!fbAccountExists($account->id)) {
            insertFb($account->id);
        }
    } else {
        // create account
        $account = new stdClass();
        $account->id = createAccount($firstName, $lastName, $email);
        // push into fb
        insertFb($account->id);
        // push into students
        insertStudent($account->id, $streamId);
        updateQuizzesRemaining(FREE_TESTS, $account->id, $streamId);
        sendMail($email, SIGN_UP_SUB, file_get_contents('templates/signup.php'));
    }
    $account = getStudentByAccountId($account->id, 1);
    $_SESSION['user'] = $account->id;
    $_SESSION['type'] = FB;
    if (file_exists(DP_PATH . $account->id)) {
        $account->dp = '1';
    } else {
        $account->dp = '0';
    }
    $response["status"] = SUCCESS;
    $response["data"] = $account;
    sendResponse($response);
});

function signUp() {
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid email address";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['firstName']) || $_POST['firstName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your first name";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['lastName']) || $_POST['lastName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your last name";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['password']) || $_POST['password'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid password";
        sendResponse($response);
        break;
    }
    if ($_POST['password'] != $_POST['cPassword']) {
        $response["status"] = FAIL;
        $response["data"] = "Passwords entered do not match";
        sendResponse($response);
        break;
    }
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $streamId = $_POST['streamId'];
    $account = getAccountByEmail($email);
    if ($account != null) {
        // account exists
        if ($account->password == null) {
            $response["status"] = FAIL;
            $response["data"] = "You have either logged in through FB or Google. To create a custom account, log in through the account and set a password";
        } else {
            $response["status"] = FAIL;
            $response["data"] = "Email already exists. you should probably try forgot password";
        }
    } else {
        $account = new stdClass();
        $account->id = createAccount($firstName, $lastName, $email, $password);
        insertStudent($account->id, $streamId);
        updateQuizzesRemaining(FREE_TESTS, $account->id, $streamId);
        sendMail($email, SIGN_UP_SUB, file_get_contents('templates/signup.php'));
        $account = getStudentByAccountId($account->id, $streamId);
        if (file_exists(DP_PATH . $account->id . '.jpg')) {
            $account->dp = true;
        } else {
            $account->dp = false;
        }
        $account->type = CUSTOM;
        $_SESSION['user'] = $account->id;
        $_SESSION['type'] = CUSTOM;
        $response["status"] = SUCCESS;
        $response["data"] = $account;
    }
    sendResponse($response);
}

$app->post("/invite", function () use ($app) {
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid email address";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['firstName']) || $_POST['firstName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your first name";
        sendResponse($response);
        break;
    }
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $email = $_POST['email'];
    $streamId = $_POST['streamId'];
    $account = getAccountByEmail($email);
    if ($account != null) {
        // account exists
        $response["status"] = FAIL;
        $response["data"] = "Your email is registered with us.";
    } else {
        $account = new stdClass();
        $account->id = createAccount($firstName, $lastName, $email, null, 0);
        $response["status"] = SUCCESS;
        $response["data"] = "Thanks for your interest. We will send you an invite very soon.";
    }
    sendResponse($response);
});

$app->post("/ccsignup", function () use ($app) {
    $ccodeArray = array("EDU01", "PSQ01", "PSQ02", "PSQ03", "PSQ04", "PSQ05",
            "PSQ06", "PSQ07", "PSQ08", "PSQ09", "PSQ10", "TEST01");
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid email address";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['ccode']) || $_POST['ccode'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a coupon code";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['firstName']) || $_POST['firstName'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter your first name";
        sendResponse($response);
        break;
    }
    if (!isset($_POST['password']) || $_POST['password'] == '') {
        $response["status"] = FAIL;
        $response["data"] = "Please enter a valid password";
        sendResponse($response);
        break;
    }
    if ($_POST['password'] != $_POST['cPassword']) {
        $response["status"] = FAIL;
        $response["data"] = "Passwords entered do not match";
        sendResponse($response);
        break;
    }
    if (in_array($_POST['ccode'], $ccodeArray)) {
        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $email = $_POST['email'];
        $password = $_POST['password'];
        $streamId = $_POST['streamId'];
        $account = getAccountByEmail($email);
        if ($account != null) {
            // account exists
            if ($account->password == null) {
                $response["status"] = FAIL;
                $response["data"] = "You have either logged in through FB or Google. To create a custom account, log in through the account and set a password";
            } else {
                $response["status"] = FAIL;
                $response["data"] = "Email already exists. you should probably try forgot password";
            }
        } else {
            $account = new stdClass();
            $account->id = createAccount($firstName, $lastName, $email, $password);
            insertStudent($account->id, $streamId);
            updateQuizzesRemaining(FREE_TESTS, $account->id, $streamId);
            sendMail($email, SIGN_UP_SUB, file_get_contents('templates/signup.php'));
            $account = getStudentByAccountId($account->id, $streamId);
            if (file_exists(DP_PATH . $account->id . '.jpg')) {
                $account->dp = true;
            } else {
                $account->dp = false;
            }
            $account->type = CUSTOM;
            $_SESSION['user'] = $account->id;
            $_SESSION['type'] = CUSTOM;
            $response["status"] = SUCCESS;
            $response["data"] = $account;
        }
    } else {
        $response = array();
        $response["status"] = FAIL;
        $response["data"] = "Your Coupon Code doesn't match.";
    }
    sendResponse($response);

});

$app->post("/signup", function () use ($app) {
    signUp();
});

$app->get("/logout", function () use ($app) {
    $response = array();
    if (isset($_SESSION['user'])) {
        unset($_SESSION['user']);
        unset($_SESSION['type']);
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
    $account = getAccountByEmail($email);
    if ($account) {
        if ($account->password == $password) {
            // account exists
            $account = getStudentByAccountId($account->id, $streamId);
            if (file_exists(DP_PATH . $account->id . '.jpg')) {
                $account->dp = true;
            } else {
                $account->dp = false;
            }
            $response["status"] = SUCCESS;
            $response["data"] = $account;
            $_SESSION['user'] = $account->id;
            $_SESSION['type'] = CUSTOM;
        } else {
            $response["status"] = FAIL;
            $response["data"] = "Email and Password don't match.";
        }
    } else {
        $response["status"] = FAIL;
        $response["data"] = "Email doesn't exist. Please sign-up";
    }
    sendResponse($response);
});

$app->get("/isAuth", function () use ($app) {
    $response = array();
    $id = null;
    if (isset($_SESSION['user'])) {
        $id = $_SESSION['user'];
        $account = getStudentByAccountId($id, 1);
        if (file_exists(DP_PATH . $account->id . '.jpg')) {
            $account->dp = true;
        } else {
            $account->dp = false;
        }
        $account->type = $_SESSION['type'];
        $response["status"] = SUCCESS;
        $response["data"] = $account;
    } else {
        $response["status"] = FAIL;
        $response["data"] = "Not autenticated";
    }
    sendResponse($response);
});

function updatePassword($password, $accountId) {
    $sql = "UPDATE accounts SET password=:password WHERE id=:accountId";
    $sqlArray = array("accountId" => $accountId, "password" => $password);
    $sqlArray["SQL"] = "UPDATE accounts SET password=:password WHERE id=:accountId";
    doSQL($sqlArray, false);
}

function generatePassword ($length = 8)
{
    // start with a blank password
    $password = "";
    // define possible characters - any character in this string can be
    // picked for use in the password, so if you want to put vowels back in
    // or add special characters such as exclamation marks, this is where
    // you should do it
    $possible = "2346789bcdfghjkmnpqrtvwxyzBCDFGHJKLMNPQRTVWXYZ";
    // we refer to the length of $possible a few times, so let's grab it now
    $maxlength = strlen($possible);
    // check for length overflow and truncate if necessary
    if ($length > $maxlength) {
        $length = $maxlength;
    }
    // set up a counter for how many characters are in the password so far
    $i = 0;
    // add random characters to $password until $length is reached
    while ($i < $length) {
        // pick a random character from the possible ones
        $char = substr($possible, mt_rand(0, $maxlength-1), 1);
        // have we already used this character in $password?
        if (!strstr($password, $char)) {
            // no, so it's OK to add it onto the end of whatever we've already got...
            $password .= $char;
            // ... and increase the counter by one
            $i++;
        }
    }
    // done!
    return $password;
}

$app->post("/forgotpass", $app, function () use ($app) {
    $response = array();
    if (!(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL))) {
        $response["status"] = FAIL;
        $response["data"] = "Not a valid email";
        break;
    }
    // generate a new password
    $email = $_POST['email'];
    $pass = generatePassword();
    $account = getAccountByEmail($email);
    if($account){
        updatePassword($pass, $account->id);
        sendMail($email, 'Password Successfully Changed', 'Your new password is '.$pass);
        $response["status"] = SUCCESS;
        $response["data"] = "Password successfully reset! Check your email for the new password.";
    }else{
        $response["status"] = FAIL;
        $response["data"] = "Account with this email doesn't exist. Please sign-up!";
    }
    sendResponse($response);
});

$app->post("/changepass", $authenticate($app), function () use ($app) {
    $response = array();
    $oldpassword = $_POST['oldpassword'];
    $newpassword = $_POST['newpassword'];
    $accountId = $_POST['accountId'];
    $sqlArray = array("accountId" => $accountId, "password" => $oldpassword);
    $sqlArray["SQL"] = "SELECT count(*) as count FROM accounts where id=:accountId and password=:password";
    $count = doSQL($sqlArray, true);
    if ($count->count > 0) {
        // record exists change the password
        updatePassword($newpassword, $accountId);
        $response["status"] = SUCCESS;
        $response["data"] = "Password successfully changed!";
        //sendMail($email, SIGN_UP_SUB, SIGN_UP_MSG);
    } else {
        //oldpassword doesn't match
        $response["status"] = FAIL;
        $response["data"] = "Old Passwords don't match, try again!";
    }
    
    sendResponse($response);
});

$app->post("/uploadImage", $authenticate($app), function () use ($app) {
    $response = array();
    $allowedExts = array("jpg", "jpeg", "gif", "png");
    $extension = end(explode(".", $_FILES["file"]["name"]));
    if ((($_FILES["file"]["type"] == "image/gif")
            || ($_FILES["file"]["type"] == "image/jpeg")
            || ($_FILES["file"]["type"] == "image/png")
            || ($_FILES["file"]["type"] == "image/pjpeg"))
            && ($_FILES["file"]["size"] < 20000)
            && in_array($extension, $allowedExts)) {
        if ($_FILES["file"]["error"] > 0) {
            $response["status"] = FAIL;
            $response["data"] = $_FILES["file"]["error"];
        } else {
            if (file_exists(DP_PATH . $_SESSION['user'] . '.jpg')) {
                // rename the file and create a back-up
                // move_uploaded_file($_FILES["file"]["tmp_name"], DP_PATH.$_FILES["file"]["name"]);
            }
            if (move_uploaded_file($_FILES["file"]["tmp_name"], DP_PATH
                    . $_SESSION['user'] . '.jpg')) {
                $response["status"] = SUCCESS;
                $response["data"] = "";
            }
        }
    } else {
        $response["status"] = FAIL;
        $response["data"] = "Invalid file please ensure parameters are met";
    }
    sendResponse($response);
});


