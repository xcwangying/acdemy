
<table class='table table-hover1  table-bordered  tablesorter'>
        <tbody>
         <tr style='background-color:#efefef;'><td nowrap='nowrap'><b>订单号</b></td><td nowrap='nowrap'><b>下单时间</b></td><td nowrap='nowrap'><b>客户名称</b></td><td nowrap='nowrap'><b>手机号</b></td><td nowrap='nowrap'><b>配送方式</b></td><td nowrap='nowrap' colspan="3"><b>地址</b></td></tr>
          <tr style='height:50px;'>
              <td nowrap='nowrap'>{$orderinfo.order_no}</td>
              <td nowrap='nowrap'>{$orderinfo.order_pay_time|date='Y-m-d H:i:s',###}</td>
              <td nowrap='nowrap'>{$orderinfo.customer_name}</td>
              <td nowrap='nowrap'>{$orderinfo.customer_tel}</td>
             
              <td nowrap='nowrap'>
                  <switch name="orderinfo['sh_style']">
                    <case value="0">到店取货</case>
                    <case value="1">快递</case>
                    <case value="2">送货上门</case>
                    <default />
                  </switch>
               </td>

              <td nowrap='nowrap' colspan="3">{$orderinfo.province}{$orderinfo.city}{$orderinfo.area}{$orderinfo.detailed}</td> 
        </tr>
        <tr style='background-color:#efefef;'><td nowrap='nowrap'><b>订单总金额</b></td><td nowrap='nowrap'><b>商品金额</b></td><td nowrap='nowrap'><b>快递费</b></td><td nowrap='nowrap'><b>优惠券金额</b></td><td nowrap='nowrap'><b>满减卷金额</b></td><td nowrap='nowrap' colspan="3"><b>红包金额</b></td></tr>

             <tr style='height:50px;'>
              <td nowrap='nowrap'>{$orderinfo.order_fact}</td>
              <td nowrap='nowrap'>{$orderinfo.order_receivable}</td>
              <td nowrap='nowrap'>{$orderinfo.order_delivery_price}</td>
              <td nowrap='nowrap'>{$orderinfo.coupon_money}</td>
            
               <td nowrap='nowrap'>{$orderinfo.full_money}</td>
              <td nowrap='nowrap' colspan="3">{$orderinfo.cash_money}</td>

        </tr>
        <tr style='background-color:#efefef;'><td nowrap='nowrap'><b>序号</b></td><td nowrap='nowrap'><b>名称</b></td><td nowrap='nowrap'><b>型号</b></td><td nowrap='nowrap'><b>颜色</b></td><td nowrap='nowrap'><b>规格</b></td><td nowrap='nowrap'><b>单价</b></td><td nowrap='nowrap'><b>数量</b></td><td nowrap='nowrap'><b>小计</b></td></tr>
        <if condition="$orderdetial neq ''">
            <volist name="orderdetial" id="item">
                <tr><td nowrap='nowrap'><b>{$i}</b></td><td nowrap='nowrap'>{$item.c_name}</td><td nowrap='nowrap'>{$item.model_name}</td><td nowrap='nowrap'>{$item.color_name}</td><td nowrap='nowrap'>{$item.spec_name}</td><td nowrap='nowrap'>{$item.detail_price}</td><td nowrap='nowrap'>{$item.detail_snum}</td><td nowrap='nowrap'>{$item['detail_snum']*$item['detail_price']|sprintf='%.2f',### }</td></tr>
            </volist>
        </if>
        <if condition="$orderinfo.order_delivery_price neq 0">
            <tr style='height:40px;'>
              <td nowrap='nowrap' colspan="6" style="text-align:right"></td>
              <td nowrap='nowrap'  style="text-align:right">快递费</td>
              <td nowrap='nowrap'>+{$orderinfo.order_delivery_price}</td>
            <tr>
        </if>
        <if condition="$orderinfo.coupon_money neq 0">
            <tr style='height:40px;'>
              <td nowrap='nowrap' colspan="6" style="text-align:right"></td>
              <td nowrap='nowrap'  style="text-align:right">优惠券</td>
              <td nowrap='nowrap'>-{$orderinfo.coupon_money}</td>
            <tr>
        </if>
        <if condition="$orderinfo.full_money neq 0">
            <tr style='height:40px;'>
              <td nowrap='nowrap' colspan="6" style="text-align:right"></td>
              <td nowrap='nowrap'  style="text-align:right">满减券</td>
              <td nowrap='nowrap'>-{$orderinfo.full_money}</td>
            <tr>
        </if>
         <if condition="$orderinfo.cash_money neq 0">
            <tr style='height:40px;'>
              <td nowrap='nowrap' colspan="6" style="text-align:right"></td>
              <td nowrap='nowrap'  style="text-align:right">现金红包</td>
              <td nowrap='nowrap'>-{$orderinfo.cash_money}</td>
            <tr>
        </if>

        <tr style='height:40px;'>
              <td nowrap='nowrap' colspan="6" style="text-align:right"></td>
              <td nowrap='nowrap'  style="text-align:right">合计</td>
              <td nowrap='nowrap'>{$orderinfo.order_fact}</td>
        </tr>
         <tr style='background-color:#efefef;'><td nowrap='nowrap' colspan="8"><b>订单备注</b></td></tr>
          <tr style='height:40px;'>
          <td nowrap='nowrap' colspan="8">{$orderinfo['order_remark']}</td>
        </tr>
        <tr style='background-color:#efefef;'><td nowrap='nowrap' colspan="8"><b>客服备注</b></td></tr>
          <tr style='height:40px;'>
          <td nowrap='nowrap' colspan="8">{$orderinfo['kf_remark']}</td>
        </tr>
        </tbody>

       

</table>

<block name="js">
  <script type="text/javascript"> 
  $('#province').change(function(){ 
      var area_id  = $(this).val();
      if(area_id==0){ 
         art.dialog({
                  content:"请选择省份",
                  lock:true
              });
             return false;
      }
      var url = "{:U('Shopping/getCity')}";
        $.ajax({
          type:"post",
          url:url,
          dataType:'json',
          data:{'area_id':area_id},
          error:function(){
              art.dialog({
                  content:"网络错误，请重试！",
                  lock:true
              });
             
          },
          success:function(re){
              $('#city').html('');
              $('#city').html(re);
          }
      })      

  })

  

    $('#city').change(function(){ 
     
      var province=$('#province').find("option:selected").text();
      if(province==0){ 
         art.dialog({
                  content:"请选择省份",
                  lock:true
              });
             return false;
      }
      // var city  = $('#city').text();
      var city=$('#city').find("option:selected").text();
      if(city==0){ 
         art.dialog({
                  content:"请选择市区",
                  lock:true
              });
             return false;
      }
      var url = "{:U('Shopping/getOrderShopInfo')}";
        $.ajax({
          type:"post",
          url:url,
          dataType:'json',
          data:{'province':province,'city':city},
          error:function(){
              art.dialog({
                  content:"网络错误，请重试！",
                  lock:true
              });
             
          },
          success:function(re){
              $('#shop_id').html('');
              $('#shop_id').html(re);
          }
      })      

  })

      $('#tj').click(function(){ 
          var shop_id = $('#shop_id').val();
          if(shop_id==0){ 
               art.dialog({
                    content:"请选择门店",
                    lock:true
                });
               return false;
          }
          var order_id = $('#order_id').val();
          var url = "{:U('Shopping/changeOrder')}";
          $.ajax({
            type:"post",
            url:url,
            data:{'shop_id':shop_id,'order_id':order_id},
            error:function(){
                art.dialog({
                    content:"网络错误，请重试！",
                    lock:true
                });
               
            },
            success:function(re){
                if(re.status == 1){
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    window.setTimeout("window.location='"+"{:U('Shopping/orderlist')}'",1500);
                }else{
                    art.dialog({
                        content:re.info,
                        lock:true
                    });
                    sub.attr('sub',sub.val());
                    sub.val('提交');
                    sub.attr('disabled',false);
                    window.setTimeout("window.location='"+"{:U('Shopping/orderlist')}'",1500);
                }
            }
        })      
      })
  </script>
</block>





