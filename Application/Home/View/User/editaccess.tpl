<extend name="Public/base"/>
<block name="content">

    <div class="content-wrapper" id="window_main">
        <section class="content-header">
            <h1>
                设置权限 &nbsp;&nbsp;->&nbsp;&nbsp;{$userinfo['user_name']}
            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li >人力资源</li>
                <li class="active">员工管理</li>
            </ol>
        </section>

        <section class="content">
            <div class="row" id="window_main">
<style>
.access_Button{padding-left: 520px;}
input[type='checkbox']{width:17px;height:17px;vertical-align: sub;margin-left:5px;}
fieldset input[type='checkbox']:first-child{height:20px;font-weight:bold;margin-left:15px;}
.box{width:auto;margin-left:42px;margin-top:5px;}
.box1{width:auto;margin-left:0px;margin-top:5px;}
.box3{margin-left:80px;margin-top:5px;}
.jiantou{cursor:pointer;margin-left:15px;}
.jiantou1{cursor:pointer;margin-left:45px;}
.jian{display:none;}
.jian1{display:none;}
</style>
<div style="padding-left: 13px;font-weight: bold;margin-bottom: 5px;background-color: #efefef;font-size: 20px;border-bottom:1px solid #ccc;">请根据员工的职位选择相应的权限</div>
<iframe name="formadd_sq" style="display:none;"></iframe>
<form class="access_sub" action="{:U('User/doeditaccess')}" method="post" target="formadd_sq">	
<volist name="list" id="vo">
	<fieldset>
	<span class="jiantou"><php>if($vo['act']!=null){echo ' ┿ ';}</php></span>
	<input type="checkbox" name="level[]" class="leve1" data ="1"  <php>if($vo['user_id']!=null){echo 'checked="checked"';}</php>  value="{$vo.node_id}"/><span style="font-size:16px;color:#000;display:inline-block;margin-bottom: 5px;"> {$vo.name}</span><br/>

		<volist name="vo['act']" id="vo1">
			<fieldset class="jian">
			<span class="box1 jiantou1"></span>
			<input type="checkbox" name="level[]" class="leve2" data ="" value="{$vo1.node_id}" <php>if($vo1['user_id']!=null){echo 'checked="checked"';}</php> /><span style="width:90px;display:inline-block;margin-left:5px;"> {$vo1.name}</span><br/>

				<volist name="vo1['btn']" id="vo2"> 
					<fieldset class="jian1">
					<span class=" box3"><input type="checkbox" name="level[]" class="leve3" value="{$vo2.node_id}" <php>if($vo2['user_id']!=null){echo 'checked="checked"';}</php> /><span style="width:80px;margin-left:5px;"> {$vo2.name}</span></span>
					</fieldset>
				</volist>

			</fieldset>
		</volist>
		<!-- <volist name="vo['act']" id="vo1"> 
		<span class="box"><input type="checkbox" name="level[]" class="leve2" value="{$vo1.id}" <php>if($vo1['uid']!=null){echo 'checked="checked"';}</php> /><span style="width:93px;display:inline-block;"> {$vo1.name}</span></span>
		</volist> -->

	<hr style="margin:5px;"/>
	</fieldset>
</volist>
<label >&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="all" id="all" style=""/>全选</label>

		<fieldset class="access_Button" style="margin-top:10px;margin-left:10%;margin-bottom:20px;">
		<input type="hidden" name="buser_id" value="<php>echo $userinfo['user_id'];</php>" />
			<input type="submit" class="btn btn-primary btn-sm" value="确定" style="margin-left:-500px;"/>
			 <a href="javascript:history.go(-1);"><input type="button" class="btn btn-sm btn-primary" value="返回"></a> 
		</fieldset>
</form>

            </div>
        </section>
    </div>
</block>
<block name="js">
    <script src="__Assert__/js/SimpleTree.js"></script>

<script>
$(function() {
$( ".accordion" ).accordion();
var dom = $('#window_main');
var d = function(m){
	return dom.find(m);
}



/*点击前面的箭头展开收缩*/
$(".jiantou").click(function(){
    if($(this).parent().find(".jian").css("display")=="none"){
        $(this).html(' — ');
        $(this).parent().find(".jian").css("display","block");
    }
    else{
        $(this).parent().find(".jian").css("display","none"); 
        $(this).html(' ┿ ');
    } 
});

/*点击前面的箭头展开收缩*/
$(".jian").click(function(){
if($(this).find(".jian1").css("display")=="none"){
$(this).find(".jian1").css("display","block");}
else $(this).find(".jian1").css("display","none");
});

$('.leve2').click(function(e){
	e.stopPropagation();
});

$('.jian1').click(function(e){
	e.stopPropagation();
});

//全选与全不选
$(":checkbox[name=all]").click(function () {
    if ($(this).is(":checked")) {
        $(":checkbox").prop("checked", true);
    } else {
        $(":checkbox").prop("checked", false);
    }
});
//level 选中的时候，level1和level2都选中
//level 不选中的时候level1和level2都不选中
//level1选中的时候level选中，level2都选中
//level1不选中的时候level2都不选中
//leve2选中的时候level1选中，level选中

$(".leve1").click(function(){
    if($(this).is(":checked")){
        $(this).parent().find("input[type=checkbox]").prop("checked",$(this).prop("checked"));
         $(this).parent().find(".leve3").prop('checked',true);
         adjust1();
    }else{
         $("#all").prop('checked',false);
        $(this).parent().find('input').prop('checked',false);
    }
     

});



function adjust1(){
	 var inputs=$('.access_sub input[type=checkbox]');
	 var count=0;
	 inputs.each(function(){
	 	if($(this).prop('checked')){
            count++;
     	}
	 });
	 if(inputs.length==count){
     	  $("#all").prop('checked',true);
     }
}



$(".leve2").click(function(e){
     var checked=$(this).prop('checked');
     if(checked){
     	$(this).parent().find('input').prop('checked',true);
     	$(this).parent().parent().find('input').eq(0).prop('checked',true);
     	adjust1();
     }else{
     	$(this).parent().find('input').prop('checked',false);
        //console.log($(this).parent().get(0).className);
        var _this=$(this);
        var jians=$(this).parent().parent().find('.jian');
        var count=0;
        jians.each(function(){
        	if($(this)!=_this){
        		 if($(this).find('input').eq(0).prop('checked')){
        		 	  count++;
        		 }
        	}
        });
        if(!count){
        	$(this).parent().parent().find('input').eq(0).prop('checked',false);
        }
     	$("#all").prop('checked',false);
     }
      
});


$(".leve3").click(function(){
    
    if($(this).prop('checked')){
        $(this).parents('.jian').find('input').eq(0).prop('checked',true);
        $(this).parents('fieldset').find('input').eq(0).prop('checked',true);
        adjust1();
    }else{
    	var _this=$(this);
    	var jian1s=$(this).parents('fieldset').find('.jian1');
    	var count=0;
        jian1s.each(function(){
             if(_this!=$(this)){
             	 if($(this).find('input').eq(0).prop('checked')){
             	 	count++;
             	 }
             }
        });
         if(!count){
        	$(this).parents('.jian').find('input').eq(0).prop('checked',false);
        }

        var jians=$(this).parents('fieldset').find('.jian');
        var count2=0;
        jians.each(function(){
        	if($(this).find('input').eq(0).prop('checked')){
        		count2++;
        	}
        });
         if(!count2){
        	$(this).parents('fieldset').find('input').eq(0).prop('checked',false);
        }
        $("#all").prop('checked',false);
    }
     
});

// /*点击复选框后的文字也展开收缩*/
// $(".leve1").next().css("cursor","pointer");
// $(".leve1").next().click(function(){
// if($(this).parent().find(".box").css("display")=="none"){
// $(this).parent().find(".box").css("display","block");}
// else $(this).parent().find(".box").css("display","none");
// });



// d(".leve2").click(function(){
// 	if($(this).attr("checked")){
// 		$(this).prevAll(".leve1").attr('checked',true);
// 	}else{
// 		var sign = false;
// 		$(this).siblings('.leve2').each(function(i){
// 			if($(this).attr('checked')){
// 				sign = true;
// 				return false;
// 			}
// 		});
// 		if(sign == false){
// 			$(this).prevAll(".leve1").attr('checked',false);
// 		}
// 	}
// });













    // $("#all").click(function(){
    //     var status = $(this).attr("checked");
    //     $(":checkbox").attr("checked",status);
    // });
        $(".node").click(function(){
        $(this).parent().parent().find("input[type=checkbox]").prop("checked",$(this).prop("checked"));
    });

// $('.access_sub').submit(function(){
// 	var link = 'doAccess';
// 	var data = $(this).serializeArray();
// 	var sub = $(this).find(":submit");
//     sub.attr('sub',sub.val());
//     sub.val('提交中...');
//     sub.attr('disabled','disabled');
// 	$.ajax({url: link, 
// 		type: 'post', 
// 		data:data,
// 		dataType: 'json', 
// 		// timeout: 10000, 
// 		error: function(){alert('请求错误,请检查网络!');},
// 		success: function(result){
// 			alert(result);
// 			// if(result.status==1){
// 			// 	art.dialog({
// 			// 		content:result.info,
// 			// 		time:3000,
// 			// 	})
// 			// 	setTimeout(function(){
// 			// 		history.go(-1);
// 			// 	},1000);
// 			// }else{
// 			// 	art.dialog({
// 			// 		content:result.info,
// 			// 	});
// 			// 	sub.attr('sub',sub.val());
// 		 //        sub.val('提交');
// 		 //        sub.attr('disabled','false');
// 			// }
// 		}});
// 	return false;
	
// });

//全选全不选 与 勾选父节点
	// $(":checkbox[name=all]").click(function(){
	// 	alert($(this).attr("checked").val());
	// 	if($(this).attr("checked")){ 
	// 		$(this).parent().find("input[type=checkbox]").prop("checked",$(this).prop("checked"));
	// 		//$(":checkbox").attr("checked",'checked');
	// 	}else{ 
	// 		$(":checkbox").attr("checked",false);
	// 	}
		
	// });


	

    


});

</script>
</block>