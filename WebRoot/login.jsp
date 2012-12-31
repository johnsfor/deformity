<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>驾校管理系统</title>

<link href="css/login-box.css" rel="stylesheet" type="text/css" />
</head>
<link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="css/themes/icon.css"/>
<link href="css/base.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<body style="background: url(images/bg.jpg) no-repeat left top;">


<div style="padding: 100px 0 0 250px;">
<div id="login-box" style="background: url(images/login-box-backg.png) no-repeat left top;">

<H2>驾校管理系统</H2>
<br />
<br />
<div id="login-box-name" style="margin-top:20px;">账户:</div>
<div id="login-box-field" style="margin-top:20px;">
<input name="q" class="form-login" title="Username" id="userName" value="" size="30" maxlength="2048" /></div>
<div id="login-box-name">密码:</div>
<div id="login-box-field"><input name="q" type="password" id="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
<br />
<br />
<br />
<a href="#"><img src="images/login-btn.png" onclick="login();" width="103" height="42" style="margin-left:90px;" /></a>
</div>

</div>
<script type="text/javascript">
document.getElementById("userName").focus();
document.onkeydown = function(event_e){  
    if( window.event )  
     event_e = window.event;  
     var int_keycode = event_e.charCode||event_e.keyCode;  
     if(int_keycode ==13){ 
    	 if(isNull($('#userName').val())){
    			return false;
    	 }
    		if(isNull($('#password').val())){
    			return false;
    	 }
    	 login();
    	 return false;      
}
} 
function login(){
	if(isNull($('#userName').val())){
		$.messager.alert( '提示', "请输入账户名称!");
		return false;
		}
	if(isNull($('#password').val())){
		$.messager.alert( '提示', "请输入密码!");
		return false;
		}
	 $.post("login!login.action", {
         Action: "post",
         userName : $('#userName').val(),
         password : $('#password').val()
     },
           function (data, textStatus) {
               if (data.tip == 'success') {
            	   window.location.href="index.jsp";
               } else {
            	   $.messager.alert( '提示', data.tip);
            	   $('#password').val(""); 
               }
           }, "json")
	
}
</script>
</body>
</html>
