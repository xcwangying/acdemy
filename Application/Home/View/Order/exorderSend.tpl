
<table class='table table-hover1  table-bordered  tablesorter' style='text-align: center'>
        <tbody>
         <tr style='background-color:#efefef;'><td nowrap='nowrap' style='text-align: center'><b>订单号</b></td><td nowrap='nowrap'><b>下单时间</b></td><td nowrap='nowrap'><b>收件人</b></td><td nowrap='nowrap'><b>手机号</b></td><td nowrap='nowrap' colspan="4"><b>收货地址</b></td></tr>
          <tr style='height:50px;'>
              <td nowrap='nowrap'>{$orderinfo.order_no}</td>
              <td nowrap='nowrap'>{$orderinfo.order_pay_time|date='Y-m-d H:i:s',###}</td>
              <td nowrap='nowrap'>{$orderinfo.name}</td>
              <td nowrap='nowrap'>{$orderinfo.phone}</td>
              <td nowrap='nowrap' colspan="4">{$orderinfo.province}{$orderinfo.city}{$orderinfo.area}{$orderinfo.detailed}</td>
               
        </tr>

          <tr style='background-color:#efefef;'><td nowrap='nowrap'><b>序号</b></td><td nowrap='nowrap'><b>商品名称</b></td><td nowrap='nowrap'><b>型号</b></td><td nowrap='nowrap'><b>颜色</b></td><td nowrap='nowrap'><b>规格</b></td><td nowrap='nowrap'><b>单价</b></td><td nowrap='nowrap'><b>数量</b></td><td nowrap='nowrap'><b>小计</b></td></tr>
        <if condition="$orderdetial neq ''">
            <volist name="orderdetial" id="item">
                <tr><td nowrap='nowrap'><b>{$i}</b></td><td nowrap='nowrap'>{$item.c_name}</td><td nowrap='nowrap'>{$item.model_name}</td><td nowrap='nowrap'>{$item.color_name}</td><td nowrap='nowrap'>{$item.spec_name}</td><td nowrap='nowrap'>{$item.detail_price}</td><td nowrap='nowrap'>{$item.detail_snum}</td><td nowrap='nowrap'>{$item['detail_snum']*$item['detail_price']|sprintf='%.2f',### }</td></tr>
            </volist>
        </if>
          
          
        </tbody>
</table>
      <div style="float:none">
            <div style="float:left">
              <label>
                 快递公司：<span style="color: #FF0000;">*</span>
                 <select class="form-control" name="delivery_id"  id="delivery_id" style="width:100%">
                  <volist name="devlist" id="item" >
                     <option value="{$item.delivery_id}">{$item.delivery_name}</option>
                  </volist>
              </select>
              </label>
           </div>
           <div style="float:left;">
              <label>
                 快递单号：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="delivery_no" id="delivery_no" style="width:100%">
                 
              </label>
           </div>
           <div style="clear:both;text-align:center">
               <input type='button' id='tj' value='处理' class="btn btn-lm btn-primary" style='text-align:center;float: center'/>
           </div>
              <input type='hidden' value="{$orderinfo.order_id}" id = 'order_id'/>
              <input type='hidden' value="{$orderinfo.order_no}" id = 'order_no'/>
            
      
      </div>
 


<block name="js">
  <script type="text/javascript"> 
  $('#tj').click(function(){ 
     var order_id = $('#order_id').val();
      var delivery_no = $('#delivery_no').val();
      var delivery_id = $('#delivery_id').val();
      var order_no = $('#order_no').val();
      art.dialog({
            icon:'question',
            title:'确定',
            content:'确定要处理'+order_no+'订单吗？',
            okVal:'确定',
            cancel:true,
            cancelVal:'取消',
            ok:function(){
                $.ajax({ 
                    url:"{:U('Order/doExorderSend')}",
                    data:{'order_id':order_id,'delivery_id':delivery_id,'delivery_no':delivery_no,'order_no':order_no},
                    dataType:'json',
                    type:'post',
                    error: function(){
                        art.dialog('请求错误,请检查网络！');
                    },
                    success: function(result){
                        if(result.status==1){
                            art.dialog({
                                content:result.msg,
                                lock:true,
                                time:1000
                            });
                            window.setTimeout(window.location=window.location.href,2000);
                        }
                        else
                        { 
                            art.dialog({
                                content:result.msg,
                                lock:true
                            });
                            window.setTimeout(window.location=window.location.href,2000);
                        }
                    }
                });
            }
        });
        return false;
  })
 
  </script>
</block>





