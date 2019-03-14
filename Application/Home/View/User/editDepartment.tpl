<extend name="Public/base"/>
<block name="content">

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                编辑部门
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li>部门管理</li>
                <li class="active">编辑部门</li>
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
                        <form role="form" name="frm" action="{:U('User/do_editDepartment')}?id={$data.department_id}" target="formadd_sq" method="post" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main">
                            <div class="box-body">

                                
                               

                               

                                <div>
                                    <label>
                                       负责人： <span style="color: #FF0000;">*</span>
                                    </label>
                                    <select class="form-control" name="user_id" datatype="*" nullmsg="请选择负责人" errormsg="请选择负责人">
                                        <option value class="form-control">请选择负责人</option>
                                        <volist name="user" id="item" >
                                           <option value="{$item.user_id}" <eq name="item.user_id" value="$data.u_id">selected</eq>>{$item.user_name}</option>
                                        </volist>
                                    </select>
                                </div>

                                <div>
                                    <label>部门名称：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写联系人！" name="d_name" value="{$data.d_name}">

                                     <input type="hidden" class="form-control"  name="d_id" value="{$data.d_id}">
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
 
                                <a href="{:U('User/department')}" class="btn btn-info">返回</a>
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