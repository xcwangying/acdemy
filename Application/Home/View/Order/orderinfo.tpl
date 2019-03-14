<if condition="$count">
    <h4>分{$count}笔支付,已付{$paycount}笔</h4>
    <table border="1px">
        <tr>
            <th>支付单号</th>
            <th>支付金额</th>
            <th>支付时间</th>
        </tr>
        <volist name="data" id="vo">
            <tr>   
                <td>{$vo['fpay_sn']}</td>
                <td>{$vo['money']}元</td>
                <td>{$vo['paytime']}</td>
            </tr>
        </volist>

        <tr>
            <th>订单金额:</th>
            <td colspan="2">{$sumpay}元</td>
        </tr>
        <if condition="$paymoney">
            <tr>
                <th>已付金额:</th>
                <td colspan="2">{$paymoney}元</td>
            </tr>
        </if>
    </table>
<else/>
    <h1>暂无数据</h1>
</if>