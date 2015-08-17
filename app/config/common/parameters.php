<?php

$container->setParameter('database_url', getenv('DATABASE_URL'));
$container->setParameter('rollbar_server_access_token', getenv('ROLLBAR_ACCESS_TOKEN'));
