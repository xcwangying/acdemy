<extend name="Public/base"/>
<block name="content">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                订单详情
                <small>Order details</small>
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>订单管理</li>
                <li class="active">订单详情</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class=""  style="width:90%;margin-left:15px;padding-right:0px;">
                    <div class="box box-primary">
                        <div class="box-body" style="padding-left:3px;">
                            <div class="form-group">
                            	<div class="row clearfix" style="margin-left:-5px;">
                                	<div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">	
                                            <label style="margin-right:8px;">订  单  号：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8" >
                                            <input type="text" class="form-control"  value="{$order_info.order_sn}" readonly>
                                        </div>     
                                    </div>

                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">
                                            <label>买家名称：</label>
                                        </div>         
                                        <div class="col-sm-8 col-md-8" >
                                            <input type="text" class="form-control"  value="{$order_info.buyer_name}" readonly>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">
                                            <label>下单时间：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control"  value="{$order_info['add_time']|date='Y-m-d H:i:s',###}" readonly>
                                        </div>
                                    </div>
                                </div>  
                            </div>
               
                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">
                                            <label>支付状态：</label>
                                        </div>
            	                        <div class="col-sm-8 col-md-8">
                                            <if condition="$order_info['payment_type'] eq '0'">
                                                <input type="text" class="form-control"  value="未支付" readonly>
                                            <else/>
                                                <input type="text" class="form-control" value="已支付" readonly>
                                            </if>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <if condition="$order_info['payment_time'] neq '0'">
                                            <div style="float:left;line-height: 34px;">
                                                <label>支付方式：</label>
                                            </div>
                                            <div class="col-sm-8 col-md-8" >
                                                <if condition="$order_info['payment_type'] eq '1'">
                                                    <input type="text" class="form-control"  value="微信支付" readonly>
                                                <elseif condition="$order_info['payment_type'] eq '2'"/>
                                                    <input type="text" class="form-control" value="银联支付" readonly>
                                                <elseif condition="$order_info['payment_type'] eq '3'"/>
                                                    <input type="text" class="form-control" value="积分抵扣" readonly>
                                                <elseif condition="$order_info['payment_type'] eq '4'"/>
                                                    <input type="text" class="form-control" value="余额支付" readonly>
                                                </if>
                                            </div>
                                        <elseif condition="$order_info['order_state'] eq '10'"/>
                                        	<div style="float:left;line-height: 34px;">    
                                                <label><a onclick="if(confirm('确认取消订单吗？'))return true;else return false;" href="{:U('Order/cancel_order')}?order_id={$Think.get.order_id}" class="btn btn-info">取消订单</a>
                                                </label>
                                            </div>
                                        <else/ >
                                            
                                        </if> 
                                    </div>

                                    <div class="col-md-4">
                                        <if condition="$order_info['payment_time'] neq '0'">
                                            <div style="float:left;line-height: 34px;">
                                                <label>支付时间：</label>
                                            </div>
                                            <div class="col-sm-8 col-md-8" >
                                                <input type="text" class="form-control" value="{$order_info['payment_time']|date='Y-m-d H:i:s',###}" readonly>
                                            </div>
                                        </if> 
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                	<div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">	   
                                            <label>应付金额：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control" value="{$order_info.order_amount}" readonly>
                                        </div>
                                    </div>
                                 
                                    <div class="col-md-4">
                                        <if condition="$order_info['payment_time'] neq '0'">
                                            <div style="float:left;line-height: 34px;">	
                                                <label>实付金额：</label>
                                            </div>
                                            <div class="col-sm-8 col-md-8"> 
                                                <input type="text" class="form-control"  value="{$order_info['order_amount']-$order_info['rcb_amount']-$order_info['pd_amount']}" readonly>
                                            </div> 
                                        </if>  
                                    </div>
                                 
                                    <div class="col-md-4">
          
                                    </div>
                                </div>
                            </div>

                            <if condition="$order_info['payment_time'] neq '0'">
                                <div class="form-group">
                                    <div class="row clearfix" style="margin-left:-5px;">
                                        <div class="col-md-4">
                                            <div style="float:left;line-height: 34px;">    
                                                <label>订单状态：</label>
                                            </div>
                                            <div class="col-sm-8 col-md-8">
                                                <if condition="$order_info['order_state'] eq '20'">
                                                    <input type="text" class="form-control"  value="待发货" readonly>
                                                <elseif condition="$order_info['order_state'] eq '30'"/>
                                                    <input type="text" class="form-control"  value="已发货" readonly>
                                                <elseif condition="$order_info['order_state'] eq '40'"/>
                                                    <input type="text" class="form-control"  value="已收货" readonly>
                                                <elseif condition="$order_info['order_state'] eq '50'"/>
                                                    <input type="text" class="form-control"  value="已完成" readonly>
                                                <elseif condition="$order_info['order_state'] eq '60'"/>
                                                    <input type="text" class="form-control"  value="已退款" readonly>
                                                </if>
                                            </div>
                                        </div>
                                     
                                        <div class="col-md-4">
                                            <if condition="$order_info['shipping_time'] neq '0'">
                                                <div style="float:left;line-height: 34px;"> 
                                                    <label>发货时间：</label>
                                                </div>
                                                <div class="col-sm-8 col-md-8"> 
                                                    <input type="text" class="form-control"  value="{$order_info['shipping_time']|date='Y-m-d H:i:s',###}" readonly>
                                                </div>
                                            <elseif condition="$order_info['order_state'] eq '50'"/>
                                                <label><a href="{:U('Order/evaluation')}?order_id={$order_info.order_id}" class="btn btn-info">订单评价</a></label>
                                            <elseif condition="$order_info['order_state'] eq '60'"/>
                                            <else/ >
                                                <div style="float:left;line-height: 34px;">    
                                                    <label><a href="{:U('Order/ship')}?order_id={$order_info.order_id}" class="btn btn-info">设置发货</a></label>
                                                </div>
                                            </if>  
                                        </div>
                                     
                                    </div>
                                </div>
                                
                                <if condition="$order_info['express_id'] neq '0'">
                                    <div class="form-group">
                                        <div class="row clearfix" style="margin-left:-5px;">
                                            <div class="col-md-4">
                                                <div style="float:left;line-height: 34px;">    
                                                    <label>物流公司：</label>
                                                </div>
                                                <div class="col-sm-8 col-md-8">
                                                    <input type="text" class="form-control"  value="{$order_info.express_name}" readonly>
                                                </div>
                                            </div>
                                         
                                            <div class="col-md-4">
                                                <div style="float:left;line-height: 34px;">    
                                                    <label>物流单号：</label>
                                                </div>
                                                <div class="col-sm-8 col-md-8">
                                                    <input type="text" class="form-control" value="{$order_info.express_no}" readonly>
                                                </div>
                                            </div>
                                         
                                            <div class="col-md-4">
                                                <div style="float:left;line-height: 34px;">    
                                                    <label><a href="{:U('Order/expressinfo')}?order_id={$order_info.order_id}" class="btn btn-info">查看物流</a></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </if>
                            </if> 
                            
                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;"> 
                                            <label style="margin-right:8px;">收 货 人：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8" >
                                            <input type="text" class="form-control"  value="{$order_info.reciver_name}" readonly>
                                        </div>
                                    </div>
                                 
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">    
                                            <label>收货人电话：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control"  value="{$order_info.reciver_telphone}" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                    <div class="col-md-6">
                                        <div style="float:left;line-height: 34px;">
                                            <label>配送地址：</label>
                                        </div>
                                        <div class="col-sm-10 col-md-10">
                                            <input type="text" class="form-control"  value="{$order_info.reciver_info}" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                            	<div class="row clearfix" style="margin-left:-5px;">
                                	<div class="col-md-6">
                                        <div style="float:left;line-height: 34px;">
                                           <label>买家留言：</label>
                                        </div>
                                        <div class="col-sm-10 col-md-10"> 
                                            <if condition="$order_info['order_message'] eq ''">
                                                <input type="text" class="form-control"  value="无" readonly>
                                            <else />
                                                <input type="text" class="form-control"  value="{$order_info.order_message}" readonly>
                                            </if>
                                        </div>
                                    </div>
                                   
                         <!--            <div class="col-md-6">
                                        <div style="float:left;line-height: 34px;">
                                            <label>配送地址：</label>
                                        </div>
                                        <div class="col-sm-10 col-md-10">
                                            <if condition="$data2['type'] eq '1'">
                                                <input type="text" class="form-control"  value="现取" readonly>
                                                <elseif condition="$data2['type'] eq '2'"/>
                                                <input type="text" class="form-control"  value="延时自取" readonly>
                                                <else/>
                                                <input type="text" class="form-control"  value="{$data2.address}" readonly>
                                            </if>
                                        </div>
                                    </div> -->
                                </div>
                            </div>
              
                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="example1" class="table table-bordered table-striped table-hover" style="width:99.5%">
                                        <thead>
                                            <tr>
                                                <th class="text-center">商品名称</th>
                                                <th class="text-center">数量</th>
                                                <th class="text-center">单价</th>
                                                <th class="text-center">运费</th>
                                                <th class="text-center">订单金额</th>
                                                <th class="text-center">积分抵扣</th>
                                                <th class="text-center">预存款支付</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <tr>
                                                <td>{$order_info.goods_name}</td>
                                                <td>{$order_info.goods_num}</td>
                                                <td>{$order_info.goods_price}</td>
                                                <if condition="$order_info.shipping_fee eq '0'">
                                                <td>免邮</td>
                                                <else />
                                                <td>{$order_info.shipping_fee}</td>
                                                </if>
                                                <td>{$order_info.order_amount}</td>
                                                <td>{$order_info.rcb_amount}</td>
                                                <td>{$order_info.pd_amount}</td>
                                            </tr>
                                        </tbody>
                                    </table>        
                                </div>
                            </div>         
                            <a href="#" class="btn btn-info" onClick="javascript :history.back(-1);">返回</a>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!--/.col (left) -->
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</block>