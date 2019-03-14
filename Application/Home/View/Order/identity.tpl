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
                会员级别管理
      <!--           <small>Goods List</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>会员管理</li>
                <li class="active">会员级别管理</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <!-- /.box-header -->
                        <div class="box-body">
                            <!--<div class="row">
                                <div class="col-sm-5">
                                    <div class="dataTables_length">
                                        <label>
                                   
                                            <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                             <a href="{:U('Order/identity')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                            <php>}</php>
                                        </label>
                                    </div>
                                </div> 

                                <form class="searchform" method="get" >
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
                                </form>                          
                            </div>-->

                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="example1" class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th class="text-center">序号</th>
                                                <th class="text-center">身份名称</th>
                                                <th class="text-center">第一级分成</th>
                                                <th class="text-center">第二级分成</th>
                                                <th class="text-center">第三级分成</th>
                                                <!-- <th class="text-center">客服分成</th> -->
                                                <th class="text-center">时间</th>
                                                <th class="text-center">操作</th>
                                            </tr>
                                        </thead>

                                        <tbody class="text-center">
                                            <if condition="$datalist">
                                                <volist name="datalist" id="item">
                                                   <switch name="item.goods_state">
                                                        <case value="1">
                                                            <tr style='color:#aaa'>
                                                        </case>
                                                        <case value="0">
                                                            <tr>
                                                        </case>
                                                        <default /><tr>
                                                    </switch>

                                                        <td class="text-center">{$i}</td>
                                                        <td class="text-center">{$item.identity}</td>
                                                        <td class="text-center">
                                                            <if condition="$item.in_one eq '0'">
                                                                无
                                                            <else/>
                                                                {$item.in_one}
                                                            </if>
                                                        </td>

                                                        <td class="text-center">
                                                            <if condition="$item.in_two eq '0'">
                                                                无
                                                            <else/>
                                                                {$item.in_two}
                                                            </if>
                                                        </td>

                                                        <td class="text-center">
                                                            <if condition="$item.in_three eq '0'">
                                                                无
                                                            <else/>
                                                                {$item.in_three}
                                                            </if>
                                                        </td>

                                                        <!-- <td class="text-center">
                                                            <if condition="$item.platform eq '0'">
                                                                无
                                                            <else/>
                                                                {$item.platform}
                                                            </if>
                                                        </td> -->

                                                        <td class="text-center">{$item.time|date='Y-m-d H:i:s',###}</td>
                                                    
<!--                                                         <td class="text-center">
                                                            <if condition="$item.goods_state eq '1'">
                                                                <b style="color:red">已下架</b>
                                                            <else/>
                                                                <b style="color:green">正常</b>
                                                            </if>
                                                        </td>  -->

                                                        <td class="text-center">
                                                            <a href="{:U('Order/Editidentity')}?id={$item.id}" class="btn btn-xs btn-warning">编辑</a>                                                      
                                                            
                                                     <!--        <if condition="$item.goods_state eq '0'">
                                                                <a aurl="{:U('Project/unsold')}?goods_id={$item.goods_id}" class="btn btn-xs btn-success cl">下架</a> 
                                                            <else/>
                                                                <a aurl="{:U('Project/sold')}?goods_id={$item.goods_id}" class="btn btn-xs btn-danger cl">上架</a>
                                                            </if>

                                                            <a href="{:U('Project/setting')}?goods_id={$item.goods_id}" class="btn btn-xs btn-info">分销设置</a>      -->                                             
                                                        </td>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="into" colspan="12" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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
<block name="js">
    <script src="__Assert__/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="__Assert__/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script>
    // $(document).on('click','.cl',function() {
    //     var url = $(this).attr('aurl');
    //     var str = $(this).html();
    //     art.dialog({
    //         icon:'question',
    //         title:'询问',
    //         content:'确定要'+str+'吗？',
    //         okVal:'确定',
    //         cancel:true,
    //         cancelVal:'取消',
    //         ok:function(){
    //             $.ajax({ 
    //                 url:url,
    //                 dataType:'json',
    //                 type:'get',
    //                 error: function(){
    //                     art.dialog('请求错误,请检查网络！');
    //                 },
    //                 success:function(re){
    //                     if(re.status == 1){
    //                         art.dialog({
    //                             content:re.info,
    //                         });
    //                         window.setTimeout(window.location="{:U('Project/projectList')}",2000);
    //                     }else{
    //                         art.dialog({
    //                           content:re.info,
    //                         });
    //                         sub.attr('sub',sub.val());
    //                         sub.val('提交');
    //                         sub.attr('disabled',false);
    //                         window.setTimeout(window.location="{:U('Project/projectList')}",2000);
    //                     }
    //                 }
    //             });
    //         }
    //     });
    //     return false;
    // });
    </script>  
</block>























