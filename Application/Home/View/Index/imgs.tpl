<meta http-equiv="Content-Type" contect="text/html" charset="utf-8"/>

<link rel="stylesheet" href="__Assert__/js/layer/layer.css"  media="all">
<link rel="stylesheet" href="__Assert__/css/mycss.css"  media="all">


<script type="text/javascript" src="__Assert__/js/jquery-2.2.3.js"></script>
<script src="__Assert__/js/layer/layer.js"></script>
<script type="text/javascript" src="__Assert__/js/function.js"></script>

<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="__Assert__/js/webuploader-0.1.5/webuploader.css">
<!--引入JS-->
<script type="text/javascript" src="__Assert__/js/webuploader-0.1.5/webuploader.js"></script>

<div class="space-4"></div>
<div class="form-group">
    <label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 商品展示图（单）： </label>
    <div class="col-sm-9">
        <input type="hidden" name="banner_img">
        <br>
        <div id="banner_img">
            <div id="banner_img_filePicker"><i class="icon-cloud-upload"></i></i> 选择单张图片</div>
        </div>
    </div>
</div>
<div class="space-4"></div>
<div class="form-group">
    <label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 商品轮播图（多）： </label>
    <div class="col-sm-9">
        <input type="hidden" name="turn_img">
        <br>
        <div id="turn_img">
            <div id="turn_img_filePicker"><i class="icon-cloud-upload"></i></i> 可选择多张图片</div>
        </div>
    </div>
    <div id="xx"></div>
</div>

<script type="text/javascript">
    webTitle = '标题';
    //商品展示图
    var tt ="{$arr}";
   $('#turn_img_filePicker').html(webUploaderImgHtml(tt)) ;
    webUploaderImgs('#banner_img_filePicker',"http://localhost/index.php/Index/douplodfiles", $('#banner_img'), $('input[name=banner_img]'), 1, "./webuploader-0.1.5/Uploader.swf");
    //商品展示图
    webUploaderImgs('#turn_img_filePicker', "http://localhost/index.php/Index/douplodfiles",$('#turn_img'), $('input[name=turn_img]'), 3, "./webuploader-0.1.5/Uploader.swf", 4);
</script>