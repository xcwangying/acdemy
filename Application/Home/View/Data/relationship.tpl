<extend name="Public/base"/>
<block name="content">
 
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/vendors/jstree/dist/themes/default/style.min.css">
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/vendors/jquery-treetable/stylesheets/jquery.treetable.css">
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/vendors/jquery-treetable/stylesheets/jquery.treetable.theme.custom.css">
 <style type="text/css">
   .jstree-default .jstree-icon:empty{height:28px;width:28px;}
  .form-control{width:20%;}
  .btn-default{    padding: 7px 12px; margin-top: -5px;} 
  </style>
    


<div class="content-wrapper">
      <section class="content-header">
            <h1>
                客户关系<!-- ->
                <foreach name='select' item='i'>
                    <if condition="$gselect eq $i['pid']">{$i.name}</if>
                </foreach> -->
            </h1>
            <ol class="breadcrumb">
                <li>后台管理</li>
                 <li>数据分析</li>
                <li class="active">客户关系</li>
            </ol>
        </section>
<form class="searchform" action="{:U('Customer/relation')}" method="post"  style="margin-left:20px;margin-top:20px" >
        <!-- <a href="{:U('Vip/relation')}"><input type="button" class="btn_ser btn btn-sm btn-primary" value="查看全部"  /></a><br/><br/> -->
            
            <input type="text" class="input_ser form-control" name="person_tel" value="{$person_tel}" placeholder="请输入用户姓名或手机号码搜索" />
           <!--  选择项目分类:
            <select name="select" class="form-control">
                <foreach name='select' item='i'>
                    <option <if condition="$gselect eq $i['pid']">selected="selected"</if> value="{$i.pid}">{$i.name}</option>
                </foreach>
             </select> -->
            <button class="btn btn-default btn-sm" ><i class="fa fa-search">搜索</i></button>
            
            
        </form>

<section class="content">
    <div class="row">
      <div class="col-xs-12">
        <div class="box">
          <div class="box-body">



           <div class="page-content">
                <div class="row">
                    <div class="col-lg-12">
                    	<div>
                    		<img src="http://admin.dym666.com/icon/10.png"/ > <span style="display:inline-block;margin-left:3px"> 城市运营中心 </span> 
                    		<img src="http://admin.dym666.com/icon/9.png"/ style="display:inline-block;margin-left:20px" > <span> 专卖店 </span>
                    		<img src="http://admin.dym666.com/icon/8.png"/ style="display:inline-block;margin-left:20px" > <span> 联合创始人 </span> 
                    		<img src="http://admin.dym666.com/icon/6.png"/ style="display:inline-block;margin-left:20px" > <span> 童颜工匠师 </span>
                    		<img src="http://admin.dym666.com/icon/5.png"/ style="display:inline-block;margin-left:20px" > <span> 观众 </span> 
                    		<img src="http://admin.dym666.com/icon/4.png"/ style="display:inline-block;margin-left:20px" > <span> 听众 </span> 
                    		<img src="http://admin.dym666.com/icon/3.png"/ style="display:inline-block;margin-left:20px" > <span> 会员 </span> 
                    		<img src="http://admin.dym666.com/icon/2.png"/ style="display:inline-block;margin-left:20px" > <span> 粉丝 </span> 
                    	</div>
                        <div id="treeviewTabContent" class="tab-content" style="margin-top:40px;font-size: 15px;">
                            <!-- 树形结构 -->
                            <div class="treeList">

                                <div id="jstree">

                                </div>

                            </div>
                        </div>
    
                    </div>
                </div>
            </div>


</div></div></div></div>
</section>
</div>

            <!--END CONTENT-->    
            <script src="__PUBLIC__/jquery.min.js"></script>  

</block>
<block name="js">
<script src="__PUBLIC__/jstree/dist/jstree.js"></script>
<script>
//现在写的树形图
$(function () {
    /*//初始化树形图 
    $.ajax({
        url: '__URL__/index?id=%23',
        dataType: "json",
        success: function (d) {
        },
    });*/
    //请求树结构
    $('#jstree').jstree({
        'core' : {
            'data' : {
                "url" : "__URL__/dealTree",
                "dataType" : "json",
                'data' : function (node) {
                    // alert(node.id);
                    return { 'id' : node.id };
                }
            }
        }
    })
  });
    function subgo(id){
        var url = "{:U('Customer/customerInfo')}";
        $.ajax({ 
            url:url,
            data:"customer_id="+id,
            type:'POST',
            dataType:'text',
            error: function(){
            },
            success: function(res){
                art.dialog({
                    title:'用户信息',
                    content:res,
                });
            }
        });
        return false;
    }
  </script>
  </block>