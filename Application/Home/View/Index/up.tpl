
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
            演示 - Web Uploader
        </title>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->


    <link rel="stylesheet" type="text/css" href="__Assert__/webuploader/css/style.css">
    
    <link rel="stylesheet" type="text/css" href="__Assert__/webuploader/css/webuploader.css">
    
    <link rel="stylesheet" type="text/css" href="__Assert__/webuploader/css/demo.css">
    
</head>

<body>
    <div id="wrapper">
        <div class="navbar navbar-fixed-top navbar-inverse" role="navigation">

    <!-- /.container -->
</div>
<!-- /.navbar --> <div class="page-body">

<div id="post-container" class="container">
    

    

    

    <div class="page-container">
        <h1 id="demo">Demo</h1>

<p>您可以尝试文件拖拽，使用QQ截屏工具，然后激活窗口后粘贴，或者点击添加图片按钮，来体验此demo.</p>

<div id="uploader" class="wu-example">
    <div class="queueList">
        <div id="dndArea" class="placeholder">
            <div id="filePicker"></div>
            <p>或将照片拖到这里，单次最多可选300张</p>
        </div>
    </div>
    <div class="statusBar" style="display:none;">
        <div class="progress">
            <span class="text">0%</span>
            <span class="percentage"></span>
        </div><div class="info"></div>
        <div class="btns">
            <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>
        </div>
    </div>
</div>

    </div>

    





    
</div></div> <div id="footer" class="footer">

</div>
    </div>
    <script type="text/javascript">
    // 添加全局站点信息
    var BASE_URL = '/webuploader';
    </script>
    <script type="text/javascript" src="__Assert__/webuploader/js/jquery.js"></script>

<!--     <script type="text/javascript" src="/webuploader/js/global.js"></script> -->
    
        <script type="text/javascript" src="__Assert__/webuploader/js/webuploader.js"></script>
    
        <script type="text/javascript" src="__Assert__/webuploader/js/demo.js"></script>
    
    <script type="text/javascript">
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F67c4841095cbee8275705e1f6224a3c7' type='text/javascript'%3E%3C/script%3E"));
    </script>
</body>
</html>
