<extend name="Public/base" />
<block name="css">
    <style>
     .courselist{width:60%;margin:0 auto;margin-top:0%;height:100%;margin-bottom:30px;overflow: hidden;overflow-x: hidden;
        padding-top:0px;
    }  
    .intro{height:60px;width:100%;overflow: hidden}
    .title{ 
        width:100%;height:17px;overflow: hidden
     }
    </style>
</block>
<block name="content">
    <div class="courselist">
        <div >
            <h2 style='margin-top:0px'>课程列表</h2>
        </div>
        <volist name="data" id="item">
            <div class="row ">
                <volist name= "item.courselist" id="vo">
                    <div class="col-sm-6 col-md-4">
                         <div class="thumbnail">
                            <img src="http://www.fanyoufu.com{$vo.course_pic}">
                            <div class="caption">
                                <h4 class="title">{$vo.course_name}</h4>
                                <p class="intro">{$vo.course_intro}</p>
                                <p>
                                    <a href="{:U('Course/CourseChapterList')}?c_id={$vo.course_id}" class="btn btn-danger lrs" role="button">
                                        加入学习
                                    </a>
                                </p>
                            </div>
                         </div>
                    </div>
                </volist>
            </div>
        </volist>
    </div> 
</block>
<block name="js">
</block>