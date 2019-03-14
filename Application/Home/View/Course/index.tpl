<extend name="Public/base" />
<block name="css">

</block>
<block name="content">

    <div class="container">
        <h3>课程列表</h3>
        <div class="row courseList">
             <volist name="data" id="item">
                <div class="col-lg-3">
                  <div class="card">
                    <img class="card-img-top" src="http://www.fanyoufu.com{$item.course_pic}" alt="Card image cap">
                    <div class="card-body">
                      <h5 class="card-title">{$item.course_name}</h5>
                      <p class="card-text" style="height:52px;width:100%;overflow: hidden">{$item.course_intro}</p>
                    </div>
                    
                    <div class="card-footer">
                      <a href="{:U('Course/CourseChapterList')}?c_id={$item.course_id}" class="card-link">开始学习</a>
                    </div>
                  </div>
              </div>
             </volist>
         
 
         
        </div>

      </div>

    <!-- <div class="courselist">
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
    </div>  -->
</block>
<block name="js">
</block>