<?php

$db_server="db5006980713.hosting-data.io";
$db_name="dbs5763769";
$db_user="dbu1571656";
$db_pass="S#d93jtd29#l";

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
