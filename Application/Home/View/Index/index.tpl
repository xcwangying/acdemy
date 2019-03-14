<extend name="Public/base" />
<block name="css">


  
</block>
<block name="content">
     <div class="container">
 

     <!-- <div
        id="carouselExampleIndicators"
        class="carousel slide mb1"
        data-ride="carousel"
      >
        <ol class="carousel-indicators">
          <li
            data-target="#carouselExampleIndicators"
            data-slide-to="0"
            class="active"
          ></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
          <a href="{:U('Course/CourseChapterList')}?c_id=4">
            <img
              class="d-block w-100"
              src="http://www.fanyoufu.com/Application/Home/View/Public/assert/images/banner1.jpg"
              alt="First slide"
            />
            </a>
          </div>
          <div class="carousel-item">
          <a href="{:U('Course/CourseChapterList')}?c_id=5">
            <img
              class="d-block w-100"
              src="http://www.fanyoufu.com/Application/Home/View/Public/assert/images/banner2.jpg"
              alt="Second slide"
            />
            </a>
          </div>
          <div class="carousel-item">
          <a href="{:U('Course/CourseChapterList')}?c_id=6">
            <img
              class="d-block w-100"
              src="http://www.fanyoufu.com/Application/Home/View/Public/assert/images/banner3.jpg"
              alt="Third slide"
            />
            </a>
          </div>
        </div>
        <a
          class="carousel-control-prev"
          href="#carouselExampleIndicators"
          role="button"
          data-slide="prev"
        >
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a
          class="carousel-control-next"
          href="#carouselExampleIndicators"
          role="button"
          data-slide="next"
        >
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div> -->
      <div class="articleList mb1">
        <h3>最新教程</h3>

        <volist name="data.artlist" id="vo">
            <div class="article border clearfix">
          <h5 class="article-title">

          {$vo.course_name}&nbsp;/&nbsp;{$vo.course_name}&nbsp;/&nbsp;{$vo.section_name}</h5>

          <p class="article-info text-right">
            发布时间：<span class="article-datetime">{$vo['dtime']|date="Y-m-d",###}</span>
            共计:<span class="article-total-v">{$vo.browse_num}</span>访问 <!-- 今天：<span
              class="article-today-v"
              >132</span
            >访问 --> <span class="article-author">{$vo.user_name}</span>
          </p>
          <p class="article-detail">
            {$vo.section_content}
          </p>
          <a href="{:U('Course/SectionDetail')}?s_id={$vo.section_id}" class="float-right">查看</a>
        </div>
        </volist>
        
    <!-- 
        <div class="article border clearfix">
          <h5 class="article-title">文章标题</h5>
          <p class="article-info text-right">
            发布时间：<span class="article-datetime">2019-12-13</span>
            共计:<span class="article-total-v">12312</span>访问 今天：<span
              class="article-today-v"
              >132</span
            >访问 <span class="article-author">@**老师</span>
          </p>
          <p class="article-detail">
            这绝对不是一篇技术文，如果你不喜欢，也请不要喷，你可以看看都有哪些问题，当然，在这里你可能得不到问题的答案，不懂的你可能需要自己去百度，也可以在下面留言交流，我已经声明了，这不是一篇纯技术文章，不喜勿碰，忽略就是；做文明人，共创一个和谐的网络环境，谢谢；
          </p>
          <a href="./article.html" class="float-right">查看</a>
        </div> -->
      </div>

    </div>


        
</block>
<block name="js">
   <script
      src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js"
      integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
      integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
      integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
      crossorigin="anonymous"
    ></script>
  <script type="text/javascript"> 

  </script>
</block>