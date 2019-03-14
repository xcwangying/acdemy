<?php
namespace Home\Controller;
use Think\Controller;
/**
 * 课程模块 
*/
class CourseController extends Controller {

    //课程列表
    public function index(){
    	$data =M('pt_course')->where(['is_status'=>'0'])->limit('0,12')->select();
    	// if($data){ 
    	// 	$arrlist = [];
    	// 	foreach ($data as $key => $value) {
    	// 		if($key==0||$key==1||$key==2){ 
    	// 			$arrlist[0]['courselist'][] =$value;
    	// 		}
    	// 		if($key==3||$key==4||$key==5){ 
    	// 			$arrlist[1]['courselist'][] =$value;
    	// 		}
    	// 		if($key==6||$key==7||$key==8){ 
    	// 			$arrlist[2]['courselist'][] =$value;
    	// 		}
    	// 		if($key==9||$key==10||$key==11){ 
    	// 			$arrlist[3]['courselist'][] =$value;
    	// 		}
    	// 	}
    	// }
         
        $this->assign("data",$data);
        $this->assign('title_name','课程');
        $this->display();
    }



    //课程章节列表
    public function CourseChapterList(){ 
    	$courseinfo =M('pt_course')->where(['course_id'=>$_GET['c_id']])->field('course_name,course_id,course_intro')->find();
    	$chapterlsit =M('pt_course_chapter')->where(['course_id'=>$_GET['c_id']])->field('chapter_id,chapter_name,chapter_intro')->select();
    	if($chapterlsit){ 
    		foreach ($chapterlsit as $key => $value) {
    			$chapterlsit[$key]['sectionlist'] =M('pt_course_section')->where(['chapter_id'=>$value['chapter_id']])->field('section_id,section_name,chapter_id')->select();
    		}
    	}

    	$this->assign("courseinfo",$courseinfo);
    	$this->assign("chapterlsit",$chapterlsit);
        $this->assign('title_name','课程章节');
        $this->display();
    }



    //节详情
    public function SectionDetail(){ 
        $sectioninfo =M('pt_course_section')->alias('s')->join('pt_course_chapter cc on cc.chapter_id = s.chapter_id','left')->join('pt_course c on c.course_id = s.course_id','left')->where(['section_id'=>$_GET['s_id']])->field('s.*,c.course_name,cc.chapter_name')->find();

        $this->assign("sectioninfo",$sectioninfo);
        $this->assign('title_name','节详情');


        $chapterlsit =M('pt_course_chapter')->where(['course_id'=>$sectioninfo['course_id']])->field('chapter_id,chapter_name,chapter_intro')->select();
        if($chapterlsit){ 
            foreach ($chapterlsit as $key => $value) {
                $chapterlsit[$key]['sectionlist'] =M('pt_course_section')->where(['chapter_id'=>$value['chapter_id']])->field('section_id,section_name,chapter_id')->select();
            }
        }

        $this->assign("chapterlsit",$chapterlsit);

        $sectionlist =M('pt_course_section')->where(['chapter_id'=>$sectioninfo['chapter_id']])->field('section_id,section_name,chapter_id')->select();

 

        $this->assign("sectionlist",$sectionlist);

        //浏览次数加1
        M('pt_course_section')->where(['section_id'=>$_GET['s_id']])->setInc('browse_num');
        $this->display();
    }
    
}