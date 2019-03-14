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
                课程列表
      <!--           <small>Goods List</small> -->
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>内容管理</li>
                <li class="active">课程列表</li>
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
                                            <a href="{:U('Article/addCourse')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加课程</a>
                                            <a href="{:U('Article/merActivity')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;活动轮播图</a>
                                            <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                             <a href="{:U('Article/courseList')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                            <php>}</php>
                                        </label>
                                    </div>
                                </div> 

                                <form class="searchform" method="get" >
                                    <div class="col-sm-7">
                                        <div class="dataTables_filter">  
                                            <label>
                                                <div class="dataTables_filter">
                                                    <!-- <span>项目分类：</span>
                                                    <select name="pid" class="form-control input-sm" style="width: auto;">
                                                        <option value="-1">全部</option>
                                                        <volist name="projectList" id="vo">
                                                             <option value="{$vo.pid}" <if condition="$vo['pid'] eq $pid">selected</if>>{$vo.name}</option>
                                                        </volist>
                                                    </select> -->
                                                    <span>&nbsp;&nbsp;身份：</span>
                                                    <select name="goods_identity" class="form-control input-sm" style="width: auto;">
                                                        <option value="-1">全部</option>
                                                        <volist name="identityList" id="item">
                                                             <option value="{$item.id}" <if condition="$item['id'] eq $goods_identity">selected</if>>{$item.identity}</option>
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
                                                <th class="text-center">序号</th>
                                                <th class="text-center">课程名称</th>
                                                <th class="text-center">课程价格</th>
                                                <th class="text-center">课程主图</th>
                                                <!-- <th class="text-center">课程分类</th> -->
                                                <th class="text-center">对应身份</th>
                                                <th class="text-center">已下单数量</th>
                                                <th class="text-center">已支付数量</th>
                                                <th class="text-center">报名开始时间</th>
                                                <th class="text-center">报名结束时间</th>
                                                <th class="text-center">添加时间</th>
                                                <th class="text-center">状态</th>
                                                <th class="text-center">排序</th>
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
                                                        <td class="text-center">{$item.goods_name}</td>
                                                        <td class="text-center">{$item.goods_price}</td>
                                                        <td class="text-center">
                                                            <if condition="$item.goods_image eq ''">
                                                                无图片
                                                            <else/>
                                                                <a href="#" onclick="showImg('/{$item.goods_image}')">查看图片</a>
                                                            </if>
                                                        </td>
                                                        <!-- <td class="text-center">{$item.name}</td> -->
                                                        <td class="text-center">{$item.identity}</td>
                                                        <td class="text-center">
                                                            <if condition="$item.goods_order eq 0">
                                                                无
                                                            <else/>
                                                                <a href="{:U('Article/payment')}?goods_id={$item.goods_id}&payStatus=0">{$item.goods_order}单</a> 
                                                            </if>
                                                        </td>
                                                        <td class="text-center">
                                                            <if condition="$item.goods_pay eq 0">
                                                                无
                                                            <else/>
                                                                <a href="{:U('Article/payment')}?goods_id={$item.goods_id}&payStatus=1">{$item.goods_pay}单</a>
                                                            </if>
                                                        </td>
                                                        <td class="text-center">{$item.statime|date='Y-m-d',###}</td>
                                                        <td class="text-center">{$item.endtime|date='Y-m-d',###}</td>
                                                        <td class="text-center">{$item.goods_addtime|date='Y-m-d H:i:s',###}</td>
                                                    
                                                        <td class="text-center">
                                                            <if condition="$item.goods_state eq '1'">
                                                                <b style="color:red">已下架</b>
                                                            <else/>
                                                                <b style="color:green">正常</b>
                                                            </if>
                                                        </td> 
                                                        <if condition="$item['goods_state'] eq 1">
                                                            <form name="frm" method="post" action="{:U('Article/goodsorder')}">
                                                                <th class="text-center">
                                                                    <!-- <input type="hidden" name="id" value="{$item.goods_id}"> -->
                                                                    <input type="text" name="order" style="width:35px;height:1;text-align: center;" value="{$item.orders}">
                                                                    <!-- <button type="submit" class="btn btn-xs btn-info">确定</button> -->
                                                                </th>
                                                            </form>
                                                        <else/>
                                                            <form name="frm" method="post" action="{:U('Article/goodsorder')}">
                                                            <th class="text-center">
                                                                <input type="hidden" name="id" value="{$item.goods_id}">
                                                                <input type="text" name="order" style="width:35px;height:1;text-align: center;" value="{$item.orders}">
                                                                <button type="submit" class="btn btn-xs btn-info">确定</button>
                                                            </th>
                                                        </form>
                                                        </if>
                                                        <td class="text-center">
                                                            <a href="{:U('Article/editCourse')}?goods_id={$item.goods_id}" class="btn btn-xs btn-warning">编辑</a>                                                      
                                                            
                                                            <if condition="$item.goods_state eq '0'">
                                                                <a aurl="{:U('Article/unsoldsp')}?goods_id={$item.goods_id}" class="btn btn-xs btn-success cl">下架</a> 
                                                            <else/>
                                                                <a aurl="{:U('Article/soldsp')}?goods_id={$item.goods_id}" class="btn btn-xs btn-danger cl">上架</a>
                                                            </if>                                                  
                                                        </td>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="into" colspan="13" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
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
    $(document).on('click','.cl',function() {
        var url = $(this).attr('aurl');
        var str = $(this).html();
        art.dialog({
            icon:'question',
            title:'询问',
            content:'确定要'+str+'吗？',
            okVal:'确定',
            cancel:true,
            lock:true,
            cancelVal:'取消',
            ok:function(){
                $.ajax({ 
                    url:url,
                    dataType:'json',
                    type:'get',
                    error: function(){
                        art.dialog({
                            content:'请求错误,请检查网络！',
                            lock:true
                        });
                    },
                    success:function(re){
                        if(re.status == 1){
                            art.dialog({
                                content:re.info,
                                lock:true
                            });
                            window.setTimeout("window.location='"+"{:U('Article/courseList')}'",2000);
                        }else{
                            art.dialog({
                              content:re.info,
                              lock:true
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                            //window.setTimeout(window.location="{:U('Article/courseList')}",2000);
                        }
                    }
                });
            }
        });
        return false;
    });

    function showImg(img) {
        art.dialog({content:"<img src='"+img+"'/>",
                title: '课程主图',
                lock: true,
                width:500,
            });
    }
    </script>  
</block>