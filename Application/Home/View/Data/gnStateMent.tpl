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
                功能报表
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>数据分析</li>
                <li class="active">功能报表</li>
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
                                <!--         <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                            <a href="{:U('Data/gnStateMent')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a> 
                                        <php>}</php> -->
                                    </label>
                                </div>
                            </div> 

                            <form class="searchform" method="get" >
                                <div class="col-sm-7">
                                    <div class="dataTables_filter">  
                                        <label>
                                            <div class="dataTables_filter">
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
                                        </label>
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
                    <th class="text-center">{$arr[0]['name']}</th>
                    <th class="text-center">{$arr[1]['name']}</th>
                    <th class="text-center">{$arr[2]['name']}</th>
                    <th class="text-center">{$arr[3]['name']}</th>
                    <th class="text-center">{$arr[4]['name']}</th>
                    <th class="text-center">{$arr[5]['name']}</th>
                    <th class="text-center">{$arr[6]['name']}</th>
                    <th class="text-center">{$arr[7]['name']}</th>
                    <th class="text-center">{$arr[8]['name']}</th>
                    <th class="text-center">小计</th>
                </tr>
            </thead>

            <tbody>                          
                <?php for($i=$maxday-1;$i>=0;$i--){ ?>
                    <tr>
                        <td class="text-center">{$dtime[$i]}</td>  
                        <td class="text-center">
                            <if condition="$mcount1[$i] eq 0">
                                {$mcount1[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>1))}">{$mcount1[$i]}</a>            
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount2[$i] eq 0">
                                {$mcount2[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>2))}">{$mcount2[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center"> 
                            <if condition="$mcount3[$i] eq 0">
                                {$mcount3[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>3))}">{$mcount3[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount4[$i] eq 0">
                                {$mcount4[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>4))}">{$mcount4[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount5[$i] eq 0">
                                {$mcount5[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>5))}">{$mcount5[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount6[$i] eq 0">
                                {$mcount6[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>6))}">{$mcount6[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount7[$i] eq 0">
                                {$mcount7[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>7))}">{$mcount7[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount8[$i] eq 0">
                                {$mcount8[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>8))}">{$mcount8[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">
                            <if condition="$mcount9[$i] eq 0">
                                {$mcount9[$i]}
                            <else />
                                <a href="{:U('Data/Featuresdetails',array('cate'=>$dtime[$i],'mtype'=>$type,'yid'=>9))}">{$mcount9[$i]}</a>              
                            </if>
                        </td>

                        <td class="text-center">{$xcount[$i]}</td>
                    </tr>  
                <?php }?> 

                    <tr>
                        <th class="text-center">总计：</th>
                        <th class="text-center">{$hcount1}</th>
                        <th class="text-center">{$hcount2}</th>
                        <th class="text-center">{$hcount3}</th>
                        <th class="text-center">{$hcount4}</th>
                        <th class="text-center">{$hcount5}</th>
                        <th class="text-center">{$hcount6}</th>
                        <th class="text-center">{$hcount7}</th>
                        <th class="text-center">{$hcount8}</th>  
                        <th class="text-center">{$hcount9}</th>
                        <th class="text-center">{$hcount}</th>          
                    </tr>                        
            </tbody>
        </table>
</div>
</div>
</section>
</div>
</block>
<block name="js">
<!-- 设置每页的条数 start -->
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
    }
</script>

<script>
$(function () {
    $('#chart-sine').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '功能点击量占比({$riqi})'
        },
        tooltip: {
            headerFormat: '{series.name}<br>',
            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: '功能点击量占比',
            data: [
                ["{$arr[0]['name']}",{$percentage1}],
                ["{$arr[1]['name']}",{$percentage2}],
                ["{$arr[2]['name']}",{$percentage3}],
                ["{$arr[3]['name']}",{$percentage4}],
                ["{$arr[4]['name']}",{$percentage5}],
                ["{$arr[5]['name']}",{$percentage6}],
                ["{$arr[6]['name']}",{$percentage7}],
                ["{$arr[7]['name']}",{$percentage8}],
                ["{$arr[8]['name']}",{$percentage9}]
            ]
        }]
    }); 
});
</script>

</block>  