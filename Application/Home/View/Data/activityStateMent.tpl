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
                文章分析
      <!--           <small>Goods List</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>数据分析</li>
                <li class="active">文章分析</li>
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
                                            
                                            <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                             <a href="{:U('Data/activityStateMent')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                            <php>}</php>
                                        </label>
                                    </div>
                                </div> 

                                <form class="searchform" method="get" >
                                    <div class="col-sm-7">
                                        <div class="dataTables_filter">  
                                            <label>
                                                <div class="dataTables_filter">
                                                    <span>文章分类：</span>
                                                    <select name="atype" class="form-control input-sm" style="width: auto;">
                                                        <option value="0" <if condition="$atype eq 0">selected</if>>专访分析</option>
                                                        <option value="1" <if condition="$atype eq 1">selected</if>>活动分析</option>
                                                    </select>
<!--                                                     <span>&nbsp;&nbsp;身份：</span>
                                                    <select name="goods_identity" class="form-control input-sm" style="width: auto;">
                                                        <option value="-1">全部</option>
                                                        <volist name="identityList" id="item">
                                                             <option value="{$item.id}" <if condition="$item['id'] eq $goods_identity">selected</if>>{$item.identity}</option>
                                                        </volist>
                                                    </select> -->
                                                    <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称搜索..." style="width:157px;"/>
                                                    <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
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
                                                <th class="text-center">序号</th>
                                                <th class="text-center">名称</th>
                                                <th class="text-center">阅读量</th>
                                                <if condition="$atype eq '1'">
                                                    <th class="text-center">报名数</th>
                                                </if>       
                                                <th class="text-center">最后阅读时间</th>
                                            </tr>
                                        </thead>

                                        <tbody class="text-center">
                                            <if condition="$articleList">
                                                <volist name="articleList" id="item">
                                                    <tr>
                                                        <td class="text-center">{$i}</td>
                                                        <td class="text-center">{$item.title}</td>
                                                        <td class="text-center">
                                                            <if condition="$item.read_num eq 0">
                                                                {$item.read_num}
                                                            <else />
                                                                <a href="{:U('Data/ReadDetails')}?suid={$item.id}">{$item.read_num}</a>
                                                            </if>
                                                        </td>
                                                        <if condition="$atype eq '1'">
                                                            <td class="text-center">
                                                                <if condition="$item.bnum eq 0">
                                                                    0
                                                                <else />
                                                                    <a href="{:U('Data/ApplyDetails')}?goods_id={$item.goods_id}">{$item.bnum}</a>
                                                                </if>
                                                            </td>
                                                        </if>  
                                                        <td class="text-center">{$item.end_time|date='Y-m-d H:i:s',###}</td>
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

                            <if condition="$articleList">
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
























