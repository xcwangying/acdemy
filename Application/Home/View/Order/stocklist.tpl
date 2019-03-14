<extend name="Public/base" />
<block name="css">
  <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css"></block>
<block name="content">
  <div class="content-wrapper">
    <section class="content-header">
      <h1>订单发货处理</h1>
      <ol class="breadcrumb">
        <li>管理后台</li>
        <li>商城管理</li>
        <li class="active">订单发货处理</li></ol>
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
                     <!--         <a aurl="{:U('Order/EinOrder')}" class="btn btn-sm btn-info EinOrder" >导入</a><a href="{:U('Order/ExpOrder')}" class="btn btn-sm btn-primary ExpOrder" style="margin-left:10px">导出</a><span style="color:#f00;font-weight:bold;font-size:16px;">(只能导出昨天订单)</span> -->
                     </label>
                     <label>
                             
                     </label>
                  </div>
                </div>
                <form class="searchform" method="get" >
                  <div class="col-sm-6">
                    <div class="dataTables_filter">
                      <label>
                        <div class="dataTables_filter">
                          <!-- 订单状态：
                          <select class="input_ser input-sm form-control ui-widget" name="order_status" style="width:100px;" >
                              <option value ='-1'>全部</option>
                            <option value="1">已处理</option>
                            <option value="0">未处理</option>
                          </select> -->
                          <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入客户名/电话/订单号搜索..." style="width:180px;" />
                          <button class="form-control btn btn-primary btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;">
                            <i class="fa fa-search"></i>
                          </button>
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
                        <th >序号</th>
                        <th>订单号</th>
                        <th>客户</th>
                        <th>手机号</th>
                        <th>收货人地址</th>
                        <th>订单状态</th>
                       
                        <th>订单支付时间</th>
                        <th>操作</th>
                    </thead>
                    <tbody>
                      <if condition="$data">
                        <volist name="data" id="item">
                          <tr>
                            <th>{$i}</th>
                            <th title="{$item.order_no}"><a aurl="{:U('Order/orderDetail')}?order_id={$item.order_id}" class="btn btn-xs  orderdetial">{$item.order_no}</a></th>
                            <th title="{$item.customer_name}">
                            <a href='javascript:void(0)' onclick='subgo("{$item['customer_id']}")'>
                                {$item.customer_name}
                            <a/>
                          </th>
                            <th title="{$item.customer_tel}">{$item.customer_tel}</th>
                            <th > 
                                 {$item.province}{$item.city}{$item.area}{$item.detailed}({$item.name}:{$item.phone})
                              
                             </th>
                           <th title="{$item.order_status}">
                                <switch name="item['sh_style']">
                                <case value="0">
                                    <switch name="item.order_status">
                                        <case value="1"><span class='btn btn-danger btn-xs'>待取货</span></case>
                                        <case value="2"><span class='btn btn-info btn-xs'>待取货</span></case>
                                        <case value="3"><span class='btn btn-success btn-xs'>已收货</span></case>
                                        <case value="4"><span class='btn btn-danger btn-xs'>待成团</span></case>
                                        <case value="5"><span class='btn btn-success btn-xs'>已评论</span></case>
                                        <default />
                                    </switch>
                                </case>
                                <case value="1">
                                    <switch name="item.order_status">
                                        <case value="1"><span class='btn btn-danger btn-xs'>未发货</span></case>
                                        <case value="2"><span class='btn btn-info btn-xs'>已发货</span></case>
                                        <case value="3"><span class='btn btn-success btn-xs'>已收货</span></case>
                                         <case value="4"><span class='btn btn-danger btn-xs'>待成团</span></case>
                                         <case value="5"><span class='btn btn-success btn-xs'>已评论</span></case>
                                          <case value="6"><span class='btn btn-danger btn-xs'>退款中</span></case>
                                           <case value="7"><span class='btn btn-danger btn-xs'>已退款</span></case>
                                        <default />
                                    </switch>
                                </case>
                                <case value="2">
                                    <switch name="item.order_status">
                                        <case value="1"><span class='btn btn-danger btn-xs'>待送货</span></case>
                                        <case value="2"><span class='btn btn-info btn-xs'>已送货</span></case>
                                        <case value="3"><span class='btn btn-success btn-xs'>已收货</span></case>
                                        <case value="4"><span class='btn btn-danger btn-xs'>待成团</span></case>
                                        <case value="5"><span class='btn btn-success btn-xs'>已评论</span></case>
                                        <default />
                                    </switch>
                                </case>
                                <default />
                              </switch>


                            
                             
                            </th>
                            
                            <th>{$item.order_pay_time|friendlyDate}</th>
                            <th>
                     

                            <if condition="$item.order_status eq 1 ">
                             <in name="item.shop_id" value="0,1,2,3"><a aurl="{:U('Order/exorderSend')}?order_id={$item.order_id}" class="btn btn-xs btn-info exorderSend">发货</a></in>
                           <!--   <a aurl="{:U('Order/exorderSend')}?order_id={$item.order_id}" class="btn btn-xs btn-info exorderSend">发货</a> -->
                              
                            </if>
                           <!--  <?php if($item['order_status']==1):?>
                              <span onclick="delivery('{$item.order_id}')" class="btn btn-xs btn-success">发货</span>
                            <?php else:?>
                              <span onclick="searchDelivery('{$item.order_id}')" class="btn btn-xs btn-success">查看物流</span>
                            <?php endif;?> -->

                           
                            </th>
                          </tr>
                        </volist>
                        <else />
                        <tr></tr>
                        <tr>
                          <td  class="text-center" class="into" colspan="10" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td></tr>
                      </if>
                    </tbody>
                  </table>
                </div>
              </div>
              <if condition="$data">
                <div class="row">
                  <div class="col-sm-5">
                    <div class="dataTables_info">
                      <span>共有
                        <code>{$count}</code>条记录</span></div>
                  </div>
                  <div class="col-sm-7">
                    <div class="dataTables_paginate paging_simple_numbers">
                      <ul class="pagination">{$page}</ul></div>
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

   function subgo(id){
        var url = "{:U('Customer/customerInfo')}";
        $.ajax({ 
            url:url,
            data:"customer_id="+id,
            type:'POST',
            dataType:'text',
            error: function(){
                art.dialog({
                    title:'提示',
                    content:'网络异常，请重试！',
                    lock:true
                });
            },
            success: function(res){
                art.dialog({
                    title:'用户信息',
                    content:res,
                    lock:true
                });
            }
        });
        return false;
    }


	  function delivery(order_id){
	      art.dialog({
	        title: '订单发货',
	        content: "<iframe src='' frameborder='0' name='lee_iframe' class='hidden'></iframe><form role='form' method='post' action='{:U(\'Shopping/deliveryOrder\')}' name='frm' class='form-horizontal form-seperated shequn validform  window_main' cleandata='#pro_tbody' target='lee_iframe'><input type='hidden' name='storage_type' value='1'><input type='text' class='form-control' datatype='*' nullmsg='请填写快递单号' placeholder='请填写快递单号(必填)' name='order_delivery_no'><select class='input_ser input-sm ui-widget' name='delivery_id' datatype='*' nullmsg='请选择快递公司' errormsg='请选择快递公司' style='margin-top:10px;'> <option value>请选择快递公司</option> <volist name='delivery' id='item'> <option value='{$item.delivery_id}'>{$item.delivery_name}</option></volist> </select><input type='hidden' name='order_id' value='"+order_id+"'><input type='hidden' name='jump' value='orderList'><p style='margin-top:10px;'><button type='submit' class=' btn btn-primary btn-sm '>提交</button></p></form>",
	        lock: true,
	        width: 500,
	      });
	  }

    $('.orderdetial').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '订单详情';
        $.ajax({
            url: aurl,
          
            type:'get',
            dataType:"text",
            error: function(){
                art.dialog('请求错误,请检查网络!');
            },
            success: function (res) {
                art.dialog({content:res,
                    title: atext,
                    lock: true,
                    width:330,
                });
            },
        });
        return false;
    })

    //导入订单信息
    
    $('.EinOrder').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '导入订单信息';
        $.ajax({
            url: aurl,
          
            type:'get',
            dataType:"text",
            error: function(){
                art.dialog('请求错误,请检查网络!');
            },
            success: function (res) {
                art.dialog({content:res,
                    title: atext,
                    lock: true,
                    width:330,
                });
            },
        });
        return false;
    })
    //
     $('.exorderSend').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '订单发货';
        $.ajax({
            url: aurl,
          
            type:'get',
            dataType:"text",
            error: function(){
                art.dialog('请求错误,请检查网络!');
            },
            success: function (res) {
                art.dialog({content:res,
                    title: atext,
                    lock: true,
                    width:330,
                });
            },
        });
        return false;
    })

    
   
  </script>




</block>