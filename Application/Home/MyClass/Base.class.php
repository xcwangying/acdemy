<?php
namespace User\MyClass;
class Base {
    private $data = array();
    public function __construct($data){
        $this->data = $data;
    }
    /*
     根据token获取用户信息
     */
    public function getUserByToken(){
        $token_access = get_token_access();
        $sql = "select c.*,s.*,u.* from `customer` as c left join `shop` as s on c.customer_id=s.customer_id left join `shop_user` as u on c.customer_tel=u.suser_tel where c.customer_tel=(select suser_tel from `shop_user` where suser_id=(select user_id from `shop_token` where token_access='{$token_access}' limit 1))";
        $data = M()->query($sql)[0];
        return $data;
    }

    /*
     获取快递公司信息
     */
    public function getDelivery(){
        $sql = "select delivery_id,delivery_name from `dym_delivery` where delivery_status=1";
        $data = M()->query($sql);
        return $data;
    }

    /*
     获取门店收货信息
     */
    public function getShopDelivery(){
        $shop_id = $this->data['shop_id'];
        $sql = "select shop_id,shop_name,province,city,area,detailed,shop_longitude,shop_latitude from `customer_shop` where shop_id='{$shop_id}' and is_del='0'";
        $data = M()->query($sql)[0];
        return $data;
    }

    /*
     内部方法：检查是否是老板娘
     */
    public function isBoss(){
        $suser_id = $this->data['suser_id'];
        $sql1 = "select suser_identity from `shop_user` where suser_id='{$suser_id}'";
        $suser_identity = M()->query($sql1)[0]['suser_identity'];
        return $suser_identity;
    }



    /*
     发送短信验证码
     */
    public function sendCode(){
        $sms_type = $this->data['sms_type'];
        $msg = $this->data['msg'];
        $suser_tel = $this->data['suser_tel'];
        $code = rand(100000,999999);
        $verify_time = C('VERIFY_TIME');
        $exp_time = time()+$verify_time;
        $data = array(
                'code'=>$code,
                'msg'=>$msg
            );
        $ret = sendSMS($suser_tel,$data);
        if($ret){
            //把信息插入数据库
            $add['sms_tel'] = $suser_tel;
            $add['sms_code'] = $code;
            $add['sms_type'] =  $sms_type;
            $add['sms_exp_time'] = $exp_time;
            $ret = M('dym_sms')->add($add);
            if($ret){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }


    /*
     发送短信验证码
     */
    public function addUsrVode(){
        $phone = $this->data['phone'];
        $type = $this->data['type'];
        $code = rand(100000,999999);
        $verify_time = C('VERIFY_TIME');
        $exp_time = time()+$verify_time;
        $data = array(
                'code'=>$code,
                'msg'=>''
            );
        $ret = sendSMS($phone,$data);
        if($ret){
            //把信息插入数据库
            $add['sms_tel'] = $phone;
            $add['sms_code'] = $code;
            $add['sms_type'] =  $type;
            $add['sms_exp_time'] = $exp_time;
            $ret = M('dym_sms')->add($add);
            if($ret){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }

    

    /*
     校验验证码
     @return 验证成功返回true 失败返回false
     */
    public function verifyCode(){
        $tel = $this->data['tel'];
        $code = $this->data['code'];
        $type = $this->data['type'];
        $map['sms_tel'] = $tel;
        $map['sms_code'] = $code;
        $map['sms_type'] = $type;
        $map['sms_exp_time'] = array('EGT',time());
        $res = M('dym_sms')->where($map)->find();
        // echo M('dym_sms')->getLastSql();
        if($res){
            return true;
        }else{
            return false;
        }
    }


    

    /*
     操作记录
     */
    public function adddiary($message,$shop_id,$customer_id){
        $date["time"] = time();
        $date["event"] = $message;
        $date["shop_id"] = $shop_id;
        $date["customer_id"] = $customer_id;
        $res = M('customer_shop_operatediary')->add($date);
        if($res){
            return true;
        }else{
            return false;
        }
    }





    //添加用户足迹 
    //访问页面（0商城,1商品,2文章分类列表,3文章详情,
    //          4.个人中心,5个人资料,6我的订单,7地址管理,8我的优惠券,
    //          9我要推广,10推广佣金,11我的客服,12我要投诉,13微信留言页面）
    public function addVisit($customer_id,$message,$brand_id,$type,$v_tid=0){
        $date["customer_id"]=$customer_id;
        $date["v_content"]=$message;
        $date["v_time"]=time();
        $date["v_tid"]=$v_tid;
        $date["v_type"]=$type;
        $date["brand_id"]=$brand_id;
        $res=M('customer_wx_visit')->add($date);
        if($res){
            return true;
        }
    }

    /**
     * token插入数据表
     * token token值
     * table 表名
    */
    public function addToken(){
        $user_id = $this->data['user_id'];
        $token_time_out = time() + C('TOKENEXP')*3600*24;
        $token = setToken();
        //token表 token_access,token_time_out 
        $sql="insert into `shop_token` (token_access,token_time_out,user_id) values ('".$token."','".$token_time_out."','".$user_id."')";
        $res =M()->execute($sql);
        if($res){ 
            return $token;
        }else{ 
            return false;
        }
    }

    /**
     * token验证
     * token  token值
     * table  生成token 的表名
     * token验证 设置的token 四个小时 ，如果四个没被调用则需要重新登陆，如果某个接口被调用，则会重新刷新过期时间
    */  
    public function checkTokens(){
        $token = $this->data['token'];
        $res = M('shop_token')->where(['token_access'=>$token])->find();
        if (!empty($res)){
            if (time() - $res['token_time_out'] > 0){
                return false ; //"token长时间未使用而过期，需重新登陆";
            }
            return  true ; 
        }else{ 
            return  false; //"token错误验证失败";
        }
    }

    /*
     生成单号
     @param $field 单号字段
     @param $table 要生成单号的表
     @param $id 表id
     @return 新生成的单号
     */
    public function createNo(){
        $field = $this->data['field'];
        $table = $this->data['table'];
        $id = $this->data['id'];
        $lee_date = date('Ymd');
        $sql0 = "select {$field} from `{$table}` order by {$id} desc limit 1";
        $order_field = M()->query($sql0)[0][$field];
        if($order_field){
            if(strpos($order_field,$lee_date)===false){
                $order_field = $lee_date.'000001';
            }else{
                $order_field += 1;
            }
        }else{
            $order_field = $lee_date.'000001';
        }
        return $order_field;
    }
}