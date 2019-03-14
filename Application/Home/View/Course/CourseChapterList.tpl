<extend name="Public/base" />
<block name="css">


</block>
<block name="content">

<div class="container">

                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                      <li class="breadcrumb-item"><a class="text-dark"  href="http://www.fanyoufu.com/web.php/Index/index.html">主页</a></li>
                      <li class="breadcrumb-item"><a class="text-dark"  href="http://www.fanyoufu.com/web.php/Course/index.html">全部课程</a></li>
                      <li class="breadcrumb-item active" aria-current="page">{$courseinfo['course_name']}</li>
                    </ol>
                  </nav>

              <div class="courseDetail">
                <div class="card mb1">
                    <div class="card-body">
                        简介：{$courseinfo['course_intro']}
                    </div>
                </div>
                <volist name ="chapterlsit" id="item" key="k">
                    <div class="card mb1">
                      <div class="card-header">
                          第{$k}章：{$item.chapter_name}
                      </div>
                      <ul class="list-group list-group-flush">
                        <volist name="item.sectionlist" id="vo" key="kk">
                            <li class="list-group-item" style="margin-left:20px"><a href="{:U('Course/SectionDetail')}?s_id={$vo.section_id}" class="card-link text-dark" target="_blank">第{$kk}节：{$vo.section_name}</a> <!-- <span class="float-right">已学</span> --></li>
                        </volist>
                      <!--   
                        <li class="list-group-item"><a href="./article.html" class="card-link text-dark">Card link</a></li>
                        <li class="list-group-item"><a href="./article.html" class="card-link text-dark">Card link</a></li> -->
                      </ul>
                    </div>
                </volist>
                


              </div>

            </div>

    <!--  <div class="courselist" style='padding-top:100px'>
        <div>
            <h2 style='margin-top:10px'>当前课程：{$courseinfo['course_name']}</h2>
            <h4>课程基本介绍</h4>
            <p>{$courseinfo.course_intro}</p>
        </div>
        <volist name ="chapterlsit" id="item">
            <div class="chapter" >
                <div class="title">{$item.chapter_name}</div>
                <p>{$item.chapter_intro}</p>
                
                <ul class="jie">
                <volist name="item.sectionlist" id="vo">
                    <li>{$vo.section_name}<a href="{:U('Course/SectionDetail')}?s_id={$vo.section_id}" style='float:right;margin-right:10%'><button type="button" class="btn btn-xs btn-info ">测试</button></a><a href="{:U('Course/SectionDetail')}?s_id={$vo.section_id}" style='float:right;margin-right:3%'><button type="button" class="btn btn-xs btn-danger">学习</button></a></li>
                    
                    </volist>
                </ul>
                
            </div>

        </volist>
        
        

    </div> -->
        
</block>
<block name="js">
 
</block>