<extend name="Public/base"/>
<block name="content">
<!-- add by liu 图片裁剪 -->
<!-- 获取图片配置信息 -->
<?php $pic_info=C('picinfo')['carousel'];?>
<style>
    .image {
        background: #666;
        width: <?php echo $pic_info['w']*0.6?>px;
        height: <?php echo $pic_info['h']*0.6?>px;
        display:none;
    }
    #file,
    .view {
        margin: 0 auto;
        border:1px solid black;
        width: <?php echo $pic_info['w']*0.3?>px;
        height: <?php echo $pic_info['h']*0.3?>px;
        float: left;
        background-image: url("__Assert__/img/123.png");
        background-size:100% 100%;
        position: relative;
        overflow: hidden;
    }
    .cut{
        width: <?php echo $pic_info['w']*0.6?>px;
        display:none;
    }

    .goods_image{
    position: absolute;
    top: 0;
    left: 0;

    z-index: 100;
    width: 100%;
    height: 100%;

    filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
    filter:alpha(opacity=0);
    -moz-opacity:0;
    -khtml-opacity: 0;
    opacity:0;
    background: none;
    border: none;
    cursor: pointer;
    }

</style>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                添加活动
                
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章管理</li>
                <li>活动管理</li>
                <li class="active">添加活动</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary" id="window_main">
                        <form role="form" method="post" action="{:U('Cms/doaddactivity')}" name="frm" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                            <div class="box-body">
                                <div>
                                    <label>标题：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写标题！" name="title">
                                </div>

                                <div>
                                    <label>摘要：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写标题！" name="zhaiyao">
                                </div>

                                <div>
                                    <label>开始时间：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="k_time" value="{$activity_time | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;font-size:14px;" datatype="*"/>
                                </div>

                                <div>
                                    <label>截止时间：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="j_time" value="{$over_time | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;font-size:14px;" datatype="*"/>
                                </div>

                                <label>封面图片<span style="color:red;font-size:12px;">(尺寸大小：360*240)</span></label>
                                <!-- 待裁剪图片的div -->
                                <div id="goods_image_area" class="image"></div>
                                <button id="goods_image_btn" type="button" class="cut">截取</button>
                                
                                <!-- 待裁剪图片的div -->              
                                <div style="height:<?php echo $pic_info['h']*0.3?>px;">
                                    
                                    <div id="goods_image_area" class="image"></div>
                                    <div id="goods_image_view" class="view">
                                        <input type="file" id="goods_image" class="goods_image" name="goods_image"/>
                                    </div>
                                    <input type="hidden" name="goods_image_hid"/>
                                    
                                </div>

                                
                                <div >  
                                    <label>活动内容
                                        <small></small>
                                    </label>
                                    <script id="container" name="content" type="text/plain"></script>
                                </div>
                            </div>

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
                                <a href="javascript:history.go(-1);"><input type="button" class="btn btn-sm btn-info" value="返回"></a> 
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</block>
<block name="js">
<!-- add by liu 图片裁剪 -->
<script>
                $(function() {
                    var name = new Array()
                    name[1] = "goods_image";
                    for(a in name){
                        if(name[a] == "goods_image"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }
                        $("#"+name[a]+"_area").photoClip({
                            width: width,
                            height: height,
                            file: "#"+name[a],
                            view: "#"+name[a]+"_view",
                            ok: "#"+name[a]+"_btn",
                            loadStart: function() {
                                console.log("照片读取中");
                            },
                            loadComplete: function() {
                                console.log("照片读取完成");
                            },
                            clipFinish: function(dataURL) {
                                // $.ajax({
                                //     url: "upload.php",
                                //     data: {name: dataURL.substring(27),id:name},
                                //     type: 'post',
                                //     // dataType: 'html',
                                // })
                            }
                        });
                    }
                    $("input[type='file']").change(function(){ 
                        var image = $(this).attr("id");
                        $(".image").css('display','none');
                        $("#"+image+"_area").css('display','block');  
                        //$(".view").css('display','none');
                        $("#"+image+"_view").css('display','block'); 
                        $(".cut").css('display','none');
                        $("#"+image+"_btn").css('display','block'); 
                    });  
                        
            });     
            

        </script>
        <script>

            $("form").submit(function(e){
                var name = new Array()
                    name[1] = "goods_image";
              for(a in name){
                        var pic = $("#"+name[a]+"_view").css("background-image");
                        if(pic.indexOf('url("http:') < 0 ){
                            $("input[type='hidden'][name='"+name[a]+"_hid']").val(pic.substring(27));
                        }
                        $("input[type='file'][name="+name[a]+"]").remove();
                    }
            });
    </script>
<!-- end by liu 图片裁剪 -->
<script type="text/javascript" src="__Assert__/js/Validform_v5.3.2_min.js"></script>
<link type="text/css" href="__Assert__/css/validform.css" rel="stylesheet"/>
<script type="text/javascript">
    var ue = UE.getEditor('container');
</script>        
<script type="text/javascript">
$(function(){
    //表单验证
    $(".validform").Validform({
        tiptype:3,
        ignoreHidden:true,
        datatype:{
            //中文验证
            "z2-4" : /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,4}$/ ,
            "currency" : /^\d+(\.\d+)?$/ ,
            "dxzm":/^[A-Z]{5,20}$/,
            "tel":/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,  
            }
    });
});
	var clid;
    $(document).on("submit",".validform",function(){
        var link = $(this).attr('action');
        var sub = $(this).find(":submit");
        sub.attr('sub',sub.val());
        sub.val('提交中...');
        sub.attr('disabled','disabled');
        var data = $(this).serializeArray(); 
        clid = art.dialog({
                content:"请等待，邀约活动上传中....",
                lock:true
            });
        $.ajax({
            type:"post",
            url:link,
            data:data,
            error:function(){
            	clid.close();
                art.dialog({
                    content:"网络错误，请重试！",
                    lock:true
                });
            },
            success:function(re){
            	clid.close();
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Cms/activity')}'",1500);
                }else{
                    art.dialog({
                      content:re.info,
                      lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                    window.setTimeout("window.location='"+"{:U('Cms/activity')}'",1500);
                }
            }
        })      
        return false;
    })

	 $(document).ready(function () {
        $('.datetimepicker3').datepicker({
            format: 'yyyy-mm-dd ',
            autoclose: true,
        });
        $('.datetimepicker2').datetimepicker({
            format: 'yyyy-mm-dd ',
        });
    });
</script>
</block>