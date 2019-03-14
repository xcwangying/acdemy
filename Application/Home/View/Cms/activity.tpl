<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                活动管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章管理</li>
                <li class="active">活动管理</li>
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
                                        <a href="{:U('Cms/addactivity')}" class="btn btn-primary btn-sm">&nbsp;添加活动</a>
                                        
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('Article/activity')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
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
                                                <th>序号</th>
                                                <th>标题</th>
                                                <th>主图</th>
                                                <th>发布时间</th>
                                                <th>开始时间</th>
                                                <th>截止时间</th>
                                                <!-- <th>活动地址</th> -->
                                                <th>发布人</th>
                                                <th>选项</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th>{$i}</th>
                                                        <th title="{$item.title}"><div style="width:150px; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{$item.title}</div></th>
                                                        <th><a href="#" onclick="showImg('/{$item.picture}')">查看图片</a></th>

                                                        
                                                       <!--  <th>
                                                            <if condition="$item.num eq 0">
                                                                {$item.num}
                                                            <else />
                                                                <a href="{:U('Article/explist')}?suid={$item.id}">{$item.num}</a>
                                                            </if>
                                                        </td> -->
                                                        <!--<th><a href="#" onclick="change('{$item.id}')"><if condition="$item['goods_name']">{$item['goods_name']}<else/>无</if></a></th>-->

                                                        <!-- <if condition="$item['synchronous'] eq 1">
                                                           <th>是</th>
                                                         <else/>
                                                            <th>否</th>
                                                         </if> -->
                                                        <th>{$item.add_time|friendlyDate}</th>
                                                        <th>{$item.k_time|friendlyDate}</th>
                                                        <th>{$item.j_time|friendlyDate}</th>
                                                        <!-- <th><a href="{$item.url}" target="_blank">{$item.url}</a></th> -->
                                                        <!-- <th><a href="{:U('Article/event')}?id={$item.id}">{$item.read_num}</a></th> -->
                                                        <th>{$item.user_name}</th>
                                                        <th>
                                                            <if condition="$item['is_status'] eq 1">
                                                                <a href="{:U('Cms/editactivity')}?id={$item.id}" class="btn btn-xs btn-warning">编辑</a>
                                                                <a aurl="{:U('Cms/soldActivity')}?id={$item.id}&type=2&name={$item.title}" class="btn btn-xs btn-danger cl" >已下架</a>
                                                            <else/>
                                                                <a aurl="{:U('Cms/soldActivity')}?id={$item.id}&type=1&name={$item.title}" class="btn btn-xs btn-success clb">已发布</a>
                                                                
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
    <script>
        $(document).on('click','.cl',function() {
            var url = $(this).attr('aurl');
            art.dialog({
                icon:'question',
                title:'询问',
                content:'确定要发布该活动吗？',
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
                                window.setTimeout("window.location="+"'activity'",1000);
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
                content:'确定要下架该活动吗？',
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
                                window.setTimeout("window.location="+"'activity'",1000);
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
                            lock:true
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