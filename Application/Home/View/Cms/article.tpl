<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                文章管理
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>文章CMS管理</li>
                <li class="active">文章管理</li>
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
                                        <a href="{:U('Cms/addarticle')}" class="btn btn-primary btn-sm">&nbsp;添加文章</a>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                                <div class="col-sm-6">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                            <span>&nbsp;&nbsp;分类：</span>
                                                    <select name="art_cid" class="form-control input-sm" style="width: auto;">
                                                        <option value>全部</option>
                                                        <volist name="artclasslist" id="item">
                                                             <option value="{$item.art_cid}" <if condition="$item['art_cid'] eq $art_cid">selected</if>>{$item.class_name}</option>
                                                        </volist>
                                                    </select>
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
                                                <th>分类</th>
                                                <th>主图</th>
                                                <th>跳转的商品</th>
                                                <th>作者</th>
                                                <th>阅读量</th>
                                                <th>点赞量</th>
                                                <th>添加时间</th>
                                                <th>排序</th>
                                                <th>选项</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th>{$i}</th>
                                                        <th><div style="width:80%;"><a href="http://wx.dym666.com/Preview/articleDetails/id/{$item.art_id}" target="Article">{$item.art_title}</a></div></th>
                                                        
                                                        <th><a href="{:U('Cms/article')}?art_cid={$item.art_cid}">{$item.class_name}</a></th>

                                                        <th><a href="#" onclick="showImg('/{$item.art_pic}')">查看</a></th>
                                                        <th><if condition="$item.c_id eq 0">--<else />{$item.c_name}</a></if></th>
                                                        <th>{$item.uname}</th>
                                                        <th>{$item.num}</th>
                                                        <th>{$item.thumbs}</th>
                                                        <th>{$item.f_dtime|friendlyDate}</th>
                                                        <th>
                                                            <!-- <form name="frm" method="post" action="{:U('Cms/orderArticle')}"> -->
                                                            <form role="form" method="post" action="{:U('Cms/orderArticle')}" name="frm" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" cleandata="#pro_tbody">
                                                                <input type="hidden" name="id" value="{$item.art_id}">
                                                                <input type="hidden" name="art_title" value="{$item.art_title}">
                                                                <input type="text" name="orders" style="width:35px;height:1;text-align: center;" value="{$item.orders}">
                                                                <button type="submit" class="btn btn-xs btn-info">确定</button>
                                                            </form>
                                                        </th>

                                                        <th>
                                                            <if condition="$item['is_status'] eq 1">
                                                                <a aurl="{:U('Cms/soldArticle')}?id={$item.art_id}&type=1&name={$item.art_title}" class="btn btn-xs btn-success clb" >已发布</a>
                                                            <else/>
                                                                <a href="{:U('Cms/editArticle')}?id={$item.art_id}" class="btn btn-xs btn-warning">编辑</a>
                                                                <a aurl="{:U('Cms/soldArticle')}?id={$item.art_id}&type=2&name={$item.art_title}" class="btn btn-xs btn-danger cl" >已下架</a>
                                                                
                                                            </if>
                                                        </th>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="text-center" class="into" colspan="12" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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
                content:'确定要发布该文章吗？',
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
                                window.setTimeout("window.location="+"'article'",1000);
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
                content:'确定要下架该文章吗？',
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
                                window.setTimeout("window.location="+"'article'",1000);
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
            art.dialog({content:"<img src='http://i.dym666.com/"+img+"'  width='500px'/>",
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
    <script type="text/javascript">
$(function(){
    //表单验证
    $(".validform").Validform({
        tiptype:3,
        ignoreHidden:true,
        datatype:{
            //中文验证
            "z2-4" : /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,4}$/ ,
            "currency" : /^\d+(\.\d+)?$/ ,
            "dxzm":/^[A-Z]{5,20}$/,
            "tel":/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,  
            }
    });
});
    var clid;
    $(document).on("submit",".validform",function(){
        var link = $(this).attr('action');
        var sub = $(this).find(":submit");
        sub.attr('sub',sub.val());
        sub.val('提交中...');
        sub.attr('disabled','disabled');
        var data = $(this).serializeArray(); 
        clid = art.dialog({
                content:"请等待，修改中....",
                lock:true
            });
        $.ajax({
            type:"post",
            url:link,
            data:data,
            error:function(){
                clid.close();
                art.dialog({
                    content:"网络错误，请重试！",
                    lock:true
                });
            },
            success:function(re){
                clid.close();
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Cms/article')}'",1500);
                }else{
                    art.dialog({
                      content:re.info,
                      lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                    //window.setTimeout(window.location="{:U('Project/courseList')}",2000);
                }
            }
        })      
        return false;
    })
</script>

</block>