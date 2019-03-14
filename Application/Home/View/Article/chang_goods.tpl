
    <table >
        <tr>

            <td>商品名称：
                <select name="goods_id" id="id">
                        <option value="0">--请选择--</option>
                    <volist name="data" id="v">
                        <option value="{$v['goods_id']}">{$v['goods_name']}</option>
                    </volist>
                </select>
            </td>
            
        </tr>
        <tr>
            <td>
                <input type="button" class="ok" value="确定更改" />
            </td>
        </tr>
    </table>

<script src="__Assert__/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="__Assert__/plugins/layer/layer.js"></script>
<script type="text/javascript">
$(document).on('click', '.ok', function () {
    var goods_id = $('#id option:selected').val();
    var id = "{$id}";
    var aurl = "{:U('Article/dogoods')}";
    var atext = '系统提示';
    data = "goods_id="+goods_id+"&id="+id;
    $.ajax({
            url: aurl,
            data:data,
            type:'post',
            dataType:"text",
            error: function(){},
            success: function (res) {
               layer.msg(res);
                setTimeout(function(){location.reload();},1000);
            },
    });


});


</script>