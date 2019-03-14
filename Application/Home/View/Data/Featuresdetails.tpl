<extend name="Public/base" />
<block name="css">
    <!-- Morris Charts CSS -->
    <link href="__Assert__/bower_components/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
    <style>
        .type{ height:28px; line-height: 28px;}
        .sta_type{ margin-right: 0px;}
        .my-btn{ height:28px; margin-left:-2px; margin-top:-4px;}
        .pagination a, .pagination span{ display: inline-block; padding:0 10px; height:30px; text-align: center; line-height: 30px; border:solid 1px #ccc;}
        .pagination span{ background: #337ab7; color:white; border:solid 1px #337ab7;}
    </style>
</block>
<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1 style="margin-bottom:10px">
                功能点击详情
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>数据分析</li>
                <li>功能报表</li>
                <li class="active">功能点击详情</li>
            </ol>
        </section>
        <section>
    <div class="panel panel-info">
        <div class="panel-body">
        <div class="row" id="window_main">
            <div class="window_main_top" style="margin-bottom:10px;border:none;">
            <div class="col-lg-12">
                <div class="panel  panel-default" style='border:none;'>

                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-5">
                                <div class="dataTables_length">
                                    <label>
                                        <a href="{:U('Data/gnStateMent')}"><input type="button" class="btn btn-sm btn-primary" value="返回"></a>
                                    </label>
                                </div>
                            </div> 

                  <!--           <form class="searchform" method="get" >
                                <div class="col-sm-7">
                                    <div class="dataTables_filter">  
                                        <div class="dataTables_filter" style="display:inline-block;float:right">
                                            <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入订单编号搜索..." style="width:157px;"/>
                                            <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;" id="chaxun"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </form>   -->                        
                        </div>
                    </div>

 <div class="panel-body" style="overflow-x:auto;">
    <div class="dataTable_wrapper">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th class="text-center">序号</th>
                    <th class="text-center">用户名称</th>
                    <th class="text-center">手机号</th>
                    <th class="text-center">点击详情</th>
                    <th class="text-center">时间</th>
                </tr>
            </thead>

            <tbody>
                <volist name="data" id="vo">
                    <tr>
                        <td class="text-center">{$i}</td>
                        <td class="text-center">{$vo.sname}</td>
                        <td class="text-center">{$vo.vphone}</td>
                        <td class="text-center">{$vo.event}</td>
                        <td class="text-center">{$vo['dtime']|date="Y-m-d H:i:s",###}</td>
                    </tr>
                </volist>
            </tbody>
        </table>

        <div class="row">
            <div class="col-sm-5">
                <div class="dataTables_info">
                    <span>共有<code>{$count}</code>条记录</span>
                </div>
            </div>
            <div class="col-sm-7">
                <div class="dataTables_paginate paging_simple_numbers">
                    <ul class="pagination">{$page}</ul>
                </div>
            </div>
        </div>
</div>
</div>
</section>
</div>
</block>
<block name="js">

</block>  