<?php

function getConnection() {
    $dbhost = "localhost";
    $dbuser = "atestnqy_nero";
    $dbpass = "highway69";
    $dbname = "atestnqy_nero";
    $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $dbh;
}

?>