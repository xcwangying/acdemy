<extend name="Public/base" />
<block name="css">
    <!-- Morris Charts CSS -->
    <link href="__Assert__/bower_components/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
 
</block>
<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1 style="margin-bottom:10px">
                客服分析
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>数据分析</li>
                <li class="active">客服分析</li>
            </ol>
        </section>

<section>
    <div class="panel panel-info">
        <div class="panel-body">
        <div class="row" id="window_main">

        <if condition="$userList neq NULL">
            <div id="chart-sine" style="width:100%;height:100%;"></div>
            <div class="window_main_top" style="margin-top:40px;margin-bottom:10px;border:none;">
                <div class="col-lg-12">
                    <div class="panel  panel-default" style='border:none;'>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="dataTables_length">
                                        <label>
                                        </label>
                                    </div>
                                </div> 

                                <form class="searchform" method="get" >
                                    <div class="col-sm-12">
                                    <div class="dataTables_filter" >
                                        <span class="sta_year" >
                                            <select name="year_date" id="year_date" class="type">
                                                <volist name="yearres" id="vo">
                                                    <option value="{$vo}"<eq name="year_date" value="$vo">selected</eq>  >{$vo}</option>
                                                </volist>
                                            </select>
                                        </span>
                                        <span class="sta_month" >-
                                            <select name="month_date" id="month_date" class="type">
                                                <volist name="monthres" id="vo">
                                                    <option value="{$vo}"<eq name="month_date" value="$vo">selected</eq>  >{$vo}</option>
                                                </volist>
                                            </select>
                                        </span>
                                        <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                                </form>                          
                            </div>
                        </div>

            <div class="panel-body" style="overflow-x:auto;">
                <div class="dataTable_wrapper">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th class="text-center">序号</th>
                                <th class="text-center">客服</th>
                                <th class="text-center">服务量(人)</th>
                                <th class="text-center">成交率(%)</th>
                                <th class="text-center">成交金额(万)</th>
                            </tr>
                        </thead>

                        <tbody>   
                            <volist name="keList" id="vo">
                                <tr> 
                                    <td class="text-center">{$i}</td>
                                    <td class="text-center">{$vo.kname}
                                        <!-- <a href="{:U('Data/Customer',array('kid'=>$vo['kid']))}"></a> -->
                                    </td>
                                    <td class="text-center">{$vo.tcount}</td>
                                    <td class="text-center">{$vo.percentage}</td>
                                    <td class="text-center">{$vo.zcash}</td>
                                </tr> 
                            </volist>

                            <tr>
                                <th class="text-center">总计：</th>
                                <th class="text-center"></th>
                                <th class="text-center">{$hcount1}</th>
                                <th class="text-center"></th>
                                <th class="text-center">{$hcount3}</th>      
                            </tr>                        
                        </tbody>
                    </table>
                </div>
            </div>
        <else />
            <div style="width:100%;height:500px;margin:0px auto; "><h1 style="margin:0px auto;">暂无相关员工</h1></div>
        </if>
</section>
</div>
</block>
<block name="js">

<script>
$(function () {
    $('#chart-sine').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '客服分析图（{$riqi}）'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: {$arr1},
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:1f} </b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.0,
                borderWidth: 0
            }
        },
        series: [{
            name: '服务量(人)',
            data: {$arr2}
        }, {
            name: "成交率(%)",
            data: {$arr3}
        }, {
            name: "成交金额(万)",
            data: {$arr4}
        }]
    });
});
</script>

</block>  