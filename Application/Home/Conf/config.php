<?php
return array(
    /* 数据库设置 */
    'DB_TYPE'               =>  'mysql',     // 数据库类型
    'DB_HOST'               =>  'bdm289537170.my3w.com',     // 服务器地址
    // 'DB_NAME'               =>  'dymAC',     // 数据库名 
    'DB_NAME'               =>  'bdm289537170_db',     // 数据库名
    'DB_USER'               =>  'bdm289537170',     // 用户名
    'DB_PWD'                =>  'fanyoufu123.',     // 密码
    'DB_PORT'               =>  '3306',     // 端口
    'ROLLPAGE'      =>  10,     //分页，每页显示的页数
    'PRINTPAGE'      =>  12,     //打印机显示的页数
    
    // 'SESSION_TYPE'          =>  'Db',
    'SESSION_TABLE'=>'ybs_session',
    'SESSION_EXPIRE'=>1440,

     //微信配置信息
    'APPID' =>'wx69e2acb769707f04',
    'SECRET' =>'4003e76d03ef698b85d7723b80cecd7f',
     
    'DATA_CACHE_PREFIX' => 'Redis_',//缓存前缀
 'DATA_CACHE_TYPE'=>'Redis',//默认动态缓存为Redis
 'REDIS_RW_SEPARATE' => true, //Redis读写分离 true 开启
 'REDIS_HOST'=>'r-wz9780eea6e258f4.redis.rds.aliyuncs.com', //redis服务器ip，多台用逗号隔开；读写分离开启时，第一台负责写，其它[随机]负责读；
 'REDIS_PORT'=>'6379',//端口号
 'REDIS_TIMEOUT'=>'300',//超时时间
 'REDIS_PERSISTENT'=>false,//是否长连接 false=短连接
 'REDIS_AUTH_PASSWORD'=>'d94av1R1DJiL',//AUTH认证密码
    /* 页面Trace */
    'SHOW_PAGE_Trace'      => false,
    /* 默认模板文件后缀 */
    'TMPL_TEMPLATE_SUFFIX' => '.tpl',
    /* 主题静态文件路径 */
    'TMPL_PARSE_STRING'    => array(
        '__Public__' => __ROOT__ . '/Application/' . MODULE_NAME . '/View/Public',
        '__Assert__' => __ROOT__ . '/Application/' . MODULE_NAME . '/View/Public/assert',
        '__Qrcode__' => __ROOT__ . '/Qrcode/Img',
        '__APP__'=> __ROOT__. '/Application/User/controller',
    ),
    	'TLSXF'=>0.005,//通联手续费
        'MRTP' => 'lication/User/View/Public/assert/img/123.png)',//截取图片插件默认的图片
        'SHENFEN' => '合伙人、联合创始人、专卖店、城市运营中心',
        'XGMRTPT' => 'g/20',
        'XGMRTPW' => '.jpg)',
        'OSSimg' => 'Uploads/img',
        'yuming'            => 'http://admin.dym666.com/', 
        'wxyuming'            => 'http://wx.dym666.com/', 
        'ZDYOSSWZ'            => 'http://i.dym666.com/', 
        //阿里云
        'access_id'       =>  'LTAI7N00hnisCBOQ',
        'access_key'      =>  'LcyI6PRur26ixuQNIj5ADHMBvUvvqj',
        'bucket'         =>   'dym666',//oss库
        'hostname' => 'oss-cn-shenzhen.aliyuncs.com',//外网名 不要前面库名  访问是还是需要加库名
        //秀米图片路径
        'xiumi'            => 'ueditor/php/upload/image', 
        //'http' => 'http://dym666.oss-cn-shenzhen.aliyuncs.com/',
        'http' => 'http://i.dym666.com/',

    'yuming'            => 'http://ac.dym666.com/',
        'RIQI' => '10',//显示可退款的，几号之后不显示上月的因为已发钱
        /*add by liu*/
        //图片裁剪的尺寸
        'picinfo'=>array(
            //人物头像尺寸
            "human"=>array("w"=>120,"h"=>120),
            "choice"=>array("w"=>710,"h"=>360),
            "movement"=>array("w"=>750,"h"=>770),
            "course"=>array("w"=>158,"h"=>158),
            "gift"=>array("w"=>130,"h"=>130),
            "banner"=>array("w"=>750,"h"=>375),
            "item"=>array("w"=>701,"h"=>277),
            "bottom"=>array("w"=>701,"h"=>126),
            "activity"=>array("w"=>670,"h"=>370),
            "card"=>array("w"=>500,"h"=>500),
            //商品主图尺寸
            "goodsclass"=>array("w"=>375,"h"=>250),
            //服务主图尺寸
            "commod"=>array("w"=>750,"h"=>770),
            "exchange"=>array("w"=>690,"h"=>210),
             "commods"=>array("w"=>500,"h"=>500),
            //商品轮播图尺寸
            "carousel"=>array("w"=>360,"h"=>240),
            //商品主图尺寸单位px
            "goods"=>array("w"=>640,"h"=>300),
            //商品副图尺寸单位px
            "goodsf"=>array("w"=>750,"h"=>640),
            //专访主图尺寸单位px
            "stories"=>array("w"=>640,"h"=>300),
            //专访轮播图尺寸单位px
            "classic"=>array("w"=>750,"h"=>640),
            //活动图片尺寸单位px
            "friend"=>array("w"=>640,"h"=>300),
            //新手礼物图片尺寸单位px
            "novice"=>array("w"=>750,"h"=>258),
            //活动轮播图片尺寸单位px
            "youdao"=>array("w"=>750,"h"=>640),
            //众筹主图尺寸单位px
            "financing"=>array("w"=>640,"h"=>300),
            //众筹副图尺寸单位px
            "financingf"=>array("w"=>750,"h"=>640),
            /*add by zhang*/
            //万美改变一生主图(美颂首页的)
            'wmgbyssy'=>array("w"=>640,"h"=>345),
            //万美改变一生内图(美颂首页的)
            'wmgbyssyn'=>array("w"=>800,"h"=>354),
            //行业新规划首页图
            'hyngh'=>array("w"=>640,"h"=>345),
            //行业新规划内页封面图
            'nhyngh'=>array("w"=>800,"h"=>354),
            //万美惠聚首页封面图
            'wmhj'=>array("w"=>640,"h"=>345),
            //万美惠聚内页封面图片
            'nwmhj'=>array("w"=>800,"h"=>354),
            //完美改变一生文章封面图片
            "storeindex"=>array("w"=>750,"h"=>750),
            //体验后记首页封面图片
            'tyhjimg'=>array("w"=>600,"h"=>400),
            //体验后记内页封面图片
            'ntyhjimg'=>array("w"=>640,"h"=>568),
            //万美美品首页封面图片
            'wmmpimg'=>array("w"=>640,"h"=>600),
            //万美创业首页封面图片
            'wmcyimg'=>array("w"=>640,"h"=>345),
            //微众筹首页封面图片
            'wzcimg'=>array("w"=>640,"h"=>345),
            //招募美业合伙人首页封面图片
            'PartnerImg'=>array("w"=>640,"h"=>345),
            //加入万美
            'joinwm'=>array("w"=>640,"h"=>345),
            //礼包封面
            'liBaoImg'=>array("w"=>640,"h"=>345),
            /*end by zhang*/
            /*add by liu*/
            //体验后记
            'tyhj'=>array("w"=>640,"h"=>345),
            //美赚攻略
            'raiders'=>array("w"=>640,"h"=>345),

            /*end by liu*/
        ),
        //图片存储的路径
        "picpath"=>array(
            
            "hd"=>"hd/",
            "kc"=>"kc/",
            "vipimg"=>"vipimg/",
            "vipmp"=>"vipmp/",
            "wxptewm_yqm"=>"wxptewm_yqm/",
            "yyty"=>"yyty/",
            "zf"=>"zf/",
        ),
        'OSSIMG'                =>  'img',
        /*end by liu*/
        "ACCESS_KEY_ID"=>"LTAI7N00hnisCBOQ",
        "ACCESS_KEY_SECRET"=>"LcyI6PRur26ixuQNIj5ADHMBvUvvqj",
        "ENDPOINT"=>"oss-cn-shenzhen.aliyuncs.com",
        "BUCKET_NAME"=>'dym666',
);
