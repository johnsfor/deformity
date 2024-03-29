<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>驾校管理系统</title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="js/portal/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="js/portal/themes/icon.css" />
    <script type="text/javascript" src="js/portal/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="js/portal/jquery.easyui.min.1.2.2.js"></script>
	<script type="text/javascript" src='js/portal/outlook2.js'> </script>
    <script type="text/javascript" src="js/portal/easyui-lang-zh_CN.js"></script>
	
    <script type="text/javascript">
    var sessionFlag='<%=request.getSession().getAttribute("userName")%>';
    if(sessionFlag==null||sessionFlag=="null"){location.href = 'login!loginOut.action';}
    
	 var _menus = {"menus":[
						{"menuid":"200","icon":"icon-sys","menuname":"学员管理",
							"menus":[{"menuid":"201","menuname":"学员列表","icon":"icon-users","url":"ds/stuinfo/stuinfo.jsp"}
								]
						},{"menuid":"100","icon":"icon-sys","menuname":"基础信息管理",
							"menus":[{"menuid":"101","menuname":"车型管理","icon":"icon-type","url":"ds/baseinfo/cartypeList.jsp"},
									{"menuid":"102","menuname":"校区管理","icon":"icon-school","url":"ds/baseinfo/schoolList.jsp"},
									{"menuid":"103","menuname":"考场管理","icon":"icon-class","url":"ds/baseinfo/classList.jsp"},
									{"menuid":"104","menuname":"课别管理","icon":"icon-time","url":"ds/baseinfo/timeList.jsp"}
								]
						},{"menuid":"300","icon":"icon-sys","menuname":"报表",
							"menus":[{"menuid":"301","menuname":"流水账目","icon":"icon-nav","url":"ds/report/myreport.jsp"}
								]
						}
				]};
     //设置登录窗口
     function openPwd() {
         $('#w').window({
             title: '修改密码',
             width: 300,
             modal: true,
             shadow: true,
             closed: true,
             height: 160,
             resizable:false
         });
     }
     //关闭登录窗口
     function closePwd() {
         $('#w').window('close');
     }

     

     //修改密码
     function serverLogin() {
         var newpass = $('#txtNewPass').val();
         var rePass = $('#txtRePass').val();

         if (newpass == '') {
             msgShow('系统提示', '请输入密码！', 'warning');
             return false;
         }
         if (rePass == '') {
             msgShow('系统提示', '请在一次输入密码！', 'warning');
             return false;
         }

         if (newpass != rePass) {
             msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
             return false;
         }
         $.post("login!modifySave.action", {
             Action: "post",
             "conditions.USER_CODE" : '${sessionScope.userCode}',
             "conditions.USER_PASSWORD" : rePass,
             sqlName : "common.modPassword"

         },
               function (data, textStatus) {
                   if (data.tip == 'success') {
                	   $.messager.alert( '提示', '恭喜，密码修改成功！<br>您的新密码为：' + rePass); 
                	   $('#txtNewPass').val("");
                	   $('#txtRePass').val("");
                	   closePwd();
                   } else {
                	   $.messager.alert( '提示', "保存失败!"); 
                   }
               }, "json")
         
     }

     $(function() {

         openPwd();

         $('#editpass').click(function() {
             $('#w').window('open');
         });

         $('#btnEp').click(function() {
             serverLogin();
         })

		 $('#btnCancel').click(function(){closePwd();})

         $('#loginOut').click(function() {
             $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                 if (r) {
                     location.href = 'login!loginOut.action';
                 }
             });
         })
     });
		
		

 </script>

</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
 <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>
 <div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
     background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
     line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
     <span style="float:right; padding-right:20px;" class="head">欢迎 ${sessionScope.userName} <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
     <span style="padding-left:10px; font-size: 16px; "><img src="images/blocks.gif" width="20" height="20" align="absmiddle" /> ${sessionScope.school_name}驾校</span>
 </div>
 <div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
     <div class="footer">By @</div>
 </div>
 <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
<div id="nav" class="easyui-accordion" fit="true" border="false">
		<!--  导航内容 -->
				
			</div>

 </div>
 <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
     <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			<div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >
					<h1>
						<image src="images/home.png"></image>
					</h1>
			</div>
		</div>
 </div>
 
 
 <!--修改密码窗口-->
 <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
     background: #fafafa;">
     <div class="easyui-layout" fit="true">
         <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
             <table cellpadding=3>
                 <tr>
                     <td>新密码：</td>
                     <td><input id="txtNewPass" type="Password" class="txt01" /></td>
                 </tr>
                 <tr>
                     <td>确认密码：</td>
                     <td><input id="txtRePass" type="Password" class="txt01" /></td>
                 </tr>
             </table>
         </div>
         <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
             <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" >
                 确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
         </div>
     </div>
 </div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>--%>


</body>
</html>