<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<style type="text/css">
			.row {
	    width: 50%;
	    text-align: center;
	    margin: 15% auto;
	    border: 1px solid #ccc;
	    box-shadow: 2px 2px 2px #efefef;
        padding-top: 20px;
			}
			.panel{margin:20px 0px;border:none;}
			.panel-title{color:#3c763d;}
			body{ background: #fff; font-family: '微软雅黑'; color: #333; font-size: 16px; }
		</style>
	</head>
<body>
<div class="container">
	<div class="row">
		<!--//放图片在这里-->
		<!-- <img src="__Assert__/img/success/gou.png"/> -->
		<?php 
			if($message['status']==1){ 
				echo '<img src="__Assert__/img/success/gou.png"/>';
			}else{ 
				echo '<img src="__Assert__/img/success/cha.png"/>';
				}
		?>
		
	<div class="panel">
	   <div class="panel-heading">
	   	
	      <h3 class="panel-title">
        
				系统提示：<?php if($message['status']==1){ 
						echo($message['msg']);
					}else{ 
						echo($error['msg']);
						}?>

	      </h3>
	   </div>
	   <div class="panel-body">
	      <span id='t'>1</span>秒后自动跳转，或直接点击<a href='http://admin.dym666.com/index.php/<?php if($message['status']==1){ 
						echo($message['href']);
					}else{ 
						echo($error['href']); }?>'> 这里</a>。
	   </div>
	</div>
</div>

<script type="text/javascript">
	
	setInterval(function(){ 
		t = parseInt( $("#t").html());

		if(t == 1)
		{ 
			window.location.href = $("a").attr("href");
		}
		else
		{
			t--;
			$("#t").html(t);
		
		}

	},1000);
</script>
</body>
<html>
