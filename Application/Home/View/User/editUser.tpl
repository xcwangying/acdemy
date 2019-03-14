<extend name="Public/base"/>
<block name="content">
<?php $pic_info=C('picinfo')['human'];?>
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
        background-image: url("<?php if($data['user_picture']):?>http://i.dym666.com/<?php echo $data['user_picture'];?><?php else:?>__Assert__/img/123.png<?php endif;?>");
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
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                编辑员工
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li>员工管理</li>
                <li class="active">编辑员工</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <!-- left column -->
                <div class="col-xs-8">
                    <!-- general form elements -->
                    <div class="box box-primary">
                          <iframe name="formadd_sq" style="display:none;"></iframe> 
                        <form role="form" name="frm" action="{:U('User/do_EditUser')}"  method="post"  target="formadd_sq" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main">
                           <div class="box-body">
                            <input type="hidden" name="user_id" value="{$data.user_id}">
                                <div>
                                    <label>
                                       部门：<span style="color: #FF0000;">*</span>
                                    </label>
                                    <select class="form-control" name="d_id"  nullmsg="请选择部门" errormsg="请选择部门">
                                        <option value class="form-control">请选择部门</option>
                                        <volist name="departmentlist" id="item" >
                                           <option value="{$item.d_id}" <eq name="item.d_id" value="$data.d_id">selected</eq>>{$item.d_name}</option>
                                        </volist>
                                    </select>
                                </div>

                                <div>
                                    <label>
                                       职位：<span style="color: #FF0000;">*</span>
                                    </label>
                                    <select class="form-control" name="p_id" datatype="*" nullmsg="请选择职位" errormsg="请选择职位">
                                        <option value class="form-control">请选择职位</option>
                                        <volist name="positionlist" id="item" >
                                           <option value="{$item.p_id}" <eq name="item.p_id" value="$data.p_id">selected</eq>>{$item.p_name}</option>
                                        </volist>
                                    </select>
                                </div>



                               <!--  <div>
                                    <label>工号：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写工号！" name="user_code" value="{$data.user_code}">
                                </div> -->

                                <div>
                                    <label>姓名：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="*" placeholder="(必填)请填写姓名！" name="user_name" value="{$data.user_name}">
                                </div>

                                <div>
                                    <label>
                                       性别：<span style="color: #FF0000;">* </span><span style="color: #999999;"></span>
                                    </label>
                                    <select class="form-control" name="user_sex">
                                        <?php if($data['user_sex']==1):?>
                                            <option value="1" class="form-control">男</option>
                                        <?php else:?>
                                            <option value="0" class="form-control">女</option>
                                        <?php endif;?>
                                        <option value="1" class="form-control">男</option>
                                        <option value="0" class="form-control">女</option>
                                    </select>
                                </div>

                               
                                <div>
                                    <label>手机号：<span style="color:red"> *</span></label>
                                    <input type="text" class="form-control" datatype="tel" placeholder="(必填)请填写手机号" name="user_tel" value="{$data.user_tel}">
                                </div>

                                <div>
                                    <label>密码：<span style="color:red"></span></label>
                                    <input type="text" class="form-control" placeholder="请填写密码（不填不修改）" name="user_password">
                                </div>

                           

                             
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">提交</button>
      
                                <a href="{:U('User/User')}" class="btn btn-info">返回</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</block>
<block name="js">

     
<!-- end by liu 图片裁剪 -->
<script type="text/javascript" src="__Assert__/js/Validform_v5.3.2_min.js"></script>
<link type="text/css" href="__Assert__/css/validform.css" rel="stylesheet"/>
<script type="text/javascript">
    // var ue = UE.getEditor('c_detial');
</script> 
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
<script>
    $(':submit').click(function(){
        $('form').submit();
        var $this = $(this);
        $this.prop('disabled',true);
        setTimeout(function(){
            $this.removeAttr('disabled');
        },5000);
    })
</script>
</block>