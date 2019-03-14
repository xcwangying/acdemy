<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                {$title}
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>{$mtitle}</li>
                <li class="active">{$title}</li>
            </ol>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row lee_box">
                            <div class="col-xs-4">
                                <div class="dataTables_length">
                                    <label>
                                        <span class="btn btn-primary btn-sm" onclick="doPrint()">打印</span>
                                        <php>if(!empty($_GET)){</php>
                                        <a href="{:U('User/statement')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label>
                                </div>
                            </div>
                            <form class="searchform" method="get">
                                <div class="col-xs-8">
                                    <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <select class="input_ser input-sm form-control ui-widget lee_search" name="department_id" style="width:150px;" id="lee_select">
                                                    <option value="">请选择部门</option>
                                                    <?php foreach($department as $v):?>
                                                        <option value="{$v.department_id}" <?php if($v['department_id']==$department_id):?>selected<?php endif;?>>{$v.department_name}</option>
                                                    <?php endforeach;?>
                                                </select>
                                                <input type="text" class="input_ser input-sm form-control ui-widget month lee_month" name="month" value="{$_GET['month']}" placeholder="请填写月份" style="width:130px;"/>
                                                <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
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
                                                <th class="text-center">姓名</th>
                                                <?php for($i=1;$i<=$day;$i++):?>
                                                    <th class="text-center">{$i}</th>
                                                <?php endfor;?>
                                                <th class="text-center">工作日(天)</th>
                                                <th class="text-center">工作时长(小时)</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <if condition="$data">
                                                <volist name="data" id="item">
                                                    <tr>
                                                        <th class="text-center">{$item.user_name}</th>
                                                        <?php foreach($item as $k=>$v):?>
                                                            <?php if(is_numeric($k)):?>
                                                                <th class="text-center">
                                                                    <?php if($v['active']==1):?>
                                                                        <span class="btn btn-success btn-xs"><i class="glyphicon glyphicon-ok"></i></span>
                                                                    <?php else:?>
                                                                        <span class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></span>
                                                                    <?php endif;?>
                                                                </th>
                                                            <?php endif;?>
                                                        <?php endforeach;?>
                                                        <th class="text-center">{$item.workday}</th>
                                                        <th class="text-center">{$item.workhour}</th>
                                                    </tr>
                                                </volist>
                                            <else />
                                                <tr></tr>
                                                <tr>
                                                    <td class="into" colspan="34" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
                                                </tr>
                                            </if>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
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
    $('.lee_month').datepicker({
            format: 'yyyymm',
            autoclose: true,
        });
</script>
<script>
    function doPrint(){
        $('.lee_box').hide();
        if(confirm('确定要打印吗？')){
            window.print();
            location.reload();
        }
    }
</script>
</block>