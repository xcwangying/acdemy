<extend name="Public/base"/>
<block name="content">
<!-- add by liu 图片裁剪 -->
<!-- 获取图片配置信息 -->
<?php $pic_info=C('picinfo')['stories'];?>
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
    .delete_pic{
        float: left;
        margin-right: 15px;
        height: <?php echo $pic_info['h']*0.2?>px;
    }
    .cut{
         width: <?php echo $pic_info['w']*0.6?>px;
        display:none;
    }
    .reset{
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
<!-- end by liu 图片裁剪 -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                编辑专访
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章管理</li>
                <li>专访管理</li>
                <li class="active">编辑专访</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="box box-primary">
                        <form role="form" name="frm" action="{:U('Article/doEditStories')}?id={$data.id}" method="post" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main">
                            <div class="box-body">
                                <div>
                                    <label>标题：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" nullmsg="请填写商品名称" name="title" value="{$data.title}">
                                </div>


                                <label>封面图片<span style="color:red;font-size:12px;">(尺寸大小：640*300)</span></label>
                                <!-- 待裁剪图片的div -->
                                <div id="goods_image_area" class="image"></div>
                                <button id="goods_image_btn" type="button" class="cut">截取</button>
                                <!-- 待裁剪图片的div -->
                                <div style="height:<?php echo $pic_info['h']*0.3?>px;">
                                    
                                    <div id="goods_image_view" class="view" <if condition="$data.picture  neq ''">style='background-image: url("{$http}{$data.picture}");background-size:100% 100%;'<else/>style='margin-right:45px'</if>>
                                        <input type="file" id="goods_image" class="goods_image" name="goods_image"/>
                                    </div>
                                    <if condition="$data.picture neq ''">
                                    <input type="button"  gid="{$data.id}" img="picture" class="delete_pic" style="height:<?php echo $pic_info['h']*0.3?>px;width:30px;white-space:pre-wrap;" value="删除原图">
                                    </if>
                                    <input type="hidden" name="goods_image_hid"/>
                                </div>   

                                


                                <div >  
                                    <label>专访内容
                                        <small></small>
                                    </label>
                                    <script id="container" name="content" type="text/plain">{$data.content}</script>
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
                                <button type="reset" class="btn btn-warning">重置</button>
                                <a href="{:U('Article/index')}" class="btn btn-info">返回</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</block>
<block name="js">

<script type="text/javascript" src="__Assert__/js/Validform_v5.3.2_min.js"></script>
<link type="text/css" href="__Assert__/css/validform.css" rel="stylesheet"/>
    <script type="text/javascript">
        var ue = UE.getEditor('container');
    </script> 
    <!-- add by liu 图片裁剪 -->
<script>
                $(function() {
                    var name = new Array()
                    name[1] = "goods_image";
                    for(a in name){
                        if(name[a] == "goods_image"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }else{
                            var width=<?php echo $picf_info['w']*0.5?>;
                            var height=<?php echo $picf_info['h']*0.5?>;
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
                        //$("input[type='button'][name="+image+"]").css('display','block');
                    });  
                        
            });     
            $("form").on("click",".delete_pic",function(){
                var img = $(this).attr("img");
                var gid = $(this).attr("gid");
                $.post("{:U('Article/delete_pic')}?id="+gid+"&img="+img, function (data, goods_state) {
                    layer.open({
                        type: 1,
                        title: '系统提示',
                        closeBtn: 2,
                        shade: 0.5,
                        content: data
                    });
                }, 'text');
            });
            // $(document).on('submit',function(){
                
            // });
			var clid;
            //var dom = $(".content");
            $(document).on("submit",".validform",function(){
                var name = new Array()
                    name[1] = "goods_image";
                for(a in name){
                    var pic = $("#"+name[a]+"_view").css("background-image");
                    if(pic.indexOf('url("http:') < 0 ){
                        $("input[type='hidden'][name='"+name[a]+"_hid']").val(pic.substring(27));
                    }
                    $("input[type='file'][name="+name[a]+"]").remove();
                }

                clid = art.dialog({
	                content:"请等待，专访文章上传中....",
	                lock:true
	            });
                var link = $(this).attr('action');
                var sub = $(this).find(":submit");
                sub.attr('sub',sub.val());
                sub.val('提交中...');
                sub.attr('disabled','disabled');
                var data = $(this).serializeArray(); 
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
                            window.setTimeout("window.location='"+"{:U('Article/index')}'",1500);
                        }else{
                            art.dialog({
                              content:re.info,
                              lock:true
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                            //window.setTimeout(window.location="{:U('Project/courseList')}",2000);
                        }
                    }
                })      
                return false;
            })
        </script>
<!-- end by liu 图片裁剪 -->
</block>