<extend name="Public/base" />
<block name="css">
    <!-- Morris Charts CSS -->
    <link href="__Assert__/bower_components/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
    <style>
        .type{ height:28px; line-height: 28px;}
        .sta_type{ margin-right: 0px;}
        .my-btn{ height:28px; margin-left:-2px; margin-top:-4px;}
        .pagination a, .pagination span{ display: inline-block; padding:0 10px; height:30px; text-align: center; line-height: 30px; border:solid 1px #ccc;}
        .pagination span{ background: #337ab7; color:white; border:solid 1px #337ab7;}
    </style>
</block>
<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1 style="margin-bottom:10px">
                卖手成交报表
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>数据分析</li>
                <li class="active">卖手成交报表</li>
            </ol>
        </section>
        <section>
    <div class="panel panel-info">
        <div class="panel-body">
        <div class="row" id="window_main">
         <div id="chart-sine" style="width:85%;height:35%;"></div>
            <div class="window_main_top" style="margin-top:40px;margin-bottom:10px;border:none;">
            <div class="col-lg-12">
                <div class="panel  panel-default" style='border:none;'>

                    <div class="panel-heading">
                        <div class="row" >
                        
                            <div class="col-sm-6" id="window_main">
                                <div class="dataTables_length">

                                </div>
                            </div>
                            <form class="searchform" >
                            <div class="col-sm-12">
                                <div class="dataTables_filter" >
                                    <span class="sta_type">类型：
                                        <select name="type" class="type" id="neixing">
                                            <option value="2" <eq name="type" value="2">selected</eq> >月报表</option>
                                            <option value="3" <eq name="type" value="3">selected</eq> >年报表</option>
                                        </select>
                                    </span>
                                    <span class="sta_month" >
                                        <select name="month_date" id="month_date" class="type">
                                            <volist name="monthres" id="vo">
                                                <option value="{$vo}"<eq name="month_date" value="$vo">selected</eq>  >{$vo}</option>
                                            </volist>
                                        </select>
                                    </span>

                                    <span class="sta_year" >
                                        <select name="year_date" id="year_date" class="type">
                                            <volist name="yearres" id="vo">
                                                <option value="{$vo}"<eq name="year_date" value="$vo">selected</eq>  >{$vo}</option>
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
            <if condition="$vipList neq NULL">
                <thead>
                    <tr>
                        <th class="text-center">时间</th>

                        <volist name="vipList" id="vo">
                            <td class="text-center">{$vo.vname}</td>
                        </volist>
                        <th class="text-center">小计</th>
                    </tr>
                </thead>

                <tbody>
                    <?php for($i=$maxday-1;$i>=0;$i--){ ?>
                        <tr>
                            <td class="text-center">{$atime[$i]}</td>
                            <?php foreach ($data[$i] as $key=>$item) { ?>
                                <td class="text-center">
                                    <if condition="$item eq 0">
                                        {$item}
                                    <else />
                                        <a href="{:U('Data/Trackdetails',array('cate'=>$atime[$i],'mtype'=>$type,'yid'=>$key))}">{$item}</a>            
                                    </if>
                                </td>
                            <?php }?>
                            <td class="text-center">{$jcount[$i]}</td>
                        </tr>
                    <?php } ?>

                    <tr>
                        <td class="text-center"><b>合计:</b></td>
                        <volist name="harr" id="ho">
                            <td class="text-center">{$ho}</td>
                        </volist>
                        <td class="text-center">{$hcount}</td>
                    </tr>
                </tbody>
            <else/>
                <thead>
                    <tr>
                        <th class="text-center" ><h1>暂无卖手</h1></th>
                    </tr>
                </thead>
            </if>
        </table>
</div>
</div>
</section>
</div>
</block>
<block name="js">
<!-- 设置每页的条数 start -->
<script>
    var dom = $("#window_main");
    var d = function(id){return dom.find(id)}
    $(function(){
        serCheckType();
        //报表类型改变
        d(".type").change(function(){
            serCheckType();
        });
        //日历
        d( ".datepicker" ).datepicker( $.datepicker.regional[ "zh-TW" ] );
    });

    //选择报表类型
    function serCheckType(){
        var type=d(".type").val();
        if(type==2){
            d(".sta_day").hide();
            d(".sta_month").show();
            d(".sta_year").hide();
            d(".sta_other").hide();
        }
        if(type==3){
            d(".sta_day").hide();
            d(".sta_month").hide();
            d(".sta_year").show();
            d(".sta_other").hide();
        }
    }
</script>
<script type="text/javascript">
    $(function (){
        $(".datetimepicker3").on("click",function(e){
            e.stopPropagation();
            $(this).lqdatetimepicker({
                css : 'datetime-day',
                dateType : 'D',
                selectback : function(){

                }
            });
        });
    });
</script>

<script>
$(function () {
    var date = {$z_time};
    $('#chart-sine').highcharts({
        title: {
            text:'卖手成交报表'
        },
        subtitle: {
            text:"{$riqi}",
        
        },
        xAxis: {
            categories: date
        },
        yAxis: {
            title: {
                text: '成交额 (元)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '元'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [
            {
                name: '卖手成交金额',
                data: {$Online}
            },
            // {
            //     name: '线下收入',
            //     data: {$Linedown}
            // },
        ]
    });
});
    </script>
</block>  