
	<a href="{$data['headimhurl']}" target="_blank"><img src="{$data['headimhurl']}" width=200 height=200 alt="{$data['vip_name']}" title="用户微信头象"></a>

    <table border="1px">
        <tr>
            <th>用户名:</th>
            <td>{$data['vip_name']}<if condition="$data.truename neq ''">（{$data.truename}）</if></td>
        </tr>
        <tr>
            <th>用户手机号:</th>
            <td>{$data['vip_tel']}</td>
        </tr>
        <tr>
            <th>累计消费:</th>
            <td>
                {$data['total_use_money']}
            </td>
            
        </tr>
        <tr>
            <th>累计积分:</th>
            <td>
                {$data.vip_integral}
            </td>
        </tr>
        <tr>
            <th>剩余积分:</th>
            <td>
                {$data.vip_kintegral}
            </td>
        </tr>
        <tr>
            <th>最后一次登录时间:</th>
            <td>
                <if condition="$data['dtime']">{$data.dtime|curtime=###}<else/>{$data.ctime|curtime=###}</if>
            </td>
        </tr>
        <if condition="$data['flng']">
            <if condition="$data['flat']">
                <tr>
                    <th>店铺名称:</th>
                    <td>
                        {$data['storename']}
                    </td>
                    
                </tr>
                <tr>
                    <th>店铺地址:</th>
                    <td>
                        {$data.storeadress}
                    </td>
                </tr>
            </if>
        </if>
        <if condition="$re">
        	<tr>
        		<th>备注信息</th>
        		<td>
        			<volist name="re" id="vo">
        				<b style="color:green">{$vo.dtime|date="Y-m-d H:i:s",###}：</b><br>{$vo.event}<br><br>
        			</volist>
        		</td>
        	</tr>
        </if>
    </table>

<!-- <script src="__Assert__/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="__Assert__/plugins/layer/layer.js"></script>
<script type="text/javascript">
$(document).on('click', '.ok', function () {
    
    var mess = $('#r').val();
    var vid = "{$vid}";
    var aurl = "{:U('Vip/doSend')}";
    var atext = '系统提示';
    data = "mess="+mess+"&vid="+vid;
    $.ajax({
            url: aurl,
            data:data,
            type:'post',
            dataType:"text",
            error: function(){},
            success: function (res) {
               layer.msg(res);
                setTimeout(location.href="{:U('Vip/index')}",5);
            },
    });


});


</script> -->