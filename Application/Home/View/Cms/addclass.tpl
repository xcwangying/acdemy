<extend name="Public/base"/>
<block name="content">
<style type="text/css">
.pic{position:absolute;right:5%;margin-left:20px;top:20px;width:320px;height:175px;}  
.imggroup div{margin: 15px 0px;}
.imggroup div input{margin:3px 0px;}
.spec input[type='text']{width:70%;margin-top:4px;     padding: 4px 12px; line-height: 1.42857143;border: 1px solid #ccc;}
.delete_class,.delete_spec,.add_spec,.add_class{margin-left:6px;}
</style>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>添加文章分类
<!--                 <small>Add Goods</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>CMS管理</li>
                <li>分类管理</li>
                <li class="active">添加文章分类</li>
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
                        <form role="form" method="post" action="{:U('Cms/doaddclass')}" 
                              name="frm" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                            <div class="box-body">
                                <div>
                                    <label>分类名称：</label>
                                    <input type="text" class="form-control" name="class_name" value=""  >
                                  
                                </div>      


                                <div class="box-footer">
                                    <button type="submit" class="btn btn-sm btn-primary">提交</button>
                                    <a href="javascript:history.go(-1);"><input type="button" class="btn btn-sm btn-info" value="返回"></a> 
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

    $(document).on("submit",".validform",function(){
        var link = $(".validform").attr('action');
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
                sub.attr('sub',sub.val());
                sub.val('提交');
                sub.attr('disabled',false);
            },
            success:function(re){
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Cms/artclass')}'",1500);
                }else{
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                     window.setTimeout("window.location='"+"{:U('Cms/artclass')}'",1500);
                }
            }
        })      
        return false;
    })
});
</script>

  
</block>