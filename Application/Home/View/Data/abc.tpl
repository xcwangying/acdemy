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
                用户粉丝报表
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>数据分析</li>
                <li class="active">用户粉丝报表</li>
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
                        <div class="row">
                            <div class="col-sm-5">
                                <div class="dataTables_length">
                                    <label>
<!--                                         <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                            <a href="{:U('Data/index')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                        <php>}</php> -->
                                    </label>
                                </div>
                            </div> 

                            <form class="searchform" method="get" >
                                <div class="col-sm-12">
                                <div class="dataTables_filter" >
                                    <span class="sta_type">类型：
                                        <select name="type" class="type" id="neixing">
                                            <option value="2" <eq name="type" value="2">selected</eq> >月报表</option>
                                            <!--<option value="3" <eq name="type" value="3">selected</eq> >年报表</option>-->
                                        </select>
                                    </span>
                                    <span class="sta_month" >
                                        <select name="month_date" id="month_date" class="type">
                                            <volist name="monthres" id="vo">
                                                <option value="{$vo}"<eq name="month_date" value="$vo">selected</eq>  >{$vo}</option>
                                            </volist>
                                        </select>
                                    </span>

                                    <!--<span class="sta_year" >
                                        <select name="year_date" id="year_date" class="type">
                                            <volist name="yearres" id="vo">
                                                <option value="{$vo}"<eq name="year_date" value="$vo">selected</eq>  >{$vo}</option>
                                            </volist>
                                        </select>
                                    </span>-->
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
                    <th class="text-center">时间</th>
                    <th class="text-center">{$identityList[0]['identity']}</th>
                    <th class="text-center">{$identityList[1]['identity']}</th>
                    <th class="text-center">{$identityList[2]['identity']}</th>
                    <!--<th class="text-center">{$identityList[3]['identity']}</th>-->
                    <th class="text-center">{$identityList[4]['identity']}</th>
                    <th class="text-center">{$identityList[5]['identity']}</th>
                    <th class="text-center">{$identityList[6]['identity']}</th>
                    <th class="text-center">{$identityList[7]['identity']}</th>
                    <th class="text-center">{$identityList[8]['identity']}</th>
                    <!--<th class="text-center">{$identityList[9]['identity']}</th>-->
                    <th class="text-center">小计</th>
                </tr>
            </thead>

            <tbody>                          
                <volist name="data" id="vo">
                        <tr>
                            <td class="text-center">{$vo['day']}</td>  

                            <td class="text-center">
                                <if condition="$vo['v10'] eq 0">
                                    {$vo['v10']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>10))}"></a>{$vo['v10']}            
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v9'] eq 0">
                                    {$vo['v9']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>9))}"></a> {$vo['v9']}           
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v8'] eq 0">
                                    {$vo['v8']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>8))}"></a> {$vo['v8']}           
                                </if>
                            </td>

                            <!--<td class="text-center">
                                <if condition="$vo['v7'] eq 0">
                                    {$vo['v7']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>7))}">{$vo['v7']}</a>              
                                </if>
                            </td>-->

                            <td class="text-center"> 
                                <if condition="$vo['v6'] eq 0">
                                    {$vo['v6']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>6))}"></a>{$vo['v6']}              
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v5'] eq 0">
                                    {$vo['v5']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>5))}"></a> {$vo['v5']}             
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v4'] eq 0">
                                    {$vo['v4']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>4))}"></a> {$vo['v4']}             
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v3'] eq 0">
                                    {$vo['v3']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>3))}"></a> {$vo['v3']}             
                                </if>
                            </td>

                            <td class="text-center">
                                <if condition="$vo['v2'] eq 0">
                                    {$vo['v2']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>2))}"></a>{$vo['v2']}              
                                </if>
                            </td>

                            <!--<td class="text-center">
                                <if condition="$vo['v1'] eq 0">
                                    {$vo['v1']}
                                <else />
                                    <a href="{:U('Data/Userdetails',array('cate'=>$vo['day'],'mtype'=>$type,'yid'=>1))}">{$vo['v1']}</a>              
                                </if>
                            </td>-->

                            <td class="text-center">{$vo['count']}</td>
                        </tr>  
                </volist>         
            </tbody>
        </table>
</div>
</div>
</section>
</div>
</block>
<block name="js">
<script type="text/javascript">
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
        // if(type==4){
        //     d(".sta_day").hide();
        //     d(".sta_month").hide();
        //     d(".sta_year").hide();
        //     d(".sta_other").show();
        // }
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
    // $('#chart-sine').highcharts({
    //     chart: {
    //         type: 'bar'
    //     },
    //     title: {
    //         text: '用户粉丝条形图'
    //     },
    //     subtitle: {
    //         text: ''
    //     },
    //     xAxis: {
    //         categories: {$arr2},
    //         title: {
    //             text: null
    //         }
    //     },
    //     yAxis: {
    //         min: 0,
    //         title: {
    //             text: '对应身份人数 (人)',
    //             align: 'high'
    //         },
    //         labels: {
    //             overflow: 'justify'
    //         }
    //     },
    //     tooltip: {
    //         valueSuffix: ' 人'
    //     },
    //     plotOptions: {
    //         bar: {
    //             dataLabels: {
    //                 enabled: true,
    //                 allowOverlap: true
    //             }
    //         }
    //     },
    //     legend: {
    //         layout: 'vertical',
    //         align: 'right',
    //         verticalAlign: 'top',
    //         x: -40,
    //         y: 100,
    //         floating: true,
    //         borderWidth: 1,
    //         backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
    //         shadow: true
    //     },
    //     credits: {
    //         enabled: false
    //     },
    //     series: [{
    //         name: '对应身份人数',
    //         data: {$arr1} 
    //     }]
    // });

    // 柱形图
    // $('#chart-sine').highcharts({
    //     chart: {
    //         type: 'column'
    //     },
    //     title: {
    //         text: '用户粉丝数'
    //     },
    //     subtitle: {
    //         text: ''
    //     },
    //     xAxis: {
    //         categories: {$arr2},
    //         crosshair: true
    //     },
    //     yAxis: {
    //         min: 0,
    //         title: {
    //             text: '人数 (人)'
    //         }
    //     },
    //     tooltip: {
    //         headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
    //         pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
    //         '<td style="padding:0"><b>{point.y:1f} </b></td></tr>',
    //         footerFormat: '</table>',
    //         shared: true,
    //         useHTML: true
    //     },
    //     plotOptions: {
    //         column: {
    //             pointPadding: 0.0,
    //             borderWidth: 0
    //         }
    //     },
    //     series: [{
    //         name: '总人数',
    //         data: {$arr1}
    //     }]
    // });

    var date = {$z_time};
    $('#chart-sine').highcharts({
        title: {
            text:'用户粉丝报表'
        },
        subtitle: {
            text:"{$riqi}",
        },
        xAxis: {
            categories: date
        },
        yAxis: {
            title: {
                text: '人数 (人)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '人'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [
            {
                name: "{$identityList[0]['identity']}",
                data: {$count10}
            },
            {
                name: "{$identityList[1]['identity']}",
                data: {$count9}
            },
            {
                name: "{$identityList[2]['identity']}",
                data: {$count7}
            },
            /*{
                name: "{$identityList[3]['identity']}",
                data: {$count6}
            },*/
            {
                name: "{$identityList[4]['identity']}",
                data: {$count5}
            },
            {
                name: "{$identityList[5]['identity']}",
                data: {$count4}
            },
            {
                name: "{$identityList[6]['identity']}",
                data: {$count3}
            },
            {
                name: "{$identityList[7]['identity']}",
                data: {$count2}
            },
            {
                name: "{$identityList[8]['identity']}",
                data: {$count0}
            },
        	/*{
                name: "{$identityList[9]['identity']}",
                data: {$count1}
            },*/
        ]
    });
console.log({$count0});
});
</script>

</block>  