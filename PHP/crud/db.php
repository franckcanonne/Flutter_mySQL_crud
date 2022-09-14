<?php

$db_server="#######"; // adresse de la base de données MySQL
$db_name="#######"; // Nom de la base de données MySQL
$db_user="#######"; // Utilisateur MySQL
$db_pass="#######"; // Mot de passe MySQL

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
