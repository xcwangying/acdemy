<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                推广海报
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>内容管理</li>
                <li class="active">推广海报</li>
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
                                    <!-- <label>
                                        <a href="{:U('Adhere/addIndex')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加文章</a>
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('Adhere/index')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label> -->
                                </div>
                            </div>
                            <form class="searchform" method="get">
                              <div class="col-sm-6">
                                    <!-- <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称搜索..." style="width:157px;"/>
                                                <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
                                            </div>
                                        </label>
                                    </div>
                                                                    </div> -->
                            </form>
                        </div>

                            <div class="col-sm-12">
                                
                                    <table id="example1" class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th class="text-center">序号</th>
                                                <th class="text-center">姓名</th>
                                                <th class="text-center">手机号</th>
                                                <th class="text-center">头像</th>
                                                <!-- <th class="text-center">添加时间</th>
                                                <th class="text-center">修改时间</th> -->
                                                
                                                <th class="text-center">选项</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                        <if condition="$info">
                                          <volist name="info" id="item">
                                            <tr>
                                              <th class="text-center">{$i}</th>
                                              <th class="text-center">{$item.vname}</th>
                                              <th class="text-center">{$item.vphone}</th>
                                              <th class="text-center"><a href="#" onclick="showImg('<?php echo C('wxyuming'); ?>/Public/introduce/{$item.vid}/{$item.vid}tt.jpg')">查看图片</a></th>
                                              <!--<th class="text-center">{$item.time|date='Y-m-d H:i:s',###}</th>
                                               <th class="text-center">{$item.lasttime|date='Y-m-d H:i:s',###}</th> -->
                                              <th class="text-center"><a href="{:U('Article/editAnli')}?vid={$item.vid}" class="btn btn-xs btn-warning">查看案例</a></th>
                                            </tr>
                                          </volist>
                                         <else/>
                                         <tr>
                                                <td class="into" colspan="7" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
                                            </tr>
                                        </if>
                                        </tbody>
                                    </table>
                             
                           
                            </div>
                    

                        

                  </div>
                  <if condition="$info">
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
      </section>
  </div>
</block>
<block name="js">
    <script src="__Assert__/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="__Assert__/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script>
        // function ajaxSold(id) {
        //     if (confirm('是否隐藏')) {
        //         $.get("{:U('Adhere/solds')}?id=" + id, function (data, status) {
        //             if (status == 'success') {
        //                 layer.msg(data.msg);
        //             } else {
        //                 layer.msg('系统错误');
        //             }
        //             window.location.reload();
        //         }, 'json');
        //     }
        // }
        // function ajaxUnsold(id) {
        //     if (confirm('是否显示')) {
        //         $.get("{:U('Adhere/unsolds')}?id=" + id, function (data, status) {
        //             if (status == 'success') {
        //                 layer.msg(data.msg);
        //                 setTimeout(function () {
        //                     window.location.reload();
        //                 }, 1500);
        //             } else {
        //                 layer.msg('系统错误');
        //             }
        //         }, 'json');
        //     }
        // }

        function showImg(img) {
            layer.open({
                type: 1,
                title: '主图',
                closeBtn: 2,
                shade: 0.5,
                content: "<img width='100%' height='100%' src='"+img+"'/>",
            });
        }
    </script>
</block>