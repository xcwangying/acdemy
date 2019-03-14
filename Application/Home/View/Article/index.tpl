<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                专访管理

            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章管理</li>
                <li class="active">专访管理</li>
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
                                        <a href="{:U('Article/addStories')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加专访</a>
                                        <a href="{:U('Article/merStories')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;专访轮播图</a>
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('Article/index')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
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
                                                
                                                <th class="text-center">标题</th>
                                                <th class="text-center">主图</th>
                                                <!-- <th class="text-center">跳转的商品</th> -->
                                                <th class="text-center">发布时间</th>
                                                <th class="text-center">阅读量</th>
                                                <th class="text-center">发布人</th>
                                                <th class="text-center">排序</th>
                                                <th class="text-center">选项</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
	                                        <if condition="$data">
	                                            <volist name="data" id="item">
	                                                <tr>
	                                                    <th class="text-center">{$i}</th>
                                                        
	                                                    <th class="text-center" title="{$item.title}">{$item.title}</th>
	                                                    <th class="text-center"><a href="#" onclick="showImg('/{$item.picture}')">查看图片</a></th>
	                                                    <th class="text-center">{$item.add_time|date='Y-m-d H:i:s',###}</th>
                                                        <th class="text-center"><a href="{:U('Article/event')}?id={$item.id}">{$item.read_num}</a></th>
	                                                    <th class="text-center">{$item.name}</th>
                                                        
                                                        

                                                        <if condition="$item['status'] eq 1">
                                                            <form name="frm" method="post" action="{:U('Article/sindex')}">
                                                                <th class="text-center">
                                                                    <!-- <input type="hidden" name="id" value="{$item.id}"> -->
                                                                    <input type="text" name="order" style="width:35px;height:1;text-align: center;" value="{$item.orders}">
                                                                    <!-- <button type="submit" class="btn btn-xs btn-info">确定</button> -->
                                                                </th>
                                                            </form>
                                                        <else/>
                                                            <form name="frm" method="post" action="{:U('Article/sindex')}">
                                                            <th class="text-center">
                                                                <input type="hidden" name="id" value="{$item.id}">
                                                                <input type="text" name="order" style="width:35px;height:1;text-align: center;" value="{$item.orders}">
                                                                <button type="submit" class="btn btn-xs btn-info">确定</button>
                                                            </th>
                                                        </form>
                                                        </if>

	                                                    <th class="text-center">

	                                                        <a href="{:U('Article/editStories')}?id={$item.id}" class="btn btn-xs btn-warning">编辑</a>
		                                                    <if condition="$item['status'] eq 1">
		                                                        <a onclick="if(confirm('是否显示'))return true;else return false;" href="{:U('Article/unsold')}?id={$item.id}" class="btn btn-xs btn-danger">隐藏中</a>
                                                                <a onclick="if(confirm('是否删除'))return true;else return false;" href="{:U('Article/dels')}?id={$item.id}" class="btn btn-xs btn-danger">删除</a>
		                                                    <else/>
		                                                        <a onclick="if(confirm('是否隐藏'))return true;else return false;" href="{:U('Article/sold')}?id={$item.id}" class="btn btn-xs btn-success">展示中</a>
		                                                        
		                                                    </if>
	                                                	</th>
		                                            </tr>
		                                        </volist>
	                                    	<else />
		                                        <tr></tr>
		                                        <tr>
	                                            	<td class="into" colspan="7" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
	                                            </tr>
		                                    </if>
                                		</tbody>
                                    </table>
                            </div>
                        </div>

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
        function ajaxSold(id) {
            if (confirm('是否隐藏')) {
                $.get("{:U('Article/sold')}?id=" + id, function (data, status) {
                    if (status == 'success') {
                        layer.msg(data.msg);
                    } else {
                        layer.msg('系统错误');
                    }
                    window.location.reload();
                }, 'json');
            }
        }
        function ajaxUnsold(id) {
            if (confirm('是否显示')) {
                $.get("{:U('Article/unsold')}?id=" + id, function (data, status) {
                    if (status == 'success') {
                        layer.msg(data.msg);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1500);
                    } else {
                        layer.msg('系统错误');
                    }
                }, 'json');
            }
        }

        function showImg(img) {
            art.dialog({content:"<img src='"+img+"'  width='500px'/>",
                title: '查看图片',
                lock: true,
                width:500,
            });
        }
        function change(id) {
            var data={id:id};
            $.ajax({
                url: "{:U('Article/chang_goods')}",
                type: "post",
                data: data,
                dataType: "text",
                success: function(re) {
                    art.dialog({
                            title:'修改跳转商品',
                            content:re,
                        });
                },
            });
        }
        $("input[name=order]").blur(function(){
            //文章的id
            var id=$(this).attr('id');
            var order=$(this).val();
            //alert(order);
            //return false;
            var data={id:id,order:order};
            $.ajax({
                url: "{:U('Article/orderstories')}",
                type: "post",
                data: data,
                dataType: "json",
                success: function(re) {
                    if(re.status==1){
                        alert('设置成功!');
                    }else{
                        alert('设置失败!');
                    }
                },
            });
        })
    </script>

</block>