<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                职位管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>组织架构管理</li>
                <li class="active">职位管理</li>
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
                                        <a href="{:U('User/addPosition')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加职位</a>
                                        
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('User/position')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                                <div class="col-sm-6">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称搜索..." style="width:157px;"/>
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
                                                <th>名称</th>
                                                <th>添加人</th>
                                                <th>添加时间</th>
                                                <th>选项</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th>{$i}</th>
                                                        <th >{$item.p_name}</th>
                                                        <th >{$item.user_name}</th>
                                                        <th >{$item.d_time|friendlyDate}</th>
                                                        <th>
                                                            <a href="{:U('User/editPosition')}?id={$item.p_id}" class="btn btn-xs btn-warning">编辑</a>
                                                            <if condition="$item['is_status'] eq 1">
                                                                <a aurl="{:U('User/userPosition')}?id={$item.p_id}&type=2&name={$item.p_name}" class="btn btn-xs btn-danger cl">已停用</a>
                                                                <!-- <a onclick="if(confirm('是否删除'))return true;else return false;" href="{:U('User/dels')}?id={$item.position_id}" class="btn btn-xs btn-danger">删除</a> -->
                                                            <else/>
                                                                <a aurl="{:U('User/userPosition')}?id={$item.p_id}&type=1&name={$item.p_name}" class="btn btn-xs btn-success clb">合作中</a>
                                                                
                                                            </if>
                                                        </th>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="text-center" class="into" colspan="5" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
                                                </tr>
                                            </if>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
                        <if condition="$data">
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

        $(document).on('click','.cl',function() {
            var url = $(this).attr('aurl');
            art.dialog({
                icon:'question',
                title:'询问',
                content:'确定要启用该职位吗？',
                okVal:'确定',
                cancel:true,
                cancelVal:'取消',
                ok:function(){
                    $.ajax({ 
                        url:url,
                        dataType:'json',
                        type:'get',
                        error: function(){
                            art.dialog('请求错误,请检查网络！');
                        },
                        success: function(result){
                            if(result.status==1){
                                art.dialog({
                                    content:result.msg,
                                    lock:true,
                                    time:1000
                                });
                               window.setTimeout(window.location=window.location.href,2000);
                            }
                            else
                            { 
                                art.dialog({
                                    content:result.msg,
                                    lock:true
                                });
                            }
                        }
                    });
                }
            });
            return false;
        }); 

        $(document).on('click','.clb',function() {
            var url = $(this).attr('aurl');
            art.dialog({
                icon:'question',
                title:'询问',
                content:'确定要停用该职位吗？',
                okVal:'确定',
                cancel:true,
                cancelVal:'取消',
                ok:function(){
                    $.ajax({ 
                        url:url,
                        dataType:'json',
                        type:'get',
                        error: function(){
                            art.dialog('请求错误,请检查网络！');
                        },
                        success: function(result){
                            if(result.status==1){
                                art.dialog({
                                    content:result.msg,
                                    lock:true,
                                    time:1000
                                });
                               window.setTimeout(window.location=window.location.href,2000);
                            }
                            else
                            { 
                                art.dialog({
                                    content:result.msg,
                                    lock:true
                                });
                            }
                        }
                    });
                }
            });
            return false;
        }); 

    </script>

</block>