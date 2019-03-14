<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                分类管理

            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>CMS管理</li>
                <li class="active">分类管理</li>
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
                                        <a href="{:U('Cms/addclass')}" class="btn btn-primary btn-sm">添加分类</a>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                            	<div class="col-sm-6">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入分类名称搜索..." style="width:157px;"/>
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
                                                <th>序号</th>
                                                <th>分类名称</th>
                                                <th>文章数量</th>
                                                <th>预览</th>
                                                <th>添加时间</th>
                                                <th>状态</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
	                                        <if condition="$data">
	                                            <volist name="data" id="item">
	                                                <tr>
	                                                    <th>{$i}</th>
                                                        
	                                                    <th>{$item.class_name}</th>
                                                        <th>{$item.nums}</th>
	                                                    <th><a href="http://wx.dym666.com/Preview/classlist/id/{$item.art_cid}" target="_blank">链接</a></th>
	                                                    <th>{$item.dtime|friendlyDate}</th>
                                                        <th> 
                                                            <if condition="$item.is_del eq '0'">
                                                                <b style='color:green'>正常</b>
                                                            <else/>
                                                                <b style='color:red'>已删除</b>
                                                            </if>
                                                        </th>
	                                                    <th><if condition="$item.is_del eq '0'">
                                                                 <a aurl="{:U('Cms/delartclass')}?id={$item.art_cid}&class_name={$item.class_name}" class="btn btn-xs btn-warning del">删除</a> 
                                                            <else/>
                                                                
                                                            </if></th> 
		                                            </tr>
		                                        </volist>
	                                    	<else />
		                                        <tr></tr>
		                                        <tr>
	                                            	<td class="text-center" class="into" colspan="7" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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

    $(document).on('click','.del',function() {
        var url = $(this).attr('aurl');
        art.dialog({
            icon:'question',
            title:'提示',
            content:'确定要删除吗？',
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
                    success:function(re){
                        if(re.status == 1){
                            art.dialog({
                                content:re.info,
                            });
                            window.setTimeout(window.location="{:U('Cms/artclass')}",2000);
                        }else{
                            art.dialog({
                              content:re.info,
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                            window.setTimeout(window.location="{:U('Cms/artclass')}",2000);
                        }
                    }
                });
            }
        });
        return false;
    });
    </script>

</block>