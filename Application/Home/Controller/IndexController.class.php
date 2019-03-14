<?php
namespace Home\Controller;
use Think\Controller;
/**
 * 首页模块
*/
class IndexController extends Controller {
    //用户管理
    public function index(){
    	$data =M('pt_course')->where(['is_status'=>'0'])->limit('0','4')->select();
    	$data['banner'] =M('pt_banner_img')->where(['is_status'=>'0'])->select();
    	$artlist =M('pt_course_section')->alias('cs')->join('pt_user u on u.user_id= cs.user_id','left')->where(['cs.is_fb'=>'1'])->limit('0,10')->order('cs.dtime desc')->field('cs.*,u.user_name')->select();
 
        foreach ($artlist as $key => $value) {
            // $artlist[$key]['section_content'] = mb_substr($value['section_content'],0,300,'utf-8');
            $artlist[$key]['section_content'] =str_replace("#","",mb_substr($value['section_content'],0,300,'utf-8'));
            $info =M('pt_course_chapter')->alias('cc')->join('pt_course c on c.course_id =cc.course_id','left')->where(['cc.chapter_id'=>$value['chapter_id']])->field('cc.chapter_name,c.course_name')->find();
            
            $artlist[$key]['course_name'] =$info['course_name'];
            $artlist[$key]['chapter_name'] =$info['chapter_name'];
        }
        // dump($artlist);
        $data['artlist'] =$artlist;
        //mb_substr($str , 0 , 5); mb_substr($value['section_content'] , 0 ,200)
    	// $data['artlist'] =M('pt_course_section')->alias('s')->join('pt_user u on u.user_id =s.user_id','left')->where(['s.is_status'=>'0'])->order('s.up_time desc')->limit('0,10')->field('s.*,u.user_name')->select();
    	$this->assign('data',$data);
    	$this->assign('title_name','首页');
        $this->display();
    }



}