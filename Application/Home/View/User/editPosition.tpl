<extend name="Public/base"/>
<block name="content">
<!-- add by liu 图片裁剪 -->
<!-- 获取图片配置信息 -->
<?php $pic_info=C('picinfo')['friend'];?>

<!-- end by liu 图片裁剪 -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                职位管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li>职位管理</li>

            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="box box-primary">
                        <iframe name="formadd_sq" style="display:none;"></iframe> 
                        <form role="form" name="frm" action="{:U('User/do_editPosition')}?id={$data.position_id}" target="formadd_sq" method="post" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main">
                            <div class="box-body">
                                <div>
                                    <label>名称：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写名称！" name="p_name" value="{$data.p_name}">
                                </div>
                            </div>
                                <input type="hidden" class="form-control"  name="p_id" value="{$data.p_id}">
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

    <script>
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
    </script>
</block>