<extend name="Public/base"/>
<block name="content">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                设置发货
                <small>Set up shipments</small>
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>订单管理</li>
                <li class="active">设置发货</li>
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

                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                    <div class="col-md-6">
                                        <div style="float:left;line-height: 34px;">
                                           <label>物流公司：</label>
                                        </div>
                                        <div class="col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" value="" name="express_name" placeholder="(必填)">
                                            <input type="hidden" value="{$order_info.order_id}" name="order_id">
                                        </div>
                                    </div>

                                     <div class="col-md-6">
                                        <div style="float:left;line-height: 34px;">
                                            <label>物流单号：</label>
                                        </div>
                                        <div class="col-sm-10 col-md-10">
                                            <input type="text" class="form-control" value="" name="express_no" placeholder="(必填)">
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <a class="btn btn-info" id="refer">提交</a>      
                            <a href="{:U('Order/index')}" class="btn btn-info">返回</a>
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

<block name="js">
    <!-- DataTables -->
    <script type="text/javascript" src="__Assert__/js/Validform_v5.3.2_min.js"></script>
    <script src="http://apps.bdimg.com/libs/raphael/2.1.2/raphael-min.js"></script>
    <script src="__Assert__/plugins/morris/morris.min.js"></script>

<script type="text/javascript">
    //防止重复提交
    var tijiao=false;
    $(document).on('click','#refer',function(){
        if(tijiao){
            return false;
        }
        tijiao=true;

        var order_id=$("input[name=order_id]").val();

        var express_name=$("input[name=express_name]").val();
        if(express_name==''){
            alert('物流公司不能为空');
            return false;
        }

        var express_no=$("input[name=express_no]").val();
        if(express_no==''){
            alert('物流单号不能为空');
            return false;
        }

        //提交数据
        $.ajax({
            type: "post",
            data:{express_name:express_name,express_no:express_no,order_id:order_id},
            url: "{:U('Order/ajaxship')}",
            dataType: "json",
            success: function(re) { 
                if(re.status==1){
                    tijiao=true;
                    //成功
                    alert('设置发货成功');
                    //跳转到成功提醒页面
                    window.location.href="{:U('Order/index?payStatus=3')}";
                    return false;
                }
                if(re.status==0){
                    tijiao=false;
                    alert('设置发货失败');
                    return false;
                }
            }
        });
    })
</script>

</block>