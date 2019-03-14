<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>用户登录 - 平台云管理平台 </title>
    <link rel="stylesheet" href="__Assert__/css/style.default.css" type="text/css"/>

    <script type="text/javascript" src="__Assert__/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="__Assert__/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="__Assert__/js/jquery-ui-1.9.2.min.js"></script>
    <script type="text/javascript" src="__Assert__/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="__Assert__/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="__Assert__/js/custom.js"></script>

    <script type="text/javascript">
        var APP = '{:U('Login/login')}';
        jQuery(document).ready(function () {
            jQuery('#login').submit(function () {
                var sub = $("#login_submit");
                sub.attr("sub", sub.val());
                sub.html("登录中... ");
                sub.attr("disabled", "disabled");
                var data = $(this).serializeArray();
                jQuery.ajax({
                    url: APP,
                    type: 'post',
                    data: data,
                    dataType: 'json',
                    error: function () {
                        alert('请求错误,请检查网络!');
                        //解除重复提交
                        sub.val(sub.attr('sub'));
                        sub.html("登录");
                        sub.attr('disabled', false);
                    },
                    success: function (result) {
                        if (result.status == 1) {
                            //alertmsg(result.msg, 'success');
                            setTimeout("window.location.href='/index.php/"+result.data+"'", 300);
                        } else {
                            //解除重复提交
                            sub.val(sub.attr('sub'));
                            sub.html("登录");
                            sub.attr('disabled', false);
                            alertmsg(result.msg, 'error');
                        }
                    }
                });
                return false;
            });
        });

        function alertmsg(msg, state) {
            jQuery('.login-alert').fadeIn();
            jQuery('.login-alert .alert').html(msg);
            if (state == 'success') {
                jQuery('.login-alert .alert').addClass('alert-success');
            } else {
                jQuery('.login-alert .alert').addClass('alert-error');
            }
        }
    </script>
</head>

<body class="loginpage">

<div class="loginpanel">
    <div class="loginpanelinner">
        <div class="logo animate0 bounceIn">
            <img src="__Assert__/img/aclogo.jpg" alt=""/>
            <h4 style="color:#fff;font-family: " Microsoft YaHei";">平台云管理平台</h4>
        </div>
        <form id="login" method="post">
            <div class="inputwrapper login-alert">
                <div class="alert alert-error">Invalid username or password</div>
            </div>
            <div class="inputwrapper animate1 bounceIn">
                <input type="text" name="phone" id="username" value="" style="font-size:15px;color:#fff" placeholder="手机号"/>
            </div>
            <div class="inputwrapper animate2 bounceIn">
                <input type="password" name="password" value="" id="password" style="font-size:15px;color:#fff" placeholder="密码"/>
            </div>
            <div class="inputwrapper animate3 bounceIn">
                <button name="submit" id="login_submit">登&nbsp;&nbsp;录</button>
            </div>

        </form>
    </div><!--loginpanelinner-->
</div><!--loginpanel-->

</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {

        var doc = document, inputs = doc.getElementsByTagName('input'), supportPlaceholder = 'placeholder' in doc.createElement('input'), placeholder = function (input){var text=input.getAttribute('placeholder'),defaultValue=input.defaultValue;
        if(defaultValue==''){
        input.value=text}
        input.onfocus = function () {
            if (input.value === text){this.value=''}};
        input.onblur = function (){if(input.value===''){this.value=text}}};
    if (!supportPlaceholder) {
        for (var i = 0, len = inputs.length; i < len; i++){var input=inputs[i],text=input.getAttribute('placeholder');
        if(input.type==='text'&&text){index.php(input)}}}
    })
    ;
</script> 