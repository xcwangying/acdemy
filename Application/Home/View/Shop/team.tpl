<extend name="Public/base"/>
<block name="content">
 
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/style.min.css">
 <!--    <link type="text/css" rel="stylesheet" href="__PUBLIC__/vendors/jquery-treetable/stylesheets/jquery.treetable.css">
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/vendors/jquery-treetable/stylesheets/jquery.treetable.theme.custom.css"> -->
 <style type="text/css">
   .jstree-default .jstree-icon:empty{height:28px;width:28px;}


  </style>
    


<div class="content-wrapper">
      <section class="content-header">
            <h1>
                 团队展示
            </h1>
             <ol class="breadcrumb">
                <li>门店管理后台</li>
                <li class="active">团队展示</li>
            </ol>
        </section>


<section class="content">
    <div class="row">
      <div class="col-xs-12">
        <div class="box">
          <div class="box-body">



           <div class="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <div>
                            <span style="background:#000;width:25px;height:25px;display:inline-block;"></span><span style="margin-left:3px;margin-top:-10px;"> 美导 </span> 
                            <span style="background:#8906dc;width:25px;display:inline-block;height:25px;margin-left:30px;"></span><span style="display:inline-block;margin-left:3px"><span> 贵人 </span>
                            <span style="background:darkorange;display:inline-block;width:25px;height:25px;margin-left:30px;"></span><span> 华妃</span> 
                            <span style="background:pink;display:inline-block;width:25px;height:25px;margin-left:30px;"></span><span> 美人 </span>
                             <span style="background:deeppink;width:25px;display:inline-block;height:25px;margin-left:30px;"></span><span> 仙女 </span> 
                            <span style="background:#f00;width:25px;display:inline-block;height:25px;margin-left:30px;"></span><span> 天使 </span> 
                             <span style="background:#00f;width:25px;display:inline-block;height:25px;margin-left:30px;"></span><span> 会员 </span> 
                            <span style="background:silver;width:25px;display:inline-block;height:25px;margin-left:30px;"></span><span> 粉丝 </span> 
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
            <!-- <script src="__PUBLIC__/jquery.min.js"></script>   -->

</block>
<block name="js">
<script src="__PUBLIC__/jstree.min.js"></script>
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
                "url" : "__URL__/shopdealTree",//////www.jstree.com/fiddle/?lazy
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