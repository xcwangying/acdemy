<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                留言管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>Cms管理</li>
                <li class="active">留言管理</li>
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
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('Coupon/couponwater')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                                <div class="col-sm-6">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入文章标题,客户名称搜索..." style="width:157px;"/>
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
                                                <th width="3%">序号</th>
                                                <th width="16%">文章</th>
                                                <th width="6%">客户</th>
                                                <th width="23%">留言内容</th>
                                                <th width="8%">留言时间</th>
                                                <th width="23%">回复内容</th>
                                                <th width="8%">回复时间</th>
                                                <th width="6%">回复人</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th>{$i}</th>
                                                        <th>{$item.art_title}</th>
                                                        <th>{$item.customer_name}</th>
                                                        <th>{$item.msg_content}</th>
                                                        <th>{$item.msg_time|friendlyDate}</th>
                                                        <th><eq name="item.msg_reply" value="">—<else/>{$item.msg_reply}</eq></th>
                                                        <th>{$item.msg_reply_time|friendlyDate}</th>
                                                        <th><eq name="item.buser_name" value="">—<else/>{$item.buser_name}</eq></th>
                                                        <th>
                                                           <?php if(!$item['msg_reply']): ?>
                                                            <a id="hf" class="btn btn-xs btn-primary btn-sm" data ="{$item.msg_id}" datas ="{$item.openid}">回复</a>
                                                        <?php endif;?>
                                                            <if condition="$item.msg_status eq '1'">
                                                                <a aurl="{:U('Cms/soldmessage')}?art_id={$item.art_id}&id={$item.msg_id}&type=2&name={$item.art_title}" class="btn btn-xs btn-danger cl" >隐藏中</a>
                                                            <else/>
                                                                <a aurl="{:U('Cms/soldmessage')}?art_id={$item.art_id}&id={$item.msg_id}&type=1&name={$item.art_title}" class="btn btn-xs btn-success clb" >展示中</a>
                                                            </if>
                                                        </th>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="text-center" class="into" colspan="9" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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
    <script type="text/javascript">
    $(document).on('click','#hf',function() {
        var lid = $(this).attr('data');
        var openid = $(this).attr('datas');
        var str = "<iframe name='my_reply' style='display:none'/><head><link type='text/css' href='__Assert__/css/validform.css' rel='stylesheet'/></head><div style='width:500px'><form role='form' name='frm' action='"+"{:U('Cms/do_reply')}"+"' method='post' class='form-horizontal form-seperated shequn validform  window_main' target='my_reply'><div class='box-body'><input type='hidden' name='lid' value='"+lid+"'><input type='hidden' name='openid' value='"+openid+"'><textarea rows='5' cols='80' placeholder='请输入回复内容！(最多可输入30-50个汉字)' name='msg_reply'></textarea><div class='box-footer'><button type='submit' class='btn btn-primary' id='submit'>提交</button></div></form></div><script>$(function(){$('.validform').Validform({tiptype:3,ignoreHidden:true,datatype:{'z2-4' : /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,4}$/ ,}});});<\/script>";
        aid = art.dialog({
            title:'回复',
            content:str,
            lock:true,
            time:1000
        });
    }); 
</script>
<script type="text/javascript">
	$(document).on('click','.cl',function() {
            var url = $(this).attr('aurl');
            art.dialog({
                icon:'question',
                title:'询问',
                content:'确定要展示该留言吗？',
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
                                    content:result.info,
                                    lock:true,
                                    time:1000
                                });
                                window.setTimeout("window.location="+"'message'",1000);
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
        }); 

        $(document).on('click','.clb',function() {
            var url = $(this).attr('aurl');
            art.dialog({
                icon:'question',
                title:'询问',
                content:'确定要屏蔽该留言吗？',
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
                                    content:result.info,
                                    lock:true,
                                    time:1000
                                });
                                window.setTimeout("window.location="+"'message'",1000);
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
        }); 
</script>
</block>