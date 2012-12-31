<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/themes/icon.css"/>
<link href="<%=basePath%>css/base.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
 <script type="text/javascript">
 //过滤没有登陆的用户
    var sessionFlag='<%=request.getSession().getAttribute("userName")%>';
    if(sessionFlag==null||sessionFlag=="null"){location.href = '/driveSchool/login!loginOut.action';}
 </script>