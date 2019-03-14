<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                员工管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li class="active">员工管理</li>
            </ol>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">
                            <div class="col-sm-6">
                                <div class="dataTables_length">
                                    <label>
                                        <a href="{:U('User/addUser')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加员工</a>
                                        
                                        <php>if( !empty($_GET) ){</php>
                                        <a href="{:U('User/user')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                                <div class="col-sm-6">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                           
                                                <input type="text" class="input_ser input-sm form-control ui-widget lee_search" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称/号码/工号/部门搜索..." style="width:157px;"/>
                                                <button class="form-control btn btn-primary btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                    <table id="example1" class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>工号</th>
                                                <th>姓名</th>
                                                <th>性别</th>
                                                <th>手机号</th>
                                                <th>部门</th>
                                                <th>职位</th>
                                                <!-- <th>图像</th> -->
                                                <!-- <th>地址</th> -->
                                                <th>选项</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th>{$i}</th>
                                                        <th >{$item.user_code}</th>
                                                        <th >{$item.user_name}</th>
                                                        <th><eq name="item.user_sex" value="1">男<else/>女</eq></th>
                                                        <th >{$item.user_tel}</th>
                                                        <th >{$item.d_name}</th>
                                                        <th >{$item.p_name}</th>
                                                <!--         <th><a href="#" onclick="showImg('{$item.user_picture}')">查看</a></th> -->
                                   
                                                        <th>
                                                            <a href="{:U('User/editUser')}?id={$item.user_id}" class="btn btn-xs btn-warning">编辑</a>
                                                  <!--           <if condition="$item['is_status'] eq 1">
                                                                <a onclick="openUser('{$item.user_id}')" class="btn btn-xs btn-danger cl">离职</a>
                                                            <else/>
                                                                <a onclick="closeUser('{$item.user_id}')" class="btn btn-xs btn-success clb">在职</a>
                                                                
                                                            </if> -->
                                                            <a href="{:U('User/editaccess')}?id={$item.user_id}" class="btn btn-xs btn-primary">设置权限</a>
                                                        </th>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="text-center" class="into" colspan="12" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
                                                </tr>
                                            </if>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
                        <if condition="$datalist">
                        <div class="row">
                            <div class="col-sm-5">
                                <div class="dataTables_info">
                                    <span>共有<code>{$count}</code>条记录</span>
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination">
                                        {$page}
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </if>
                    </div>
                </div>
            </div>
        </section>
    </div>
</block>
<block name="js">
    <script src="__Assert__/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="__Assert__/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script>

    function openUser(a){
        var $user_id = a;
        art.dialog({
            icon:'question',
            title:'询问',
            content:'确定要启用该员工吗？',
            okVal:'确定',
            cancel:true,
            cancelVal:'取消',
            ok:function(){
                $.ajax({ 
                    url:"{:U('User/openUser')}",
                    data:{'user_id':$user_id},
                    dataType:'json',
                    type:'post',
                    error: function(){
                        art.dialog('请求错误,请检查网络！');
                    },
                    success: function(result){
                        if(result.status==1){
                            art.dialog({
                                content:result.info,
                                lock:true,
                                time:1000
                            });
                            window.setTimeout("window.location="+"'user'",1000);
                        }
                        else
                        { 
                            art.dialog({
                                content:result.info,
                                lock:true
                            });
                        }
                    }
                });
            }
        });
        return false;
    }

    function closeUser(a){
        var $user_id = a;
        art.dialog({
          title: '请填写员工离职信息',
          content: "<iframe src='' frameborder='0' name='lee_iframe' class='hidden'></iframe><form role='form' method='post' action='{:U(\'User/closeUser\')}' name='frm' class='form-horizontal form-seperated shequn validform  window_main' cleandata='#pro_tbody' target='lee_iframe'><input type='text' class='form-control lee_date' datatype='*' nullmsg='请填写员工离职时间' placeholder='请填写员工离职时间(必填)' name='buser_out_date'><select class='input_ser input-sm form-control ui-widget' name='buser_out_type' style='width:150px;'><option>请选择离职类别</option> <option value='1'>正常离职</option> <option value='2'>急辞</option> <option value='3'>辞职</option><option value='4'>自动离职</option><option value='5'>劝退</option> </select><input type='hidden' name='buser_id' value='"+$user_id+"'><button type='submit' class='btn btn-primary'>提交</button></form>",
          lock: true,
          width: 500,
        });
        $('.lee_date').datepicker({
            format: 'yyyy-mm-dd ',
            autoclose: true,
        });
    }


function showImg(img) {
    art.dialog({content:"<img src='http://i.dym666.com/"+img+"'  width='500px'/>",
        title: '查看图片',
        lock: true,
        width:500,
    });
}

$('.lee_search').change(function(){
        $('.searchform').submit();
    });
</script>

</block>