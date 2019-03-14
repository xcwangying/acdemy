<extend name="Public/base"/>
<block name="content">
    <!-- add by liu 图片裁剪 -->
<!-- 获取图片配置信息 -->
<?php $pic_info=C('picinfo')['youdao'];?>
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
        height: <?php echo $pic_info['h']*0.3?>px;
    }
    .other{
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
    .other_image{
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
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                修改活动轮播图片
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章管理</li>
                <li class="active">修改活动轮播图片</li>
            </ol>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <form role="form" name="frm" action="{:U('Article/doMerActivity')}" method="post" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main">
                            <div class="box-body">
                                <label>活动轮播图一<span style="color:red;font-size:12px;">(尺寸大小：750*640)</span></label>
                                <div id="goods_image_area" class="image"></div>
                                <button id="goods_image_btn" type="button" class="cut">截取</button>
                                <div style="height:<?php echo $pic_info['h']*0.3?>px;">
                                    
                                    <div id="goods_image_view" class="view" <if condition="$arr.url neq ''">style='background-image: url("/{$arr.url}");background-size:100% 100%;'<else/>style='margin-right:45px'</if>>
                                        <input type="file" id="goods_image" class="goods_image" name="goods_image"/>
                                    </div>
                                    <input type="hidden" name="goods_image_hid"/>
                                </div>   
                                
                                <label>活动轮播图二<span style="color:red;font-size:12px;">(尺寸大小：750*640)</span></label>
                                <!-- 待裁剪图片的div -->
                                <div id="One_area" class="image"></div>
                                <button id="One_btn" type="button" class="cut">截取</button>
                                <!-- 待裁剪图片的div -->
                                <div style="height:<?php echo $pic_info['h']*0.2*1.5?>px;">
                                    <div id="One_view" class="other" <if condition="$arr1.url neq null">style='background-image: url("/{$arr1.url}");background-size:100% 100%;'<else/>style='margin-right:45px'</if>>
                                        <input type="file" id="One" class="other_image" name="One"/>
                                    </div>
                                    <input type="hidden" name="One_hid"/>
                                </div>  

                                <label>活动轮播图三<span style="color:red;font-size:12px;">(尺寸大小：750*640)</span></label>
                                <!-- 待裁剪图片的div -->
                                <div id="Two_area" class="image"></div>
                                <button id="Two_btn" type="button" class="cut">截取</button>
                                <!-- 待裁剪图片的div -->
                                <div style="height:<?php echo $pic_info['h']*0.2*1.5?>px;">
                                    <div id="Two_view" class="other" <if condition="$arr2.url neq null">style='background-image: url("/{$arr2.url}");background-size:100% 100%;'<else/>style='margin-right:45px'</if>>
                                        <input type="file" id="Two" class="other_image" name="Two"/>
                                    </div>
                                    <input type="hidden" name="Two_hid"/>
                                </div> 
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
                                <a href="{:U('Article/courseList')}" class="btn btn-info">返回</a>
                                <!-- <a href="javascript:history.go(-1)" class="btn btn-info">返回</a> -->
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
<script>
                $(function() {
                    var name = new Array()
                    name[1] = "goods_image";
                    name[2] = "One";
                    name[3] = "Two";
                    for(a in name){
                        if(name[a] == "goods_image"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }else if(name[a] == "One"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }else if(name[a] == "Two"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }else if(name[a] == "Three"){
                            var width=<?php echo $pic_info['w']*0.5?>;
                            var height=<?php echo $pic_info['h']*0.5?>;
                        }else if(name[a] == "Four"){
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
                        //$("input[type='button'][name="+image+"]").css('display','block');
                    });  
                        
            });     
                
            // //删除图片
            // $("form").on("click",".delete_pic",function(){
            //     var img = $(this).attr("img");
            //     var gid = $(this).attr("gid");
            //     $.post("{:U('Goods/delete_pic')}?goods_id="+gid+"&img="+img, function (data, goods_state) {
            //         layer.open({
            //             type: 1,
            //             title: '系统提示',
            //             closeBtn: 2,
            //             shade: 0.5,
            //             content: data
            //         });
            //     }, 'text');
            // });

        </script>
    <!-- end by liu 图片裁剪 -->
    <!-- add by liu -->

    <script>
    var sbool = false;
    $("form").submit(function(e){
        if(sbool){
            alert("因为您修改了规格！请先点击确认规格按钮！");
            return false;
        }
        var name = new Array()
            name[1] = "goods_image";
            name[2] = "One";
            name[3] = "Two";
            name[4] = "Three";
            name[5] = "Four";
      for(a in name){
                var pic = $("#"+name[a]+"_view").css("background-image");
                if(pic.indexOf('url("http:') < 0 ){
                    $("input[type='hidden'][name='"+name[a]+"_hid']").val(pic.substring(27));
                }
                $("input[type='file'][name="+name[a]+"]").remove();
            }
        
    })
    </script>
    <!-- end by liu -->
    <script>
        //删除图片
        $("form").on("click",".delete_pic",function(){
            var img = $(this).attr("img");
            var gid = $(this).attr("gid");
            $.post("{:U('Baoming/delete_pic')}?id="+gid+"&img="+img, function (data, goods_state) {
                layer.open({
                    type: 1,
                    title: '系统提示',
                    closeBtn: 2,
                    shade: 0.5,
                    content: data
                });
            }, 'text');
        });

    $(document).on("submit",".validform",function(){
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
                art.dialog({
                    content:"网络错误，请重试！",
                    lock:true
                });
            },
            success:function(re){
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Article/merActivity')}'",1500);
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
</block>