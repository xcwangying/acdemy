<extend name="Public/base" />
<block name="css">
    <link rel="stylesheet" href="__Assert__/css/markdown/markdown.css">
  <style type="text/css">
.pl1 {
        padding-left: 0.5em;
        
      }
      .pl2 {
        padding-left: 1em;
      
      }
      .pl3 {
        padding-left: 1.5em;
       
      }
      .pl4 {
        padding-left: 2em;
       
      }
      .pl5 {
        padding-left: 2.5em;
      
      }
      .pl6 {
        padding-left: 3em;

      }
      .lists a:hover{background: #f3f3f3}
      #category a{color:#000;}
      p#back-to-top{
          position:fixed;
          display:none;
          bottom:100px;
          right:80px;
      }
      p#back-to-top a{
          text-align:center;
          text-decoration:none;
          color:#d1d1d1;
          display:block;
          width:64px;
          -moz-transition:color 1s;
          -webkit-transition:color 1s;
          -o-transition:color 1s;
          padding: 10px;
          border: 1px solid #DDD;
          display: block;
          color: #999;
          text-decoration: none;
      }
      p#back-to-top a:hover{
          color:#979797;
      }

  </style>
</block>
<block name="content">

<div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a class="text-dark" href="http://www.fanyoufu.com/web.php/Index/index.html">主页</a></li>
        <li class="breadcrumb-item"><a class="text-dark" href="{:U('Course/CourseChapterList')}?c_id={$sectioninfo.course_id}">{$sectioninfo['course_name']}</a></li>
        <li class="breadcrumb-item"><a class="text-dark" href="{:U('Course/CourseChapterList')}?c_id={$sectioninfo.course_id}">{$sectioninfo['chapter_name']}</a></li>
        <li class="breadcrumb-item text-success" aria-current="page">{$sectioninfo['section_name']}</li>
      </ol>
    </nav>
    <div class="row articlecontainer mb1">
      <div class="col-lg-9  markdown-body ">
        <h2 id="misty-theme">{$sectioninfo['section_name']}</h2>
        <div class="article-info text-right">
          <span class="datetime">发布时间：{$sectioninfo['dtime']|date="Y-m-d",###}</span> <span class="datetime">共计{$sectioninfo['browse_num']}次</span>
        </div>
        <div id="contents">
        {$sectioninfo['section_contenthtml']}
        </div>

      </div>


      <div class="col-lg-3  d-none d-lg-block">
        <div class="catalogue">

          <h5 class="title">目录</h4>
          <ul class="nav flex-column " id="category" style='font-size:15px'>
         
          </ul>

          <h5 class="title">推荐文章</h4>
            <ul class="nav flex-column">

            <volist name="sectionlist" id="vo">
                <li class="nav-item sec1">
                <a class="text-dark" href="{:U('Course/SectionDetail')}?s_id={$vo.section_id}">第{$i}节:{$vo.section_name}</a>
              </li>
            </volist>
              

            </ul>
        </div>

      </div>
      <span style="font-size:14px"><p id="back-to-top"><a href="#top"><span></span>回顶部</a></p></span>  
    </div>

  </div>

</block>




<block name="js">

<script type="text/javascript"> 
  $(() => {

    $("#contents :header").each((index, item) => {
      let htitle = $(item).text();
      let ids =item.id;
        console.log(item.id);
      let level = item.tagName.replace("H", "");
    
      var html = $(item).text();
      // var tt = `<li class="pl${level} lists"><a href="#${htitle}${index}">${htitle}</a></li>`;
       var tt = `<li class="pl${level} lists"><a href="#${ids}">${htitle}</a></li>`;
      $("#category").append(tt);

      $(item).before(`<a name='${htitle}${index}'></a>`);
    });
  });

  //当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
      $(function () {
          $(window).scroll(function(){
              if ($(window).scrollTop()>100){
                  $("#back-to-top").fadeIn(1500);
              }
              else
              {
                  $("#back-to-top").fadeOut(1500);
              }
          });

          //当点击跳转链接后，回到页面顶部位置
          $("#back-to-top").click(function(){
      if ($('html').scrollTop()) {
              $('html').animate({ scrollTop: 0 }, 1000);
              return false;
          }
          $('body').animate({ scrollTop: 0 }, 1000);
               return false;            
         });       
   });    


 
</script> 
</block>