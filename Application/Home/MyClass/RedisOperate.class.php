<?php

/**
 * Redis操作类(单例模式)
 * @author 高寒 <20763310@qq.com>
 */
namespace User\MyClass;

class RedisOperate {
    
    private static $_instance = null;

    private static $host = '10.25.214.206';

    private static $port = '6379';

    private static $password = 'zmsoft123';
    
    public static function getInstance() {
        if (self::$_instance === null) {
            
            self::$_instance = new \Redis;
            self::$_instance->connect(self::$host, self::$port);
            if (self::$password != '') {
                self::$_instance->auth(self::$password);
            }
        }
        return self::$_instance;
    }
}

