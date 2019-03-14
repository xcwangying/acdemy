<extend name="Public/base" />
<block name="css">
  <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css"></block>
<block name="content">
  <div class="content-wrapper">
    <section class="content-header">
      <h1><span style="color:#f00">{$shop_name}——</span>财务报表</h1>
      <ol class="breadcrumb">
        <li>管理后台</li>
        <li>门店管理</li>
        <li class="active">财务报表</li></ol>
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
                        <th class="text-center">日期</th>
                        <volist name='userlist' id="vo">
                            <th class="text-center">{$vo.customer_name}</th>
                        </volist>
                        
      
                    </thead>
                    <tbody class="text-center">
                      <if condition="$list">
                        <volist name="list" id="item">
                          <tr>
                            <th class="text-center">{$item.date}</th>
                            <volist name ="item.list" id="vo"> 
                              <if condition="$vo.customer_id eq 0">
                                  <th class="text-center" ><a href="{:U('Shop/orderflow')}?date_begin={$item.date}" >{$vo.report_money}</a></th>
                              <else/>
                                <th class="text-center" ><a href="{:U('Shop/orderflow')}?customer_id={$vo.customer_id}&date_begin={$item.date}" >{$vo.report_money}</a></th>
                              </if>
                            </volist>
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
	  function delivery(order_id){
	      art.dialog({
	        title: '定单发货',
	        content: "<iframe src='' frameborder='0' name='lee_iframe' class='hidden'></iframe><form role='form' method='post' action='{:U(\'PSS/deliveryOrder\')}' name='frm' class='form-horizontal form-seperated shequn validform  window_main' cleandata='#pro_tbody' target='lee_iframe'><input type='hidden' name='storage_type' value='1'><input type='text' class='form-control' datatype='*' nullmsg='请填写快递单号' placeholder='请填写快递单号(必填)' name='order_delivery_no'><input type='number' step='0.01' class='form-control' datatype='*' nullmsg='请填写运费' placeholder='请填写运费(必填)' name='order_delivery_price'><select class='input_ser input-sm ui-widget' name='delivery_id' datatype='*' nullmsg='请选择快递公司' errormsg='请选择快递公司'> <option value>请选择快递公司</option> <volist name='delivery' id='item'> <option value='{$item.delivery_id}'>{$item.delivery_name}</option></volist> </select><input type='hidden' name='order_id' value='"+order_id+"'><input type='hidden' name='jump' value='orderList'><button type='submit' class='btn btn-primary'>提交</button></form>",
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
                    width:600,
                });
            },
        });
        return false;
    })

    $(document).on('click','.sh',function() {
        var url = $(this).attr('aurl');
        var custoemr_name = $(this).attr('data');
        art.dialog({
            icon:'question',
            title:'确定',
            content:'确定审核通过吗？',
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
                                content:re.info,
                            });
                            window.setTimeout(window.location="{:U('Customer/orderlist')}",2000);
                        }else{
                            art.dialog({
                              content:re.info,
                            });
                            sub.attr('sub',sub.val());
                            sub.val('提交');
                            sub.attr('disabled',false);
                            window.setTimeout(window.location="{:U('Customer/orderlist')}",2000);
                        }
                    }
                });
            }
        });
        return false;
    });
  </script>




</block>