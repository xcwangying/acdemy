<extend name="Public/base" />
<block name="css">
  <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css"></block>
<block name="content">
  <div class="content-wrapper">
    <section class="content-header">
      <h1>秒杀兑换列表</h1>
      <ol class="breadcrumb">
        <li>管理后台</li>
        <li>秒杀兑换管理</li>
        <li class="active">秒杀兑换列表</li></ol>
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
                        
                          <select class="input_ser input-sm form-control ui-widget" name="order_status" style="width:150px;" >
                              <option value ='-1' <eq name="order_status" value="-1">selected</eq>>请选择状态</option>
                            <option value="1" <eq name="order_status" value="1">selected</eq>>未发货</option>
                            <option value="2" <eq name="order_status" value="2">selected</eq>>已发货</option>
                            <option value="3" <eq name="order_status" value="3">selected</eq>>已收货</option>
                          </select>
                          <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入客户名/电话/订单号搜索..." style="width:190px;" />
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
                        <th>订单总金额</th>
                     
                        <th>券数量</th>
                       
                        <th>订单支付时间</th>
                        <th>操作</th>
                    </thead>
                    <tbody>
                      <if condition="$data">
                        <volist name="data" id="item">
                          <tr>
                            <th>{$i}</th>
                            <th title="{$item.order_no}"><a aurl="{:U('Order/orderDetail')}?order_id={$item.order_id}" class="btn btn-xs  orderdetial">{$item.order_no}</a></th>
                            <th >
                            <a href='javascript:void(0)' onclick='subgo("{$item['vip_id']}")'>
                                {$item.vip_name}
                            <a/>
                          </th>
                            <th title="{$item.vip_tel}">{$item.vip_tel}</th>
                            <th > 
                                 {$item.province}{$item.city}{$item.area}{$item.detailed}({$item.name}:{$item.phone})
                              
                             </th>
                              <th title="{$item.order_status}">
                                <switch name="item.order_status">
                                    <case value="1"><span class='btn btn-danger btn-xs'>未发货</span></case>
                                    <case value="2"><span class='btn btn-info btn-xs'>已发货</span></case>
                                    <case value="3"><span class='btn btn-success btn-xs'>已收货</span></case>
                                     <case value="4"><span class='btn btn-danger btn-xs'>待成团</span></case>
                                     <case value="5"><span class='btn btn-success btn-xs'>已评论</span></case>
                                      <case value="6"><span class='btn btn-danger btn-xs'>退货中</span></case>
                                       <case value="7"><span class='btn btn-danger btn-xs'>已退货</span></case>
                                    <default />
                                </switch>
                            </th>
                            
                            <th>{$item.order_fact}</th>
                            <th>{$item.cou_num}</th>
                       
                            <th>{$item.pay_time|friendlyDate}</th>
                          
                            <th>
                   
                              <if condition="$item.addrid eq 0 ">
                                  <a aurl="{:U('Order/addInfo')}?order_id={$item.order_id}" class="btn btn-xs btn-danger addInfo">添加地址</a>
                              </if>
                          
                            <a aurl="{:U('Order/edtitInfo')}?order_id={$item.order_id}" class="btn btn-xs btn-info edtitInfo">修改地址</a>
                            <a aurl="{:U('Order/addRemark')}?order_id={$item.order_id}" class="btn btn-xs btn-warning addRemark">添加备注</a>
                            <a aurl="{:U('Order/doRefundGood')}?order_id={$item.order_id}" data ="{$item.order_no}" class="btn btn-xs btn-danger doRefundGood">退货</a>
                            <if condition="$item.order_status eq 2 ">
                                  <a aurl="{:U('Order/doOrderFinish')}?order_id={$item.order_id}" data ="{$item.order_no}" class="btn btn-xs btn-success doOrderFinish">确认收货</a>
                            </if>
                            </th>
                          </tr>
                        </volist>
                        <else />
                        <tr></tr>
                        <tr>
                          <td  class="text-center" class="into" colspan="20" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td></tr>
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
        var url = "{:U('VipManager/vipInfo')}";
        $.ajax({ 
            url:url,
            data:"vip_id="+id,
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

   
	$(document).on('click','.doOrderFinish',function() {
        var url = $(this).attr('aurl');
        var order_no = $(this).attr('data');
        art.dialog({
            icon:'question',
            title:'确定',
            content:'确定订单'+order_no+'确认收货吗？',
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
                    success:function(re){
                        if(re.status == 1){
                            art.dialog({
                                content:re.msg,
                            });
                            window.setTimeout(window.location=window.location.href,2000);
                        }else{
                            art.dialog({
                              content:re.msg,
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                           window.setTimeout(window.location=window.location.href,2000);
                        }
                    }
                });
            }
        });
        return false;
    });

    $(document).on('click','.doRefundGood',function() {
        var url = $(this).attr('aurl');
        var order_no = $(this).attr('data');
        art.dialog({
            icon:'question',
            title:'确定',
            content:'确定订单'+order_no+'退货吗？',
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
                    success:function(re){
                        if(re.status == 1){
                            art.dialog({
                                content:re.msg,
                            });
                            window.setTimeout(window.location=window.location.href,2000);
                        }else{
                            art.dialog({
                              content:re.msg,
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                           window.setTimeout(window.location=window.location.href,2000);
                        }
                    }
                });
            }
        });
        return false;
    });

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

    //添加地址
    
    $('.addInfo').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '添加地址';
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

    //修改地址
    $('.edtitInfo').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '修改地址';
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
      $('.addRemark').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '添加备注';
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

     //订单指派 
      $('.orderAssign').click(function () {
        var aurl = $(this).attr('aurl');
        var atext = '订单指派';
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