<extend name="Public/base"/>
<block name="content">
<?php $pic_info=C('picinfo')['friend'];?>

    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                添加职位
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li>职位管理</li>
                <li class="active">添加职位</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary" id="window_main">
                        <iframe name="formadd_sq" style="display:none;"></iframe> 
                        <form role="form" method="post" action="{:U('User/do_addPosition')}" name="frm" target="formadd_sq" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                            <div class="box-body">
                                <div>
                                    <label>名称：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写名称！" name="p_name">
                                </div>

                            </div>

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
                                <a href="{:U('User/position')}" class="btn btn-info">返回</a>
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

</script>
</block>