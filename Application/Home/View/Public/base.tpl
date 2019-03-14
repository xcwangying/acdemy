<php>$node_list = $_SESSION['node_list'];</php>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>{$title_name}</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>
    <!-- <link rel="shortcut icon" href=""/> -->
     <link rel="shortcut icon" href="__Assert__/images/blogo.png"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link
      rel="stylesheet"
      href="__Assert__/css/bootstrap.min.css"
    
    />

<!--             <link
      rel="stylesheet"
      href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css"
      integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
      crossorigin="anonymous"
    /> -->
    <link href="__Assert__/css/style.css" rel="stylesheet" />

   

    <block name="css"></block>
   
</head>
<body >

<nav class="navbar navbar-expand-lg navbar-light mb1">
      <div class="container">
        <a class="navbar-brand" href="{:U('Index/index')}">犇犇学院</a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item ">
              <a class="nav-link  <?php  if (CONTROLLER_NAME=='Index') echo active; ?>" href="{:U('Index/index')}">主页</a>
            </li>
            <li class="nav-item ">
              <a class="nav-link <?php  if (CONTROLLER_NAME=='Course') echo active; ?>" href="{:U('Course/index')}">课程</a>
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input
              class="form-control mr-sm-2"
              type="search"
              placeholder="Search"
              aria-label="Search"
            />
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
              搜索
            </button>
          </form>
        </div>
      </div>
    </nav>
    <block name="content">
    </block>
   <footer class="foot">
        <div class="copyright">Copyright © 2019 犇犇学院 All Rights Reserved  </div>
    </footer>
</div>
<script src="__Assert__/js/jquery.min.js"></script>
<script src="__Assert__/js/bootstrap.min.js"></script>





<block name="js"></block>


</body>
</html>
