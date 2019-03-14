<?php
// 应用入口文件

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG', TRUE);


// 定义应用目录
define('APP_PATH', './Application/');
//绑定模块
define('BIND_MODULE','User');
// 引入ThinkPHP入口文件

require './ThinkPHP/ThinkPHP.php';
