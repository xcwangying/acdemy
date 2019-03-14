<extend name="Public/base"/> 
<style type="text/css">
    .ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
    .ui-timepicker-div dl { text-align: left; }
    .ui-timepicker-div dl dt { height: 25px; margin-bottom: -25px; }
    .ui-timepicker-div dl dd { margin: 0 10px 10px 65px; }
    .ui-timepicker-div td { font-size: 90%; }
    .ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0;}

.new span{background-color:#fff;width:45px;display:inline-block;}
     
</style>
<script src="__Assert__/plugins/datatables/jquery-2.2.3.js"></script>
<block name="css">
    <!-- DataTables -->
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">
      <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
      <script src="//code.jquery.com/jquery-1.10.2.js"></script>
      <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</block>
<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                商品订单列表
                
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>会员管理</li>
                <li class="active">商品订单列表</li>
            </ol>
        </section>

        <section class="content">
            <div class="row" id="window_main">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">
                                <form class="searchform" method="get">
                                    <div class="col-sm-5">
                                        <div class="dataTables_length">
                                            <label>
                                                <php>if($_GET['searchtext']!='' || $_GET['payStatus']!='' ){</php>
                                            		<a href="{:U('Order/index')}" class="btn btn-sm btn-primary">撤销搜索</a>
                                            	<php>}</php>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="dataTables_filter">  
                                            <label>
                                                <div class="dataTables_filter">
                                                    <select name="payStatus" class="form-control input-sm" style="width: auto;">
                                                        <option value="">全部</option>
                                                        
                                                        <option value="0"
                                                        <?php if($payStatus==='0'){ ?>
                                                            selected
                                                        <?php } ?>
                                                        >未付款</option>
                                                       
                                                        <option value="1"
                                                            <?php if($payStatus==='1'){ ?>
                                                            selected
                                                        <?php } ?>
                                                        >已付款</option>
                                 
                                                       
                                                </select>

                                                    <span class="sta_other " style="padding-bottom:5px;">
                                                        <input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="date_begin" value="{$startTime | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;font-size:14px;"/>
                                                        至<input type="text" class="datetimepicker3 input_date type input-sm input_ser" readonly name="date_end" value="{$endTime | date='Y-m-d ',###}"  style="height:30px;border:1px solid #d2d6de;border-radius: 0px;vertical-align：middle;font-size:14px;"/>
                                                    </span>
                                                    <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入订单编号搜索..." style="width:157px;"/>
                                                    <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -6px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
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
                                <th class="text-center">订单编号</th>
                                <th class="text-center">买家</th>
                                <th class="text-center">买家联系电话</th>
                                <th class="text-center">商品名称</th>
                                <!-- <th class="text-center">商品信息</th> -->
                                <th class="text-center">商品单价</th>
                                <th class="text-center">订单总价</th>
                                <th class="text-center">商品数量</th>
                                <!-- <th class="text-center">运费</th> -->
                                
                                <th class="text-center">支付方式</th>
                                <th class="text-center">订单状态</th>
                                <th class="text-center">下单时间</th>
                                <th class="text-center">操作</th>
                            </tr>
                        </thead>
                            
                        <tbody class="text-center">
                            <if condition="$data">
                                <volist name="data" id="item">
                                    <tr>
                                        <td>{$i}</td>
                                        <td>{$item.order_sn}</td>
                                        <td>{$item.buyer_name}</td>
                                        <th class="text-center">{$item.buyer_phone}</th>
                                        <td>{$item.goods_name}</td>
                                        <!-- <td><a href="#" onclick="showSpec('{$item.order_id}')">查看规格</a></td> -->
                                        <td>{$item.goods_price}</td>
                                        <td>{$item.order_amount}</td>
                                        <td>{$item.goods_num}</td>
                                        <!-- <td>{$item.shipping_fee}</td> -->
                                        
                                        <switch name="item.payment_type">
                                            <case value="0">
                                                <td>
                                                    <if condition="$item.number gt '0'">
                                                        <a href="javascript:ok({$item.order_id});" class="btn btn-xs btn-warning">微信分单</a>
                                                    <else/>
                                                        未支付
                                                    </if>
                                                </td>
                                            </case>
                                            <case value="1">
                                                <td>
                                                    <if condition="$item.number gt '0'">
                                                        <a href="javascript:ok({$item.order_id});" class="btn btn-xs btn-warning">微信分单</a>
                                                    <else/>
                                                        微信支付
                                                    </if>
                                                </td>
                                            </case>
                                            <case value="2"><td>线下POS机</td></case>
                                            <case value="3"><td>转账</td></case>
                                            
                                        </switch>
                                        <switch name="item.order_state">
                                            <case value="10"><td><b style="color:red">待付款</b></td></case>
                                            <default/><td><b style="color:green">已付款</b></td>
                                        </switch>
                                        <td>{$item['add_time']|date='Y-m-d H:i:s',###}</td>
                                        <td style="text-align:left;">
                                        	<a href="{:U('Order/view')}?order_id={$item.order_id}" class="btn btn-xs btn-info">查看</a>
                                        	<if condition="$item.order_state eq '10'"><a href="javascript:oks('{$item.order_id}');" class="btn btn-xs btn-warning">确认支付</a></if>
                                        	
                                            
                                            <!--add by zhang 身份大于5的才有发货的按钮
                                            <if condition="$item['goods_ecommend'] gt 6">
                                                <switch name="item.order_state">
                                                
                                                    <case value="20">
                                                        <a href="{:U('Order/ship')}?order_id={$item.order_id}"  class="btn btn-xs btn-success">设置发货</a>
                                                    </case>
                                                    <case value="30">
                                                        <a href="{:U('Order/expressinfo')}?order_id={$item.order_id}" class="btn btn-xs btn-info">查看物流</a>
                                                    </case>
                                                    
                                                </switch>
                                            </if>-->
                                            
                                            <!--end by zhang-->
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
                            
            <div class="row">
                <div class="col-sm-5">
                    <div class="dataTables_info">
                        <php>if(!empty($count)){</php>
                        <span>共有<code>{$count}</code>条记录</span>
                        <php>}</php>
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
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</block>
<block name="js">
    <!-- DataTables -->
    <script src="__Assert__/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="__Assert__/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script src="http://apps.bdimg.com/libs/raphael/2.1.2/raphael-min.js"></script>
    <script src="__Assert__/plugins/morris/morris.min.js"></script>
<script>
    function ok(i){
        $.get("{:U('Order/orderinfo')}?order_id="+i, function (data) {
                art.dialog({content:data,
                    title: '分单明细',
                    lock: true,
                    width:400,
                });
                }, 'text');
    }

    function oks(i){
        var str = "<span>&nbsp;&nbsp;支付方式：</span><select name='type' class='types form-control input-sm' style='width: auto;'><option value='2'>POS机</option><option value='3'>微信转账</option></select>";
        art.dialog({
            content:str,
            title: '提示',
            lock: true,
            width:300,
            lock:true,
            cancel:function(){},
            ok:function(){
                var type = $('.types').val();
                $.post("{:U('Order/doOrder2')}",{order_id:i,types:type}, function (data, status) {
                    layer.msg(data);
                    setTimeout(function(){
                        window.location.reload();
                    },2000);
                    
                }, 'text');
            }
        });
    }
    //搜索
    // $(document).ready(function() {
    //     var dom = $("#window_main");
    //     //自动完成搜索
    //     dom.find(".input_ser").autocomplete({
    //         source: function (request, response) {
    //             var result = {
    //                 'searchtext': request.term,//搜索文本
    //             };
    //             $.getJSON("http://cy.laikeduo.com/index.php/Order/autoIndex", result, function (data) {
    //                 response(data);
    //             });
    //         }
    //     });
    // });

</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.datetimepicker3').datepicker({
            format: 'yyyy-mm-dd ',
            autoclose: true,
        });
        $('.datetimepicker2').datetimepicker({
            format: 'yyyy-mm-dd ',
        });
    });
    function showSpec(id) {
            $.post("{:U('Order/goodsinfo')}?goods_id=" + id, function (data, goods_state) {
                    layer.open({
                        type: 1,
                        title: '规格信息',
                        closeBtn: 2,
                        shade: 0.5,
                        content: data
                    });
                }, 'text');
        }
</script>

<script>
    //树状列表状态保持
    $(function(){ 
        $("#" + $.cookie('page')).addClass('active');
        
        if($.cookie('status')){
            $('body').attr('class',$.cookie('status'));
        } 
     });
    </script>
</block>