<?php

/**
 * Helper functions
 */

function sendEmail($to, $subject, $message) {
    $res = mail($to, $subject, $message);
    return $res;
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
