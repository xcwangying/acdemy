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
                阅读记录&nbsp;->&nbsp;&nbsp;{$vip_info['title']}&nbsp;->&nbsp;&nbsp;{$vip_info['read_num']}次阅读量
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                <li>文章管理</li>
                <li class="active">阅读记录</li>
            </ol>
        </section>
 <section class="content row">
    
        <div class="" id="window_main">
            <div class="window_main_top" style="margin-bottom:10px;border:none;">
             <div class="box panel-info">
        <div class="box-body">   
            <div class="col-lg-12">
                <div class="" style='border:none;'>

                    <div class="">
                        <div class="row">
                            <div class="col-sm-5">
                                <div class="dataTables_length">
                                    <label>
                                        <ahref='#' onClick='javascript :history.back(-1);'><input type="button" class="btn btn-sm btn-primary" value="返回"></a>
                                    </label>
                                </div>
                            </div> 

                            <form class="searchform" method="get" >
                                <div class="col-sm-7" style="padding:10px 0px">
                                    <div class="dataTables_filter">  

                                            <select name="dtime" style="display:inline-block;padding: 3px">
                                            <option value="" <if condition="$_GET['dtime'] eq ''">selected="selected"</if>>时间排序↑↓</option>
                                            <option value="1" <if condition="$_GET['dtime'] eq '1'">selected="selected"</if>>阅读时间↑</option>
                                            <option value="2" <if condition="$_GET['dtime'] eq '2'">selected="selected"</if>>阅读时间↓</option>
                                         </select>
                                         <!-- <select name="integral">
                                            <option value="" <if condition="$_GET['integral'] eq ''">selected="selected"</if>>事件类型</option>
                                            <option value="1" <if condition="$_GET['integral'] eq '1'">selected="selected"</if>>获得积分↑</option>
                                            <option value="2" <if condition="$_GET['integral'] eq '2'">selected="selected"</if>>获得积分↓</option>
                                         </select> -->
                                            <div class="dataTables_filter" style="display:inline-block;float:right">
                                                <span class="sta_other">
                                                <input type="text" class="datetimepicker3" readonly name="date_begin" value="{$date_begin}" id="date_begin"/>&nbsp;&nbsp;至
                                                <input type="text" class="datetimepicker3" readonly name="date_end" value="{$date_end}" id="date_end"/>
                                                </span>
                                                <input type="hidden" name="vid" value="{$vid}"/>
                                                <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;" id="chaxun"><i class="fa fa-search"></i></button>
                                            </div>
                                       
                                    </div>
                                </div>
                            </form>                          
                        </div>
                    </div>

 <div class="panel-body" style="overflow-x:auto;overflow-y:auto;max-height:540px">
    <div class="dataTable_wrapper">
        <table class="table table-bordered table-hover" >
            <thead>
                <tr>
                    <th>序号</th>
                    <th>阅读人</th>
                    <th>阅读时间</th>
                    <th>ip</th>
                    
                </tr>
            </thead>

            <if condition="$data neq NULL">
                <tbody>
                    <volist name="data" id="vo">
                        <tr>
                            <td>{$i}</td>
                            <td><if condition="$vo.vname neq NULL"><a href='javascript:void(0)' onclick='subgo("{$vo['vid']}")'>{$vo.vname}<a/><else/>--</if></td>
                            <td>{$vo['time']|friendlyDate}</td>
                            <td>{$vo.ip}</td>
                        </tr>
                    </volist>
                </tbody>
            <else/>
                <tbody>
                    <tr>
                        <td  class="text-center" colspan='4' ><h1>暂无数据</h1></td>
                    </tr>
                </tbody>
            </if>
        </table>

        <if condition="$data neq NULL">
            <div class="row">
                <div class="col-sm-5">
                    <div class="dataTables_info">
                        <span>共有<code>{$count}</code>条记录</span>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">{$page}</ul>
                    </div>
                </div>
            </div>
        </if>
</div>
</div>
</section>
</div>
</block>
<block name="js">

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

        $('#chaxun').click(function () {
            var date_begin = $("#date_begin").val();
            var date_end = $("#date_end").val();

            var sta_date = Number(new Date(date_begin));
            var end_date = Number(new Date(date_end));
            if(end_date < sta_date){
                art.dialog({content:"结束时间不能小于开始时间！",
                    title: "温馨提示",
                    lock: true,
                });
                return false;
            }
        })
    });
    function subgo(id){
        var url = "{:U('Vip/vipInfo')}";
        $.ajax({ 
            url:url,
            data:"vid="+id,
            type:'POST',
            dataType:'text',
            error: function(){
                art.dialog({
                    title:'提示',
                    content:'网络异常，请重试！',
                    lock:true
                });
            },
            success: function(res){
                art.dialog({
                    title:'用户信息',
                    content:res,
                    lock:true
                });
            }
        });
        return false;
    }
</script>

</block>  