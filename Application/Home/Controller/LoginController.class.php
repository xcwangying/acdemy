<?php
namespace Home\Controller;
use Think\Controller;
/**
 * 登录验证
 * Class LoginController
 * @package Admin\Controller
 * @author 谢成 <1075997355@qq.com>
 */
class LoginController extends Controller {


    //登录首页
    public function index() {
        $this->display();
    }

    //登录验证
    public function login() {
        $phone      = I('post.phone');
        $password   = I('post.password');
        if ($phone == '' || $password == '')
        {
            $this->ajaxReturn(['msg'=>'账号或密码不能为空','href'=>'Login/index','status'=>0]);
        }
        $userData   = M('pty_user')->where(['user_tel' => $phone])->find();

        if ($userData)
        {
            if (md5($password) == $userData['user_password'])
            {
                // 设置session信息
                session('user_id', $userData['user_id']);//用户ID
                session('user_name', $userData['user_name']);
                session('user_tel', $userData['user_tel']);
                // 设置session信息(为了权限)
                $this->savesession($userData);
                //遍历权限,登录成功跳转到默认的第一个权限的控制器
                foreach ($_SESSION['node_list'] as $key => $value) {
                    foreach ($value as $k => $v) {
                         $urlList[]=$v;
                    } 
                }
                
                if(!$urlList[0]){
                    $this->ajaxReturn(['msg'=>'该账号没有权限!','href'=>'Login/index','status'=>0]);
                }
          
                $return['data']='Index/index';
                $return['info']='登录成功！';
                $return['status']=1;
                echo json_encode($return);
                exit;
            }
            else
            {
                $this->ajaxReturn(['msg'=>'密码错误','href'=>'Login/index','status'=>0]);
            }
        }
        else
        {
            $this->ajaxReturn(['msg'=>'账号错误','href'=>'Login/index','status'=>0]);
        }
    }

    public function register(){

        $this->display();
    }
    //注销用户
    public function logout() {
        // 清空session
        session('user_id', null);
        session('user_name', null);
        $this->ajaxReturn(['status' => 1, 'msg' => '注销成功']);
        
    }

    

    public function savesession($userData){


        //获取员工权限
       	//门店权限表
        //如果搞两个权限的表
        if($userData['is_manager'] == '1'){//最高管理员
            $node_list = $this->get_all_limit();
            
        }else{ //一般管理员
           
            $node_list = $this->getAccessList($userData['user_id']);
        }
        $_SESSION['node_list'] = $node_list;
        $userData['node_list'] = $node_list;
        $_SESSION['userinfo'] = $userData;

        
        //更新最后登录时间和最后登录IP字段
       //  $data['ultime']    = date('Y-m-d H:i:s');
       //  $data['last_login_ip']      = get_client_ip();
       // M('user','ybs_')->where(array('id' => $userData['uid']))->save($data);
    }

    //获取所有的权限
    public function get_all_limit(){
        $node_parent = $this->get_node_parent_all();
        $node_son = $this->get_node_son_all();
        $node_all = array();
        foreach($node_parent as $k_p => $v_p){
            foreach($node_son as $k_s => $v_s){
                $son = array();
                if($v_s['pid'] == $v_p['node_id']){
                    $node_all[$v_p['node_id']][] = $node_son[$k_s]['url'];  
                }
            }
        }
        return $node_all;
    }

        //得到所有的子节点
    public function get_node_son_all(){
        $node_list = M("pty_user_node")->field("*")->where("status = '0'")->select();
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
        $node_list = M("pty_user_node")->where("status = '0'")->select();
        $node_parent = array();
        array_walk($node_list,function($v,$k) use(&$node_parent){
            if($v['pid']==0 && $v['level'] ==1){
                $node_parent[] = $v;
            }
        });
        usort($node_parent,'node_sort');
        return $node_parent;
    }

    //一般操作员登录,获取权限列表
    private function getAccessList($uid){
        $node_parent = $this->get_node_parent_u($uid);
        $node_son = $this->get_node_son_u($uid);
        $node_u = array();
        foreach($node_parent as $k_p => $v_p){
            foreach($node_son as $k_s => $v_s){
                $son = array();
                if($v_s['pid'] == $v_p['node_id']){
                    $node_u[$v_p['node_id']][] = $node_son[$k_s]['url'];
                }
            }
        }
        return $node_u;
    }
    //得到该操作员的父节点
    public function get_node_parent_u($uid){

        $access=M();
        $map = array(
        't1.user_id'=>$uid,
        't2.level'=>'1',
        't2.pid'=>'0',
        't2.status'=>'0',
        );
        $node_parent = $access->table('pty_user_access t1 join pty_user_node t2 on t1.node_id=t2.node_id')->where($map)->select();
        usort($node_parent,'node_sort');
        return $node_parent;
    }
    //得到该操作员的子节点
    public function get_node_son_u($uid){

        $access=M();
        $map = array(
        't1.user_id'=>$uid,
        't2.level'=>'2',
        't2.status'=>'0',
        );
        $node_son = $access->table('pty_user_access t1 join pty_user_node t2 on t1.node_id=t2.node_id')->where($map)->select();
        usort($node_son,'node_sort');
        return $node_son;
    }


    //添加操作记录
    public function adddiary($message){
        $date["user_id"]=$_SESSION['user_id'];
        $date["event"]=$message;
        $date["dtime"]=time();
        $res=M('operatediary','pty_')->add($date);
        if($res){
            return true;
        }
    }
}