<?php


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

$app->get("/private/about", $authenticate($app), function () use ($app) {
    $app->render('privateAbout.php');
});

$app->get("/private/goodstuff", $authenticate($app), function () use ($app) {
    $app->render('privateGoodStuff.php');
});
