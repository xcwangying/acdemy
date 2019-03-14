<?php
namespace User\Controller;
use Think\Controller;
use User\MyClass\Page;
/**
 * 后台基础身份认证
 * Class BaseController
 * @package User\Controller
 */
define('OSSIMG',C('OSSimg'));
class BaseController extends Controller {

    public function _initialize() {
        $buser_id    = session('user_id');
        $buser_name       = session('user_name');

        if (!isset($buser_id) || !isset($buser_name))
        {
            $this->redirect('Index/index');
        }

        $EXCEPT_CONTROLLER = ['Index', 'Ajax'];

        if (in_array(CONTROLLER_NAME, $EXCEPT_CONTROLLER)) {
            return;
        }
        // 获取权限列表数组
//        $authList = explode(',', session('auth'));
//        $id = M('auth')->where(['controller' => CONTROLLER_NAME, 'method' => ACTION_NAME, 'status' => 1])->getField('id');
//        if (!in_array($id, $authList)) {
//            // 展示无权操作页面
//            $this->display('Error/403');
//            exit;
//        }

        //将SESSION里面的权限字段转换成数组
        $auth = $_SESSION['auth'];
        $sauth_last = explode(',',$auth);


        //查出所有的权限
        //$xianquan = M("zb_auth")->where([status => 1])->field('id')->select();

       /* foreach ($xianquan as $k => $v) {
            $sauth[$k] = $v['id'];
        }*/

          $this->assign('sauth_last',$sauth_last);
          //所有的权限
          //$this->assign('sauth',$sauth);
          /*add by zhang*/
          //dump($_SESSION);
          //当前访问的控制器和方法
          $url=substr(__ACTION__,11);
          //dump($url);
          //echo strpos($url,'/');
          	//$url=substr($url,0,strpos($url,'/'));
          //dump($url);
          $auth = false;
          $node_list=$_SESSION['node_list'];
          //dump($node_list);
          $clcj = $this->get_all_limit();
          foreach ($node_list as $key => $value) {
          	if( in_array($url, $value) ) { 
          		$auth = true;
          	}
            /*foreach ($value as $k => $v) {
                $authArr=strpos($v,$url); 
                //dump($authArr);      
                if($authArr!==false){
                    //echo 1;
                    //说明没有有权限
                    $auth=1;
                }
             } */
          }
          $cjcj = 0; 
          foreach ($clcj as $key => $value) {
          	if( in_array($url, $value) ) { 
          		$cjcj ++ ;
          	} 
          }
          if( $cjcj == '0') $auth = true;
          if(!$auth){
            $app = __APP__;
            echo "<script>alert('你没有访问的权利！');location.href='$app/Index/index';</script>";;
            exit;
          }
    }

    public function page(){
        if(isset($_POST['page']) && !empty($_POST['page'])){
            cookie('page',$_POST['page']);
            $return_data = array(
                    'data'=>0,
                    'status'=>1,
                    'info'=>cookie("page"),
                );
            $this->ajaxReturn($return_data);
        }else{
            exit;
        }
    }

    //获取所有的权限
    public function get_all_limit(){
        $node_parent = $this->get_node_parent_all();
        $node_son = $this->get_node_son_all();
        $node_all = array();
        foreach($node_parent as $k_p => $v_p){
            foreach($node_son as $k_s => $v_s){
                $son = array();
                if($v_s['pid'] == $v_p['id']){
                    $node_all[$v_p['id']][] = $node_son[$k_s]['url'];  
                }
            }
        }
        return $node_all;
    }

        //得到所有的子节点
    public function get_node_son_all(){
        $node_list = M("mhy_user_node")->field("*")->where("status = '0'")->select();
        $node_son = array();
        array_walk($node_list,function($v,$k) use(&$node_son){
            if($v['pid']!=0 && $v['level'] ==2){
                $node_son[] = $v;
            }
        });
        usort($node_son,'node_sort');
        return $node_son;
    }

    //得到所有的父节点
    public function get_node_parent_all(){
        $node_list = M(mhy_user_node)->where("status = '0'")->select();
        $node_parent = array();
        array_walk($node_list,function($v,$k) use(&$node_parent){
            if($v['pid']==0 && $v['level'] ==1){
                $node_parent[] = $v;
            }
        });
        usort($node_parent,'node_sort');
        return $node_parent;
    }
    
    
    //编辑店铺时的对应店铺cid
    public function useStore(){
        return session('cid');
        //本店员工只能编辑本店信息(备用)
        // return session('pid');
    }
    //编辑或查看员工时的对应本店员工pid
    public function useUser(){
        return session('pid');
    }

    //用户事件操作类
    public function vipMessage($vip_id,$type_id,$massage){ 
        $data['vip_id']=$vip_id ;
        $data['v_tid']=$type_id ;
        $data['v_content']=$massage ;
        $data['v_time']=time() ;
        $data['v_type']=4 ;
        $res =M('mhy_vip_visit')->add($data);
    }



    //添加操作记录
    public function adddiary($message){
        $date["user_id"]=$_SESSION['user_id'];
        $date["event"]=$message;
        $date["dtime"]=time();
        // $date["brand_id"]=$_SESSION['userinfo']['brand_id'];
        //$date['last_login_ip']=$_SESSION['last_login_ip'];
        $res=M('pty_user_operatediary')->add($date);
        if($res){
            return true;
        }
    }

    

          //导出方法
    public function getExcel($fileName,$headArr,$data){
        import("Org.Util.PHPExcel");
        import("Org.Util.PHPExcel.Writer.Excel5");
        import("Org.Util.PHPExcel.IOFactory.php");
        //对数据进行检验
        if(empty($data) || !is_array($data)){
            die("data must be a array");
        }
        //检查文件名
        if(empty($fileName)){
            exit;
        }
        $date = date("Y_m_d",time());
        $fileName .= "_{$date}.xls";
        //创建PHPExcel对象，注意，不能少了\
        $objPHPExcel = new \PHPExcel();
        $objProps = $objPHPExcel->getProperties();

        //设置表头
        $key = ord("A");
        foreach($headArr as $v){
            $colum = chr($key);
            $objPHPExcel->setActiveSheetIndex(0) ->setCellValue($colum.'1', $v);
            $key += 1;
        }
        $column = 2;
        $objActSheet = $objPHPExcel->getActiveSheet();
        foreach($data as $key => $rows){ //行写入
            $span = ord("A");
            foreach($rows as $keyName=>$value){// 列写入
                $j = chr($span);
                $objActSheet->setCellValue($j.$column, $value);
                $span++;
            }
            $column++;
        }
        $fileName = iconv("utf-8", "gb2312", $fileName);
        //重命名表
        // $objPHPExcel->getActiveSheet()->setTitle('test');
        //设置活动单指数到第一个表,所以Excel打开这是第一个表
        $objPHPExcel->setActiveSheetIndex(0);
        //$str = $str.".xls";
            $write = new \PHPExcel_Writer_Excel5($objPHPExcel);

            header("Pragma: public");

            header("Expires: 0");

            header("Cache-Control:must-revalidate, post-check=0, pre-check=0");

            header("Content-Type:application/force-download");

            header("Content-Type:application/vnd.ms-execl");

            header("Content-Type:application/octet-stream");

            header("Content-Type:application/download");

            header("Content-Disposition:attachment;filename=$fileName");

            header("Content-Transfer-Encoding:binary");

            $write->save('php://output');

        exit;
    } 
}