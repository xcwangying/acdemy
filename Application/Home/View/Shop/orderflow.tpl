<extend name="Public/base" />
<block name="css">
  <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css"></block>
<block name="content">
  <div class="content-wrapper">
    <section class="content-header">
      <h1>红包流水</h1>
      <ol class="breadcrumb">
        <li>管理后台</li>
        <li>门店管理</li>
        <li class="active">红包流水</li></ol>
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
                   
                     </label>
                  </div>
                </div>
                <form class="searchform" method="get" >
                  <div class="col-sm-6">
                    <div class="dataTables_filter">
                      <label>
                        <div class="dataTables_filter">
                          
                         
                          <span class="sta_other">
                      <input type="text" class="datetimepicker3" readonly name="date_begin" value="{$date_begin}" id="date_begin"/>&nbsp;&nbsp;至
                      <input type="text" class="datetimepicker3" readonly name="date_end" value="{$date_end}" id="date_end"/>
                      </span>
                          <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入客户名称/订单号搜索..." style="width:157px;" />
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
                        <th class="text-center">序号</th>
                        <th class="text-center">订单号</th>
                        <th class="text-center">订单金额</th>
                        <th class="text-center">现金红包</th>
                        <th class="text-center">满减卷</th>
                        <th class="text-center">优惠券</th>
                        <th class="text-center">实收</th>
                        <th class="text-center">介绍奖</th>
                        <th class="text-center">团队奖</th>
                        <th class="text-center">微信手续费</th>
                        <th class="text-center">处理订单</th>
                        <th class="text-center">发放时间</th>
                    </thead>
                    <tbody class="text-center">
                      <if condition="$data">
                        <volist name="data" id="item">
                          <tr>
                            <th class="text-center">{$i}</th>
                            <th title="{$item.order_no}"><a aurl="{:U('Order/orderDetail')}?order_id={$item.order_id}" class="btn btn-xs  orderdetial">{$item.order_no}</a></th>
                      
                            <th class="text-center" title="{$item.customer_name}">{$item.order_money}</th>
                            <th class="text-center" title="{$item.customer_name}">{$item.cash_money}</th>
                            <th class="text-center" title="{$item.customer_tel}">{$item.mj_money}</th>
                            <th class="text-center" title="{$item.customer_tel}">{$item.yhj_money}</th>
                            <th class="text-center" title="{$item.customer_tel}">{$item.order_fact}</th>
                            <th class="text-center" >
                                <if condition="$item.intro_money neq 0 ">
                                    <a href='javascript:void(0)' onclick='subgo("{$item['intro_id']}")'>
                                    {$item.intro_money}
                                    <a/>
                              <else/>
                                {$item.intro_money}
                              </if>
                            </th>
                            <th class="text-center" >
                                <if condition="$item.team_money neq 0 ">
                                    <a href='javascript:void(0)' onclick='subgo("{$item['team_id']}")'>
                                    {$item.team_money}
                                    <a/>
                              <else/>
                                {$item.team_money}
                              </if>
                            </th>
                            <th class="text-center" title="{$item.customer_tel}">{$item.charge}</th>
                            <th class="text-center" >
                                <if condition="$item.shop_money neq 0 ">
                                    <a href='javascript:void(0)' onclick='subgoshop("{$item['shop_id']}")'>
                                    {$item.shop_money}
                                    <a/>
                              <else/>
                                {$item.shop_money}
                              </if>
                            </th>
                            <th class="text-center">{$item.add_time|friendlyDate}</th>
                            <th class="text-center">
                         <!--    <a aurl="{:U('Customer/orderDetail')}?order_id={$item.order_id}" class="btn btn-xs btn-primary orderdetial">查看详情</a>
                            <a aurl="{:U('Customer/shorderlist')}?order_id={$item.order_id}&orderno={{$item.order_no}}" class="btn btn-xs btn-warning sh">核实订单</a>
                            </th> -->
                          </tr>
                        </volist>
                        <else />
                        <tr></tr>
                        <tr>
                          <td class="into" colspan="15" style="vertical-align:middle;font-size:30px;" height="200">暂无订单信息</td></tr>
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
    $(".datetimepicker3").on("click",function(e){
            e.stopPropagation();
            $(this).lqdatetimepicker({
                css : 'datetime-day',
                dateType : 'D',
                selectback : function(){

                }
            });
        });
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

    function subgoshop(id){
        var url = "{:U('Shop/shopinfo')}";
        $.ajax({ 
            url:url,
            data:"shop_id="+id,
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
                    title:'门店信息',
                    content:res,
                    lock:true
                });
            }
        });
        return false;
    }

    //
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
                    width:600,
                });
            },
        });
        return false;
    })

   
  </script>




</block>