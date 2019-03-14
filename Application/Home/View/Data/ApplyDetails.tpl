<extend name="Public/base"/>
<block name="css">
    <!-- DataTables -->
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">
</block>

<block name="content">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                报名详情&nbsp;&nbsp;->&nbsp;&nbsp;活动：{$title}
      <!--           <small>Goods List</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>数据分析</li>
                <li>文章分析</li>
                <li class="active">报名详情</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <!-- /.box-header -->
                        <div class="box-body">
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="dataTables_length">
                                        <label>
                                            <a href="{:U('Data/activityStateMent')}" class="btn btn-primary btn-sm">返回</a>&nbsp;&nbsp;&nbsp;


                                    <!--         <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                             <a href="{:U('Track/index')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                            <php>}</php> -->
                                        </label>
                                    </div>
                                </div> 

<!--                                 <form class="searchform" method="get" >
                                    <div class="col-sm-7">
                                        <div class="dataTables_filter">  
                                            <label>
                                                <div class="dataTables_filter">
                                                    <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称搜索..." style="width:157px;"/>
                                                    <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </form>    -->                       
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="example1" class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th class="text-center">序号</th>
                                                <th class="text-center">报名人</th>
                                                <th class="text-center">报名人手机号</th>
                                                <th class="text-center">报名时间</th>
                                            </tr>
                                        </thead>

                                        <tbody class="text-center">
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <td class="text-center">{$i}</td>
                                                        <td class="text-center">{$item.vname}</td>
                                                        <td class="text-center">{$item.vphone}</td>
                                                        <td class="text-center">{$item.payment_time|date='Y-m-d H:i:s',###}</td>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="into" colspan="3" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </section>

    </div>
    <!-- /.box-body -->
    </div>
    <!-- /.box -->
    </div>
    <!-- /.col -->
    </div>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</block>
























