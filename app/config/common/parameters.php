<?php

$container->setParameter('database_url', getenv('DATABASE_URL'));
$container->setParameter('raygun_apikey', getenv('RAYGUN_APIKEY'));
