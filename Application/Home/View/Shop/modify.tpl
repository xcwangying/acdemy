<extend name="Public/base"/>
<block name="content">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                修改密码
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>系统设置</li>
                <li class="active">修改密码</li>
            </ol>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary" id="window_main">
                        <form role="form" method="post" action="{:U('Shop/domodify')}" name="frm" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                            <div class="box-body">
                                <div>
                                    <label>
                                        原始密码：<span style="color: #FF0000;">*</span>
                                    </label>
                                    <input type="password" class="form-control" datatype="*" placeholder="(请输入原始密码)" name="oldpwd" datatype="*" errormsg="请填写原始密码" ajaxurl="{:U('System/isPassword')}" >
                                </div>

                                <div>
                                    <label>
                                        新密码：<span style="color: #FF0000;">*</span>
                                    </label>
                                    <input type="password" class="form-control" datatype="pwd" placeholder="(请输入新密码,至少6位)" name="newpwd" datatype="*6-15" errormsg="请填写新密码,至少6位">
                                </div>

                                <div>
                                    <label>
                                        确认密码：<span style="color: #FF0000;">*</span>
                                    </label>
                                    <input type="password" class="form-control" datatype="repwd" placeholder="(请确认密码)" name="repwd" datatype="*" errormsg="两次密码输入不一致" recheck="pwd1">
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
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
$(function(){
    

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
                    window.setTimeout("window.location='"+"{:U('Login/index')}'",1500);
                }else{
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                    window.setTimeout("window.location='"+"{:U('Shop/modify')}'",1500);
                }
            }
        })      
        return false;
    })
});
    </script>
</block>