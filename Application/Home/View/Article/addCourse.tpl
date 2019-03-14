<extend name="Public/base"/>
<block name="content">
<style type="text/css">
.pic{position:absolute;right:5%;margin-left:20px;top:20px;width:320px;height:175px;}  
.imggroup div{margin: 15px 0px;}
.imggroup div input{margin:3px 0px;}
.spec input[type='text']{width:70%;margin-top:4px;     padding: 4px 12px; line-height: 1.42857143;border: 1px solid #ccc;}
.delete_class,.delete_spec,.add_spec,.add_class{margin-left:6px;}

</style>
<!-- add by liu 图片裁剪 -->
<!-- 获取图片配置信息 -->
<?php $pic_info=C('picinfo')['goods'];$picf_info=C('picinfo')['goodsf'];?>
<style>
    .image {
        background: #666;
        width: <?php echo $picf_info['w']*0.6?>px;
        height: <?php echo $picf_info['h']*0.6?>px;
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
    .other{
        margin: 0 auto;
        border:1px solid black;
        width: <?php echo $picf_info['w']*0.2?>px;
        height: <?php echo $picf_info['h']*0.2?>px;
        float: left;
        margin: 0px 15px 10px 0px;
        background-image: url("__Assert__/img/123.png");
        background-size:100% 100%;
        position: relative;
        overflow: hidden;
    }
    .cut{
        width: <?php echo $picf_info['w']*0.6?>px;
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
    }.gs_display{ 
        display: none;
    }
</style>
<!-- end by liu 图片裁剪 -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                添加课程
<!--                 <small>Add Goods</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>内容管理</li>
                <li>课程列表</li>
                <li class="active">添加课程</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="box box-primary" id="window_main">
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form role="form" method="post" action="{:U('Article/doaddCourse')}" name="frm" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                            <div class="box-body">
                                <div >
                                    <label>课程名称：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control" datatype="*"  placeholder="(必填)请填写课程名称！" name="goods_name">
                                </div>

                                <!-- <div>
                                    <label>课程分类：<span style="color: #FF0000;">*</span></label>
                                    <select name="pid" class="form-control input-sm" style="width: auto;" id="pclass">
                                        <option value="-1">全部</option>
                                        <volist name="projectList" id="vo">
                                             <option value="{$vo.pid}">{$vo.name}</option>
                                        </volist>
                                    </select>
                                </div> -->

                                <div>
                                    <label>购买课程后升级的身份：<span style="color: #FF0000;">*</span></label>
                                    <select name="mid" class="form-control input-sm" style="width: auto;" id="Identity">
                                        <option value="-1">全部</option>
                                        <volist name="identityList" id="item">
                                             <option value="{$item.id}">{$item.identity}</option>
                                        </volist>
                                    </select>
                                </div>

                                <div>
                                    <label>报名开始时间：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="statime" value="{$statime | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;font-size:14px;" datatype="*"/>
                                </div>

                                <div>
                                    <label>报名截止时间：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="endtime" value="{$endtime | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;font-size:14px;" datatype="*"/>
                                </div>

                                <div>
                                    <label>课程价格：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control goods_price" datatype="currency" nullmsg="请填写课程价钱" placeholder="(必填)请填写商品价格！" errormsg="请正确填写金额且需小于10万！" name="goods_price">
                                </div>

                                <div class="gs_display">
                                    <label>第一级分成（金额）：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control gs_display" datatype="currency" nullmsg="请填金额" placeholder="(必填)请填写金额！" errormsg="请正确填写金额且需小于10万！" name="gs_one">
                                </div> 

                                <div class="gs_display">
                                    <label>第二级分成（金额）：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control gs_display" datatype="currency" nullmsg="请填金额" placeholder="(必填)请填写金额！" errormsg="请正确填写金额且需小于10万！" name="gs_two">
                                </div> 

                                <div class="gs_display">
                                    <label>第三级分成（金额）：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control gs_display" datatype="currency" nullmsg="请填金额" placeholder="(必填)请填写金额！" errormsg="请正确填写金额且需小于10万！" name="gs_three">
                                </div> 

                                <div class="gs_display">
                                    <label>平台分成（百分比）：<span style="color: #FF0000;">*</span></label>
                                    <input type="text" class="form-control gs_display" datatype="ns" nullmsg="请填0到100以内的整数" placeholder="(必填)请填0到100以内的整数！" errormsg="请填0到100以内的整数" name="pingtai">
                                </div>  

                                <label>课程主图：<span style="color: #FF0000;">* （图片尺寸640*300）</span></label>
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
                                    <label>课程描述
                                        <small></small>
                                    </label>
                                    <script id="container" name="goods_body" type="text/plain"></script>
                                </div>

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
                                <a href="{:U('Article/courseList')}" class="btn btn-info">返回</a>
                            </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.box -->
                </div>
                <!--/.col (left) -->
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
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
                    var width=<?php echo $pic_info['w']*0.6?>;
                    var height=<?php echo $pic_info['h']*0.6?>;
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
        $(document).on('change','.goods_price',function(){ 
            var goods_price = $(this).val();
            if( goods_price*1 > 0 ) { 
                $('.gs_display').css('display','block');
            } else { 
                $('.gs_display').css('display','none');
            }
        })
        
    </script>
<!-- end by liu 图片裁剪 -->

<script type="text/javascript">
$(function(){
    //表单验证
    $(".validform").Validform({
        tiptype:3,
        ignoreHidden:true,
        datatype:{
            //中文验证
            "z2-4" : /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,4}$/ ,
            "currency" : /^\d{1,5}(\.\d{1,2})?$/ ,
            "dxzm":/^[A-Z]{5,20}$/,
            "ns" :function(gets){ 
                if( gets*1 < 0 || gets*1 > 100 || $.trim(gets) == '' ) return false ; else return true;
            },
            "tel":/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,  
        }
    });

    var dom = $(".content");
    var clid ;
    dom.on("submit",".validform",function(){
        var link = "doaddCourse";
        var sub = $(this).find(":submit");
        sub.attr('sub',sub.val());
        sub.val('提交中...');
        sub.attr('disabled','disabled');
        var data = $(this).serializeArray();

        // var pid = $("#pclass").val();
        // if(pid == -1){
        //     art.dialog({
        //         content:"请选择课程分类",
        //     });
        //     sub.attr('sub',sub.val());
        //     sub.val('提交');
        //     sub.attr('disabled',false);
        //     //window.setTimeout(window.location="{:U('Article/add')}",2000);
        //     return false;
        // }

        var mid = $("#Identity").val();
        if(mid == -1){
            art.dialog({
                content:"请选择购买后课程身份",
                lock:true,
            });
            sub.attr('sub',sub.val());
            sub.val('提交');
            sub.attr('disabled',false);
            //window.setTimeout(window.location="{:U('Article/add')}",2000);
            return false;
        }
        clid = art.dialog({
                content:"请等待，课程活动上传中....",
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
                sub.attr('sub',sub.val());
                sub.val('提交');
                sub.attr('disabled',false);
            },
            success:function(re){
            	clid.close();
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Article/courseList')}'",1500);
                }else{
                    art.dialog({
                      content:re.info,
                      lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                    //window.setTimeout(window.location="{:U('Article/courseList')}",2000);
                }
            }
        })      
        return false;
    })
});
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