
<table class='table table-hover1  table-bordered  tablesorter' style='text-align: center'>
        <tbody>
         <tr style='background-color:#efefef;'><td nowrap='nowrap' style='text-align: center'><b>订单号</b></td><td nowrap='nowrap'><b>下单时间</b></td><td nowrap='nowrap'><b>用户名称</b></td><td nowrap='nowrap'><b>手机号</b></td></tr>
          <tr style='height:50px;'>
              <td nowrap='nowrap'>{$orderinfo.order_no}</td>
              <td nowrap='nowrap'>{$orderinfo.order_pay_time|date='Y-m-d H:i:s',###}</td>
              <td nowrap='nowrap'>{$orderinfo.customer_name}</td>
              <td nowrap='nowrap'>{$orderinfo.customer_tel}</td>
               
        </tr>

          
        </tbody>
</table>
      <div style="float:none">
            <div style="float:left">
              <label>
                 省：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="province" id="province"  value="{$orderinfo['province']}" style="width:100%">
              </label>
           </div>
           <div style="float:left;">
              <label>
                 市：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="city" id="city"  value="{$orderinfo['city']}" style="width:100%">
                 
              </label>
           </div>
           <div style="float:left;margin-top:0px;">
              <label>
                 区：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="area" id="area" value="{$orderinfo['area']}" style="width:100%">
                 
              </label>
           </div>
           <div style="float:left;">
              <label>
                 详情：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="detailed" value="{$orderinfo['detailed']}" id="detailed" style="width:150%">
                 
              </label>
           </div>
           <div style="float:left;">
              <label>
                 姓名：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="name" id="name" value="{$orderinfo['name']}" style="width:100%">
                 
              </label>
           </div>
           <div style="float:left;">
              <label>
                 电话：<span style="color: #FF0000;">*</span>
                 <input class="form-control" name="phone" type='number' id="phone" value="{$orderinfo['phone']}" style="width:100%">
                 
              </label>
           </div>
           
              <input type='hidden' value="{$orderinfo.order_id}" id = 'order_id'/>
            <div style="clear:both;text-align:center">
               <input type='button' id='tj' value='处理' class="btn btn-lm btn-primary" style='text-align:center;float: center'/>
           </div>
      
      </div>
 


<block name="js">
  <script type="text/javascript"> 
  $('#tj').click(function(){ 
     var order_id = $('#order_id').val();
      var phone = $('#phone').val();
      var name = $('#name').val();
      var province = $('#province').val();
      var city = $('#city').val();
      var area = $('#area').val();
      var detailed = $('#detailed').val();

      $.ajax({ 
          url:"{:U('Order/doEdtitInfo')}",
          data:{'order_id':order_id,'phone':phone,'name':name,'province':province,'city':city,'area':area,'detailed':detailed},
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

  })
 
  </script>
</block>





