<?php
use User\MyClass\AliSMS\top\TopClient;
use User\MyClass\AliSMS\top\request\AlibabaAliqinFcSmsNumSendRequest;
use User\MyClass\RedisOperate;
use OSS\FileClient;

function sytupload($id,$Prefix,$Prefixs,$num){ 

        $imginfo = getimagesize($_FILES['file']['tmp_name']);
      
        $width = $imginfo[0];
        $height = $imginfo[1];
        // if($width<750){ 
        //     $this->ajaxReturn(array('status'=>0,'msg'=>'图片宽度小于750无法上传',"data"=>''));
        // }

        // if($height<500){ 
        //     $this->ajaxReturn(array('status'=>0,'msg'=>'图片高度小于500无法上传',"data"=>''));
        // }
       
        import('Org.Net.UploadFileA');
        $upload = new \UploadFileA();// 实例化上传类
        $upload->setConfig(2);
        $upload->maxSize  = 3145728 ;// 设置附件上传大小
        $upload->allowExts  = array('jpg', 'gif', 'png', 'jpeg','zip');// 设置附件上传类型
        $upload->autoSub = true;    //是否使用子目录保存上传文件 
        $upload->subType = 'date';   //子目录创建方式，默认为hash，可以设置为hash或者date
        $upload->dateFormat = 'Ymd'; 
        $upload->savePath = './Uploads/img/'; //设置附件上传目录'dirver/avatar/'/Uploads/img
        // $upload->thumb = true;
        // $upload->thumbMaxWidth = $orgWidth.','.$thWidth;
        // $upload->thumbMaxHeight = $orgHeight.','.$thHeight;
        // $upload->thumbPrefix = $Prefixs."_org_,".$Prefixs."_th_";
        $upload->saveRule = $id;
        $info = $upload->uploadOne($_FILES['file'],$num);

        //先压缩。 750  500 
        // 裁剪  中心点 根据高宽度 对半裁剪

       
        if(!$info) {// 上传错误提示错误信息
            $pics = $upload->getErrorMsg();
           
        }else{   // 上传成功 获取上传文件信息
            import('Org.Net.UploadFileB');
            $ali = new \UploadFileB;
            $dates = date('Ymd',time());
            $image = new \Think\Image();
            $url ="Uploads/img/".$info[0]['savename'];
            $arr= explode('/',$info[0]['savename'])[1];
           
            //原图上传阿里
            $y_name = 'img/'.$Prefix.'/'.$id.'/'.$Prefixs.'_'.$arr;
            $ali->upload_file($y_name,$url);

            //大图 
            $image->open($url);
            $org_url = 'Uploads/img/'.$dates.'/'.$Prefixs.'_org_'.$arr;
            $image->thumb(750, 500,3)->save($org_url);
            $org_name = 'img/'.$Prefix.'/'.$id.'/'.$Prefixs.'_org_'.$arr;
            $ali->upload_file($org_name,$org_url);
            unlink($org_url);
            
            //小图 
            $image->open($url);
            $th_url = 'Uploads/img/'.$dates.'/'.$Prefixs.'_th_'.$arr;
            $image->thumb(375, 250,3)->save($th_url);
            $th_name = 'img/'.$Prefix.'/'.$id.'/'.$Prefixs.'_th_'.$arr;
            $ali->upload_file($th_name,$th_url);
            unlink($th_url);
            unlink($url);
            $pics = 'http://i.dym666.com/'.$org_name;

           
            
        }

        return $pics;

}


function deltetalt($object){ 
        import('Org.Net.UploadFileB');
        $ali = new \UploadFileB;
        $result = $ali->deleteObject($object);
        return $result;
}


 function myautocomplete($table, $where, $field) {
        $list = $table->where($where)->field($field)->limit(10)->select();
        foreach ($list as $key=>$val){//转换数组
            $jsondata[] = $val[$field];
        }

        
        if (!$jsondata){
            exit();
        }
        //返回json数据
        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($jsondata));
    }





function GetIpLookup(){    
    // if(empty($ip)){    
    //    return '请输入IP地址';  
    // }    

    $ip =  get_client_ip();
    $res = @file_get_contents('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=' . $ip);    
    if(empty($res)){ return false; }    
    $jsonMatches = array();    
    preg_match('#\{.+?\}#', $res, $jsonMatches);    
    if(!isset($jsonMatches[0])){ return false; }    
    $json = json_decode($jsonMatches[0], true);    
    if(isset($json['ret']) && $json['ret'] == 1){    
        $json['ip'] = $ip;    
        unset($json['ret']);    
    }else{    
        return false;    
    }    
    return $json;    
} 


/*
    *公众号发送模板消息
    */
    function xiao_send_template_message($touser,$template_id, $url,$data,$page){
        $template = array(
            'touser' => $touser,
            'template_id' => $template_id,
            'url' => $url,
            "miniprogram"=>[
             "appid"=>"wx5fca527f937eccb7",
             "pagepath"=>$page
           ],  
            'data' => $data
        );
        $access_token= getAccessToken(1);
        $json_template = json_encode($template);
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=".$access_token;
        $dataRes = http_post($url, urldecode($json_template));

        if ($dataRes['errcode'] == 0) {
            return true;
        } else {
            return false;
        }
    }

    /*
    *公众号发送模板消息
    */
    function send_template_message($touser,$template_id, $url,$data,$brand_id){
        
        $template = array(
            'touser' => $touser,
            'template_id' => $template_id,
            'url' => $url,
            'data' => $data
        );
        $access_token= getAccessToken($brand_id);
        $json_template = json_encode($template);
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=".$access_token;
        $dataRes = http_post($url, urldecode($json_template));
        file_put_contents('./ata.txt',var_export($dataRes,true));
        if ($dataRes['errcode'] == 0) {
            return true;
        } else {
            return false;
        }
    }





    //公众方法，请求微信接口(一般为get请求)
   function https_request($url,$data = null){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        if (!empty($data)){  
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($curl);
        curl_close($curl);
        return $output;
    }    


    //POST请求接口
    function http_post($url,$param){
        $oCurl = curl_init();
        if(stripos($url,"https://")!==FALSE){
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, false);
        }
        if(is_string($param)){
            $strPOST = $param;
        }else{
            $aPOST=array();
            foreach($param as $key=>$val){
                $aPOST[]=$key."=".urlencode($val);
            }
            $strPOST =  join("&", $aPOST);
        }
        curl_setopt($oCurl, CURLOPT_URL, $url);
        curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1 );
        curl_setopt($oCurl, CURLOPT_POST,true);
        curl_setopt($oCurl, CURLOPT_POSTFIELDS,$strPOST);
        $sContent = curl_exec($oCurl);
        $aStatus = curl_getinfo($oCurl);
        curl_close($oCurl);
        return $sContent;
    }

    

    /**
     * @desc 获取普通的access_token
     * @param string $brand_id 品牌id
     **/
    function getAccessToken($brand_id){
        $tokeninfo=M('access_token','wx_')->field('access_token,expire_time')->where(['brand_id'=>$brand_id])->find();
         $brandinfo=M('brand')->field('wx_appid,wx_appsecret')->where(['brand_id'=>$brand_id])->find();
       


        // $data=$tokeninfo['access_token'];$tokeninfo['expire_time'];
        if ($tokeninfo['expire_time'] < time()){
             $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$brandinfo['wx_appid']."&secret=".$brandinfo['wx_appsecret'];
            $res = json_decode(https_request($url));
            $access_token = $res->access_token;

            if ($access_token){
                $datas['expire_time'] = time() + 3600;
                $datas['access_token'] = $access_token;
                $re=M('access_token','wx_')->where(['brand_id'=>$brand_id])->save($datas);
            }
           
        }else{

            $access_token = $tokeninfo['access_token'];
        }
   
    
        return $access_token;
    }



    



	
   


/*add by liu*/
/*$name上传框的前缀
*返回保存图片的名称
*失败返回false
*/

/*
 * 图片写入(产品用)
 * name 图片名称
 * id   功能id（产品id）
 * dz  oss地址  img/product
 */
function writepic($name,$id,$dz = 'img',$savename = OSSIMG){
    if($name){
        if( !$savename ) return false;
        //图片base解码
        $img = base64_decode(addslashes($_POST[$name.'_hid']));
        // $img_name = date("YmdHis",time()).substr(md5(join("",explode(".",sprintf("%.4f",microtime(TRUE))))),0,8).".jpg";
        $img_name = $id.'.jpg';
        //创建目录
        if(!is_dir('./'.$savename.'/'.date('Ymd').'/')) {
            mkdir('./'.$savename.'/'.date('Ymd').'/',0777,true);
        }
        $re = file_put_contents('./'.$savename.'/'.date('Ymd').'/'.$img_name,$img);
        if( !$re )  return false; 
        import('Org.Net.UploadFileB'); //没用think config的参数，用OSS/Config.php配置的参数
        $dir_name = $dz.'/'.$id.'/';
        $path = './'.$savename.'/'.date('Ymd').'/'.$img_name;
        //图片裁剪
        $image = new \Think\Image();
        $image->open($path);
        $width = $image->width(); // 返回图片的宽度
        $image->thumb(375, 375)->save('./'.$savename.'/'.date('Ymd').'/th_'.$img_name);
        
        $th_path = './'.$savename.'/'.date('Ymd').'/th_'.$img_name;
        $re1 = \UploadFileB::upload_file($dir_name.$img_name,$path);
        $re2 = \UploadFileB::upload_file($dir_name.'th_'.$img_name,$th_path);
        
        if( strpos($re1,$dir_name.$img_name)!== false){
            unlink ('./'.$savename.'/'.date('Ym').'/'.$img_name);
            unlink ('./'.$savename.'/'.date('Ym').'/th_'.$img_name);
            return $dir_name.'th_'.$img_name;
        }else{
            return false;
        }
    }
    return false; 
}

/*
 * 图片写入(文章用)
 * name 图片名称（产品用）
 * id   功能id（文章id）
 * dz  oss地址  img/article
 */
function writepic_a($name,$id,$dir_name,$savename = OSSIMG){
    if($name){
        if( !$savename ) return false;
        //图片base解码
        $img = base64_decode(addslashes($_POST[$name.'_hid']));
        // $img_name = date("YmdHis",time()).substr(md5(join("",explode(".",sprintf("%.4f",microtime(TRUE))))),0,8).".jpg";
        $img_name = md5($id).'.jpg';
        //创建目录
        if(!is_dir('./'.$savename.'/'.date('Ymd').'/')) {
            mkdir('./'.$savename.'/'.date('Ymd').'/',0777,true);
        }
        $re = file_put_contents('./'.$savename.'/'.date('Ymd').'/'.$img_name,$img);
        if( !$re )  return false; 
        import('Org.Net.UploadFileB'); //没用think config的参数，用OSS/Config.php配置的参数
        $path = './'.$savename.'/'.date('Ymd').'/'.$img_name;
        $re1 = \UploadFileB::upload_file($dir_name.$img_name,$path);
        if( strpos($re1,$dir_name.$img_name)!== false ){
            unlink ('./'.$savename.'/'.date('Ymd').'/'.$img_name);
            return $dir_name.$img_name;//C('http').
        }else{
            return false;
        }
        //生成图片名
        //$goods_image_name = $savename.date("Ymd",time())."/".md5(time().rand(1000,9999)).$name.'.jpg';
        
        //创建目录
        // if(!is_dir($savename.date("Ymd",time()))) {
        //     mkdir($savename.date("Ymd",time()),0777,true);
        // }
        //写入文件
        //$savename = file_put_contents($goods_image_name,$img);
    }
    return false; 
}

// function writepic_a($name,$id,$savename = OSSIMG){
//     if($name){
//         if( !$savename ) return false;
//         //图片base解码
//         $img = base64_decode(addslashes($_POST[$name.'_hid']));
//         // $img_name = date("YmdHis",time()).substr(md5(join("",explode(".",sprintf("%.4f",microtime(TRUE))))),0,8).".jpg";
//         $img_name = $id.'.jpg';
//         //创建目录
//         if(!is_dir('./'.$savename.'/'.date('Ymd').'/')) {
//             mkdir('./'.$savename.'/'.date('Ymd').'/',0777,true);
//         }
//         $re = file_put_contents('./'.$savename.'/'.date('Ymd').'/'.$img_name,$img);

//         if( !$re )  return false; 
//         $dir_name = $dz.'/'.$id.'/';
//         $path = './'.$savename.'/'.date('Ymd').'/'.$img_name;

//         import('Org.Net.UploadFileB'); //没用think config的参数，用OSS/Config.php配置的参数
//         $re1 = \UploadFileB::upload_file($dir_name.$img_name,$path);
//         if( strpos($re1,$dir_name.$img_name)!== false ){
//             unlink ('./'.$savename.'/'.date('Ymd').'/'.$img_name);
//             return $dir_name.$img_name;
//         }else{
//             return false;
//         }
//     }
//     return false; 
// }

    /*
      表单多文件上传到阿里云
     */
    function uploadali(){

        $retarr = array();
        $rootpath = './'.OSSIMG.'/'.date('Ym').'/';
        if(!is_dir($rootpath)) {
            mkdir($rootpath,0777,true);
        }
        import('Org.Net.UploadFileB');
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath  =     $rootpath; // 设置附件上传根目录
        $upload->thumb = true;
        $upload->thumbMaxWidth = "200,414";
        $upload->thumbMaxHeight = "200,414";
        $upload->thumbPrefix = "shop_th_,shop_org_";

        // 上传文件 
        $info   =   $upload->upload();

        if(!$info) {// 上传错误提示错误信息
            return $upload->error($upload->getError());
        }else{// 上传成功 获取上传文件信息
            foreach($info as $file){
                $savepath = $rootpath.$file['savepath'].$file['savename'];
                //$savename = $file['savename'];
                $savename = OSSIMG.'/'.date('Ym').'/'.$file['savename'];
                $re1 = \UploadFileB::upload_file($savename,$savepath);
                if( strpos($re1,$savename)!== false ){
                    $retarr[] = $savename;
                }else{
                    $retarr[] = '';
                }
            }
        }
        return $retarr;
    }





//上传阿里云oss
//$dz 存入阿里云那个文件夹
function uploada($dz){ 
     import('ORG.Util.UploadFileA');
        $upload = new UploadFileA();// 实例化上传类
        $upload->setConfig(3);
        //$upload->maxSize  = 3145728 ;// 设置附件上传大小
        $upload->allowExts  = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->autoSub = true;//是否使用子目录保存上传文件 
        $upload->subType = 'date';//子目录创建方式，默认为hash，可以设置为hash或者date
        $upload->dateFormat = 'Ymd';
        $upload->savePath =   $dz;// 设置附件上传目录
        $upload->thumb = true;
        //$upload->thumbMaxWidth = "150";
        //$upload->thumbMaxHeight = "120";
        $upload->thumbPrefix = "tn_";
        if(!$upload->upload()) {// 上传错误提示错误信息
            $uploadList=$upload->getErrorMsg();
        }else{// 上传成功 获取上传文件信息
            $uploadList = $upload->getUploadFileInfo();      
            
        }
        return $uploadList;

}


    /*end by liu*/
function truncate($address) {
    $len=mb_strlen($address,"utf-8");
    if ($len>16) {
        $address = mb_substr($address,0,10,"utf-8")."...";
    }
    return $address;
}
function trun($content) {
    $len = mb_strlen($content,"utf-8");
    if ($len>16) {
        $address = mb_substr($content,0,10,"utf-8")."...";
    }
    return $content;
}
/**
 * 生成短信验证码
 * @author 高寒 <20763310@qq.com>
 * @param $tel 发送的手机号码
 * @return status_code
 * -1   - 手机号码非法
 * 0    - 发送时间太频繁
 * 1    - 发送成功
 * 2    - 其他错误
 */
function sendSMSCode($tel) {
    // 生成4位数随机数字
    $code = sprintf('%06d', mt_rand(0, 999999));
    // 将验证码和时间戳写入session
    session('code', $code);
    session('code_time', time());
    // 使用阿里大于短信平台SDK发送验证码
    date_default_timezone_set('Asia/Shanghai');
    $c = new TopClient;
    $req = new AlibabaAliqinFcSmsNumSendRequest;
    $req->setSmsType('normal');
    $req->setSmsFreeSignName('来客多');
    $param = ['code' => $code, 'product' => '来客多试用'];
    $req->setSmsParam(json_encode($param));
    $req->setRecNum($tel);
    $req->setSmsTemplateCode('SMS_8180186');
    $resp = $c->execute($req);

    $status_code = 2;
    if ($resp['result']['success'] == true) {
        $status_code = 1;
    } else {
        if ($resp['sub_code'] == 'isv.MOBILE_NUMBER_ILLEGAL') {
            $status_code = -1;
        } else if ($resp['sub_code'] == 'isv.BUSINESS_LIMIT_CONTROL') {
            $status_code = 0;
        }
    }
    return $status_code;
}

/**
 * 效验短信验证码
 * @author 高寒 <20763310@qq.com>
 * @return  status_code
 * -1   - 验证码已过期
 * 0    - 验证码错误
 * 1    - 效验成功
 */
function checkSMSCode($code) {
    // 获取session中的时间戳
    $code_time = session('code_time');
    // 检查时间戳是否过期(180s)
    if ($code_time - time() > 180) {
        $status_code = -1;
    }

    // 检查验证码是否正确
    if ($code == session('code')) {
        $status_code = 1;
    } else {
        $status_code = 0;
    }
    return $status_code;
}

/*
* 按月份获得营业数据
* $pid 店铺ID
* $j =当月时间的天数
* $day= 月份的第一天时间 格式 2016-08-01
* $pay_type支付类型
*/

function monthcount($j,$day,$order_state){
        $order= M('order','ybs_');
        $j = $j; //获取当前月份天数
        $daytime = 86400; //一天时间戳
        $start_time = strtotime($day);  //获取本月第一天时间戳
        $arr = explode("-",$day);
        $arr =($arr[0]-1)."-".$arr[1]."-".$arr[2];
        $start_time2= strtotime($arr);//获得去年本月第一天时间戳
        $day_info = array();
        //日销售额 以及销售数量
         if($order_state){
            $map1['order_state']=$order_state;
            $map2['order_state']=$order_state;
        }
        $map1['order_state']=array('in','10,20' );;
        $map2['refund_state'] =0;
        $map2['lock_state']= 0;
        for($i=0;$i<$j;$i++){
             $x= $start_time+$i*$daytime;//每隔一天赋值给数组
             $y= $start_time2+$i*$daytime;//去年的时间
             $x1=$x+$daytime;
             $y1=$y+$daytime;
             $day_info[$i]['today']= date('Y-m-d',$x);
             $day_info[$i]['twoday']= date('Y-m-d',$y);
             $map1['stime']  = array('BETWEEN',array("{$x}","{$x1}"));
             $map2['stime']  = array('BETWEEN',array("{$y}","{$y1}"));
            $day_info[$i]['today_info']=$order->where($map1)->sum('order_amount');//当天的销售额
            $day_info[$i]['twoday_info']=$order->where($map2)->sum('order_amount');//去年同比当天的销售额
            $num=$order->where($map1)->count();//当天销售数量
            $day_info[$i]['today_num']=$num?$num:0;
        }
  
        return $day_info;
}

   
    /*
     将流文件保存为临时文件
     @param stream base64输入流
     @param tmpname 临时文件路径
    */
    function uploadBase64($stream,$preid,$id,$index,$savepath = OSSIMG) {
        if(empty($stream)) return false;
        if(preg_match('/^(data:image\/(\w+);base64,)/',$stream,$str)){
            $suffix = "tmp";
            $dir = $savepath.'/'.date('Ym');
            if(!is_dir($dir)){
                mkdir($dir);
                chmod($dir,'0755');
            }
            // $tmpname = $dir.'/'.time().'-'.rand(100000,999999).".{$suffix}";
            $tmpname = $dir.'/real_'.$preid.'_'.$id.'_index_'.$index.".{$suffix}";
            if (file_put_contents($tmpname,base64_decode(str_replace($str[1],'',$stream)))){
                return $tmpname;
            }else{
                return $tmpname;
            }
        }else{
            return '2';
        }
    }

    /*
    获取文件类型
    @param filename 文件名
    @param suffix 文件真实后缀 .jpg .png .gif
    */
    function getSuffix($fileName){
        $file = fopen($fileName, "rb");
        $bin = fread($file, 2); // 只读2字节
        fclose($file);
        $strInfo = @unpack("C2chars", $bin);
        $typeCode = intval($strInfo['chars1'].$strInfo['chars2']);
        $suffix = ".";
        if($typeCode == 255216){
            $suffix .= "jpg";
        }elseif($typeCode == 7173){
            $suffix .= "gif";
        }elseif($typeCode == 13780){
            $suffix .= "png";
        }else{
            $suffix = false;
        }
        return $suffix;
    }


    /*订单处理 end by liu*/
 /**
 * 友好的时间显示
 *
 * @param int    $sTime 待显示的时间
 * @param string $type  类型. normal | mohu | full | ymd | other
 * @param string $alt   已失效
 * @return string
 */
function friendlyDate($sTime,$type = 'normal',$alt = 'false') {
    if (!$sTime)
        return '—';
    //sTime=源时间，cTime=当前时间，dTime=时间差
    $cTime      =   time();
    $dTime      =   $cTime - $sTime;
    $dDay       =   intval(date("z",$cTime)) - intval(date("z",$sTime));
    //$dDay     =   intval($dTime/3600/24);
    $dYear      =   intval(date("Y",$cTime)) - intval(date("Y",$sTime));
    //rmal：n秒前，n分钟前，n小时前，日期
    if($type=='normal'){
    	// if($sTime==0){
    	// 	return "-";
    	// }
        if($dTime>0){            
            if( $dTime < 60 ){
                if($dTime < 10){
                    return '刚刚';    //by yangjs
                }else{
                    return intval(floor($dTime / 10) * 10)."秒前";
                }
            }elseif( $dTime < 3600 ){
                return intval($dTime/60)."分钟前";
            //今天的数据.年份相同.日期相同.
            }elseif( $dYear==0 && $dDay == 0  ){
                //return intval($dTime/3600)."小时前";
                return '今天'.date('H:i',$sTime);
            }elseif($dYear==0){
                return date("m月d日 H:i",$sTime);
            }else{
                return date("Y-m-d H:i",$sTime);
            }
        }else{
            return date("Y年m月d日",$sTime);
        }
    }elseif($type=='mohu'){
        if( $dTime < 60 ){
            return $dTime."秒前";
        }elseif( $dTime < 3600 ){
            return intval($dTime/60)."分钟前";
        }elseif( $dTime >= 3600 && $dDay == 0  ){
            return intval($dTime/3600)."小时前";
        }elseif( $dDay > 0 && $dDay<=7 ){
            return intval($dDay)."天前";
        }elseif( $dDay > 7 &&  $dDay <= 30 ){
            return intval($dDay/7) . '周前';
        }elseif( $dDay > 30 ){
            return intval($dDay/30) . '个月前';
        }
    //full: Y-m-d , H:i:s
    }elseif($type=='full'){
        return date("Y-m-d , H:i:s",$sTime);
    }elseif($type=='ymd'){
        return date("Y-m-d",$sTime);
    }else{
        if( $dTime < 60 ){
            return $dTime."秒前";
        }elseif( $dTime < 3600 ){
            return intval($dTime/60)."分钟前";
        }elseif( $dTime >= 3600 && $dDay == 0  ){
            return intval($dTime/3600)."小时前";
        }elseif($dYear==0){
            return date("Y-m-d H:i:s",$sTime);
        }else{
            return date("Y-m-d H:i:s",$sTime);
        }
    }
}

/*
 百度编辑器内容处理
 */
function baidu($str,$dz){
    //替换某些图片后缀
    //dump($str);//http://admin.dym666.com/ueditor/php/upload/video/1501316297429972.mp4
    $str = str_replace("?x-oss-process=style/xm",'',$str);
    $str = str_replace("?x-oss-process=image/resize,w_640/auto-orient,1/crop,x_0,y_164,w_640,h_974",'',$str);
    //背景图片替换开始
    $array = explode("url(&quot;",$str);
    foreach($array as $k => $v){
        $array[$k] = substr($v,0,stripos($v,"&quot;"));
    }
    unset($array[0]);
    if(!file_exists(C('xiumi'))){
        $res = mkdir(C('xiumi'));
        // dump(!file_exists(C('xiumi').date("Ymd",time())));
        if(!$res){
            echo "图片文件创建失败！";
            exit;
        }
    }
    
    foreach($array as $k => $v){
        $filename = strrchr($v,"/");

        if( !($v == C("yuming").C('xiumi').$filename) ){
            $abc = put_file_from_url_content($v,C('xiumi').$filename,$dz);
            if( !$abc ) {echo "图片上传失败1！";exit();}
            $str = str_replace($v,$abc,$str);//C("yuming").C('xiumi').$filename
        }  
    }
    //dump($str);
    //背景图片替换结束
    //图片替换开始
    //dump($array);exit;
    $array1 = explode("<img",$str);
    foreach($array1 as $k => $v){
        $array1[$k] = str_replace('src="','',substr($v,stripos($v,'src="')));
        $array1[$k] = substr($array1[$k],0,stripos($array1[$k],'"'));
    }
    // var_dump($array1);exit;
    unset($array1[0]);
    foreach($array1 as $k => $v){
        $filename = strrchr($v,"/");
        if(!($v == C("yuming").C('xiumi').$filename)){
             $abc = put_file_from_url_content($v,C('xiumi').$filename,$dz);//echo "<br>4";
            if( !$abc ) {echo "图片上传失败2！";exit();}
            $str = str_replace($v,$abc,$str);
        }
    }
    //图片替换结束
    //dump($str);
    //新加本地图片替换
    $pattern = '/<img.*?src="(http:\/\/admin\.dym666\.com\/ueditor\/php\/upload\/image\/.*?)".*?\/>/';
    preg_match_all($pattern,$str,$match);
    foreach ($match['1'] as $key => $value) {
        $cj = $value;
        $cl = bd(str_replace('http://admin.dym666.com','.',$value),$dz);

        if( $cl ) { 
            $str = str_replace($cj,$cl,$str);
        } else { 
            echo "图片上传失败3！";exit();
        }
    }
    $str = preg_replace('/<p>/','<p style="line-height:1.2rem;">',$str);
    $str = preg_replace('/preload=[\'\"]none[\'\"]/','preload="preload"',$str);
    $str = preg_replace('/width=[\'\"]420[\'\"] height=[\'\"]280[\'\"]/',' autoplay="autoplay" style="width:100%;"',$str);
    //dump($str);
    //exit();
    return $str;


}



//将xml转化为数组
function xmlToArray($xml){
    $array_data = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);      
    return $array_data;
}

function ret($code,$msg,$data){
    header('content-type:application/json');
    $arr = array(
            'code'=>$code,
            'msg'=>$msg,
            'data'=>$data
        );
    $ret = json_encode($arr);
    exit($ret);
}

function OSS($file){
    Vendor('Alioss.autoload');
    $ossClient = new FileClient($file);
    // var_dump($ossClient);
    return $ossClient;
}

function app_push($cids,$title,$text,$transmission){

   import('Push.DemoDriver');
     $re = pushMessageToList($cids,$title,$text,$transmission);
      file_put_contents('./push1.txt',var_export($re,true));
     if($re['result'] == 'ok'){
        return true;
     }else{
        return false;
     }

  }

  function sub_str($text,$len){
   
    return strlen($text)<=$len ? $text : (substr($text,0,$len).chr(0)."...");
}


/*
 单文件上传到本地
 @return mix 成功返回文件名 失败返回false
 */
function saveToLocal(){
    $file = $_FILES['file'];
    $dir = C('OSSIMG').'/tmp/';
    if(!is_dir($dir)){
        $ret = mkdir($dir);
        if(!$ret){
            return false;
        }
    }
    $upload = new \Think\Upload();
    $upload->maxSize   =     200000000 ;
    $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');
    $upload->rootPath = $dir;
    $upload->savePath = '';
    $upload->autoSub = false;
    $info = $upload->uploadOne($file);

    if($info){
        $name = $dir.$info['savename'];
        $image = new \Think\Image(); 
        $image->open($name);
        $width = $image->width();
        $height = $image->height();
        $rate = 1;
        if($width>=$height){
            $rate = $width/$height;
        }else{
            $rate = $height/$width;
        }
        if($rate > 2){
            return false;
        }
        return $name;
    }else{
        return false;
    }
}

/*
 生成缩略图
 @param $orgname 原图
 @param $name 中等图
 @param $thname 缩略图
 */
function thumbPic($arr){
    $orgname = $arr['orgname'];
    $name = $arr['name'];
    $thname = $arr['thname'];
    $image = new \Think\Image(); 
    $image->open($orgname);
    $image->thumb(400, 400,\Think\Image::IMAGE_THUMB_CENTER)->save($name);
    $image->thumb(156, 156,\Think\Image::IMAGE_THUMB_CENTER)->save($thname);
}


/*
 把本地文件上传到阿里云（单文件）
 1、修改本地文件为阿里需要的路径
 2、处理上传
 3、路径格式:img/com/1/1.jpg img/com/1/org_2.jpg
 @param $name 文件名
 @param $module 模块名
 @param $id 模块ID
 @param $index 第几张图片
 */
function uploatToAli($filename){
    $dir = C('OSSIMG').'/accomment/'.date("Ymd");
    $ext = pathinfo($filename,PATHINFO_EXTENSION);
    if(!is_dir($dir)){
        $ret = mkdir($dir,0755,true);
        if(!$ret){
            return false;
        }
    }
    $index =uniqid();
    $orgname = $dir.'/org_'.$index.'.'.$ext;
    $name = $dir.'/'.$index.'.'.$ext;
    $thname = $dir.'/th_'.$index.'.'.$ext;
    $ret1 = rename($filename,$orgname);
    if(!$ret1){
        return false;
    }
    $arr = array(
            'orgname'=>$orgname,
            'name'=>$name,
            'thname'=>$thname,
        );
    thumbPic($arr);
    $ret1 = upload_file($orgname);
    $ret2 = upload_file($name);
    $ret3 = upload_file($thname);
    if(!$ret1 || !$ret2 || !$ret3){
        return false;
    }
    // $ret1 = str_replace("http://dym666.oss-cn-shenzhen.aliyuncs.com/","",$ret1);
    // $ret2 = str_replace("http://dym666.oss-cn-shenzhen.aliyuncs.com/","",$ret2);
    // $ret3 = str_replace("http://dym666.oss-cn-shenzhen.aliyuncs.com/","",$ret3);
    $ret = array(
            'orgname'=>$ret1,
            'name'=>$ret2,
            'thname'=>$ret3,
        );
    return $ret;
}

 /*
     * 上传图片到阿里云
     * @file_name        文件名称  如：/img/01.jpg
     */
    function upload_file($file_name){
        require_once "./Public/OSS/autoload.php";
        require_once "./Public/OSS/Config.php";
        require_once "./Public/OSS/Common.php";
        //修改文件目录结构,都使用单一的文件结构
        //实例化bucket,实现文件上传方法
        $bucket = Common::getBucketName();
        //创建ossClient实例
        $ossClient = Common::getOssClient();
        if (is_null($ossClient)) exit('1');
        // 上传本地文件
        $file_full = str_replace('\\',DIRECTORY_SEPARATOR,trim($file_name,DIRECTORY_SEPARATOR));
        if(is_file($file_full)){
            $re = $ossClient->uploadFile($bucket,$file_name,$file_full);
            return $re;
        }else if(is_dir($file_full) && is_file($file_full.DIRECTORY_SEPARATOR.$file_name)){
            $re = $ossClient->uploadFile($bucket,$file_name,$file_full.DIRECTORY_SEPARATOR.$file_name);
            return $re;
        }else{
            exit('2');//图片错误
        }
    }
  

