<?php

/**
 * helper methods for server side
 */


/**
 * Handle server side exceptions and errors. Maintain logs 
 * @param unknown_type $msg
 */
function phpLog($msg) {
    error_log($msg, 3, '/var/tmp/php.log'); 
}

/**
 * Function to send emails
 * @param unknown_type $content
 * @param unknown_type $email
 */
function sendEmail($content) {
    $from = "<from.gmail.com>";
    $to = $email;
    $subject = "Hi!";
    $body = $content;

    $host = "ssl://smtp.gmail.com";
    $port = "465";
    $username = "myaccount@gmail.com"; //<> give errors
    $password = "password";

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


