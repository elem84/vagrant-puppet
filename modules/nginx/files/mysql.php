<?php

$dbname = 'test';
$dsn = 'mysql:host=localhost;dbname='.$dbname;
$username = 'test';
$password = 'test123';

$options = array(
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
);

try
{
    $dbh = new PDO($dsn, $username, $password, $options);
    echo 'Connected';
}
catch(Exception $e)
{
    echo 'Error: ' . $e->getMessage();
}
