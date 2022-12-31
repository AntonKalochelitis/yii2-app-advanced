<?php

defined('DEFAULT_PATH') or define('DEFAULT_PATH', realpath(dirname(__FILE__)));
defined('DOTENV_PATH') or define('DOTENV_PATH', DEFAULT_PATH . DIRECTORY_SEPARATOR);
defined('DOTENV_FILE') or define('DOTENV_FILE', '.env.local');
defined('DOTENV_OVERLOAD') or define('DOTENV_OVERLOAD', false);

defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'dev');

require __DIR__ . '/../../vendor/autoload.php';
require __DIR__ . '/../../vendor/yiisoft/yii2/Yii.php';
require __DIR__ . '/../../common/config/bootstrap.php';
require __DIR__ . '/../config/bootstrap.php';

$config = yii\helpers\ArrayHelper::merge(
    require __DIR__ . '/../../common/config/main.php',
    require __DIR__ . '/../../common/config/main-local.php',
    require __DIR__ . '/../config/main.php',
    require __DIR__ . '/../config/main-local.php'
);

(new yii\web\Application($config))->run();
