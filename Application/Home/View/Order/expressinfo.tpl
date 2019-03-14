<extend name="Public/base"/>
<block name="content">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                查看物流
                <small>View Logistics</small>
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>订单管理</li>
                <li class="active">查看物流</li>
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
                                            <input type="text" class="form-control"  value="{$order_common_info.order_sn}" readonly>
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
                                            <input type="text" class="form-control"  value="{$order_common_info.reciver_name}" readonly>
                                        </div>
                                    </div>
                                 
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">    
                                            <label>收货人电话：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control"  value="{$order_common_info.reciver_telphone}" readonly>
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
                                            <input type="text" class="form-control"  value="{$order_common_info.reciver_info}" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row clearfix" style="margin-left:-5px;">
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">    
                                            <label>物流公司：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control"  value="{$order_common_info.express_name}" readonly>
                                        </div>
                                    </div>
                                 
                                    <div class="col-md-4">
                                        <div style="float:left;line-height: 34px;">    
                                            <label>物流单号：</label>
                                        </div>
                                        <div class="col-sm-8 col-md-8">
                                            <input type="text" class="form-control" value="{$order_common_info.express_no}" readonly>
                                        </div>
                                    </div>
                                 
                                    <div class="col-md-4">
                                    </div>
                                </div>
                            </div>
              
                            <div class="row">
                                <div class="col-sm-12">
                                    <div style="margin-bottom:10px;margin-left:45px;color:red;">物流信息由快递100提供</div>
                                    <if condition="$order_common_info['expressinfo'] neq ''">
                                        <div style="margin-left:50px;">{$order_common_info.expressinfo}</div>
                                    <else/ >
                                        <div style="margin-left:100px;">暂无物流信息</div>
                                    </if>
                                </div>
                            </div>  
                            <div style="margin-top:10px;"></div>          
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