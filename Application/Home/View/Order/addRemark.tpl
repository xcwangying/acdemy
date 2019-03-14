
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
                 备注信息：<span style="color: #FF0000;">*</span>
                 <textarea name="kf_remark" id="kf_remark" class="form-control" style="width:100%" cols='200' rows ='4'></textarea>  
              </label>
           </div>
          
           
              <input type='hidden' value="{$orderinfo.order_id}" id = 'order_id'/>
            <div style="clear:both;text-align:center">
               <input type='button' id='tj' value='提交' class="btn btn-lm btn-primary" style='text-align:center;float: center'/>
           </div>
      
      </div>
 


<block name="js">
  <script type="text/javascript"> 
  $('#tj').click(function(){ 
     var order_id = $('#order_id').val();
      var kf_remark = $('#kf_remark').val();

      $.ajax({ 
          url:"{:U('Order/doAddRemark')}",
          data:{'order_id':order_id,'kf_remark':kf_remark},
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





