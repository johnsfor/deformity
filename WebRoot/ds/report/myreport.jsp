<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../../base.jsp" %>
    <script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
    <title>报表</title>
</head>

<body>
<table border="0" cellpadding="0" cellspacing="0" class="formTable" width="100%" style="margin:auto;">
			        <tbody>
			        <tr>
			            <th>学员姓名：</th>
			            <td><input id="S_STU_NAME" type="text" class="input150" value=""/></td>
			            <th>联系电话：</th>
			            <td><input  id="S_PHONE" type="text" class="input150"/></td>
			            <th>联系地址：</th>
			            <td><input  id="S_ADDR" type="text" class="input150"/></td>
			             </tr> 
			             <tr>
			            <th>班别：</th>
			            <td><select  id="S_TIME_TYPE"  class="input150"></select></td>
			            <th>报名校区：</th>
			            <td><select  id="S_SCHOOL_TYPE" class="input150"/></select></td>
			            <th>考场：</th>
			            <td><select  id="S_CLASS_TYPE" class="input150"/></select></td>
			            </tr>
			             <tr>
			            <th>报名时间：</th>
	                    <td><input id="B_DATE" class="Wdate" maxlength="10" style="width:100px" 
	                    readyOnly="readyOnly" onfocus="WdatePicker()"/>-<input id="E_DATE" class="Wdate" maxlength="10" style="width:100px" 
	                    readyOnly="readyOnly" onfocus="WdatePicker()"/>
	                   <th>驾照类型:</th>
				       <td><select name="CAR_TYPE_ID" id="CAR_TYPE_ID"  class="input150"></select></td>	
			            <td colspan="2" style="text-align:center">
			            <input type="button" name="search" id="search" value="查询" class="btn1" onclick="search()">
						<input type="button" name="search" id="search" value="导出" class="btn1" onclick="exp()">
			             </td>
			            </tr>
			        </tbody>
			    </table>
    <table id="data"></table>
    <iframe id="expList" src="" style="display:none;"></iframe>
    
</body>
<script type="text/javascript">
  jQuery.noConflict();
    function loadTable() {
        jQuery('#data').datagrid({
            title:'报表',//表格标题
            iconCls:'icon-search',//标题样式
            height:380,
            nowrap:true,//不换行 
            striped: true,//隔行换色
            pageSize: 10,  
            pageList: [10,50,100],
            url:'stuinfo!findList.action',
            remoteSort:false,
            loadMsg:'查询中,请等待...',
     
            queryParams : {
                sqlName : 'stuinfo.list',
                "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id}
            },
           
            columns:[
                [
                    {title:'1',field:'STU_ID',hidden:true},
                    {title:'学员编号',field:'STU_CODE',width:50,sortable:true},
                    {title:'户籍',field:'LICENSE_ADDR',width:50,sortable:true},
                    {title:'户籍',field:'LICENSE_ADDR_ID',hidden:true},
                    {title:'学员姓名',field:'STU_NAME',width:60,sortable:true},
                    {title:'性别',field:'SEX',width:30,sortable:true},
                    {title:'性别',field:'SEX_ID',hidden:true},
                    {title:'身份证号',field:'CARD_ID',width:120,sortable:true},
                    {title:'联系电话',field:'PHONE',width:80,sortable:true},
                    {title:'车型',field:'CAR_TYPE',width:30,sortable:true},
                    {title:'车型',field:'CAR_TYPE_ID',hidden:true},
                    {title:'班别',field:'TIME_TYPE',width:50,sortable:true},
                    {title:'班别',field:'TIME_TYPE_ID',hidden:true},
                    {title:'报名校区',field:'SCHOOL_TYPE',width:70,sortable:true},
                    {title:'报名校区',field:'SCHOOL_TYPE_ID',hidden:true},
                    {title:'考场',field:'CLASS_TYPE',width:40,sortable:true},
                    {title:'考场',field:'CLASS_TYPE_ID',hidden:true},
                    {title:'报名时间',field:'BEGIN_DATE',width:70,sortable:true},
                    {title:'费用',field:'MONEY',width:40,sortable:true},
                    {title:'联系地址',field:'ADDR',width:200,sortable:true},
                    {title:'备注',field:'NOTE',width:180,sortable:true}
                ]
            ],
            pagination:true,   //分页工具
            rownumbers:true,   //行标识
            singleSelect:true//是否只能选择一行
            
        });
    }
    var url="";
    var sqlName="";
 
	function search(){
		jQuery('#data').datagrid('reload',{
            sqlName : 'stuinfo.list',
            "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
            "conditions.STU_NAME" : nullToEmpty(jQuery('#S_STU_NAME').val()),
            "conditions.PHONE" : nullToEmpty(jQuery('#S_PHONE').val()),
            "conditions.ADDR" : nullToEmpty(jQuery('#S_ADDR').val()),
            "conditions.TIME_TYPE" : nullToEmpty(jQuery('#S_TIME_TYPE').val()),
            "conditions.SCHOOL_TYPE" : nullToEmpty(jQuery('#S_SCHOOL_TYPE').val()),
            "conditions.CAR_TYPE_ID" : nullToEmpty(jQuery('#CAR_TYPE_ID').val()),
            "conditions.B_DATE" : nullToEmpty(jQuery('#B_DATE').val()),
            "conditions.E_DATE" : nullToEmpty(jQuery('#E_DATE').val()),
            "conditions.CLASS_TYPE" : nullToEmpty(jQuery('#S_CLASS_TYPE').val())
        });
	 }
	function exp(){
		var url= encodeURI('stuinfo!expAll.action?sqlName=stuinfo.exp&conditions.SCHOOL_FLAG_INT=${sessionScope.school_id}'
                + '&conditions.STU_NAME=' + nullToEmpty(jQuery('#S_STU_NAME').val())
                + '&conditions.PHONE=' + nullToEmpty(jQuery('#S_PHONE').val())
                + '&conditions.ADDR=' + nullToEmpty(jQuery('#S_ADDR').val())
                + '&conditions.TIME_TYPE=' + nullToEmpty(jQuery('#S_TIME_TYPE').val())
                + '&conditions.SCHOOL_TYPE=' + nullToEmpty(jQuery('#S_SCHOOL_TYPE').val())
                + '&conditions.CAR_TYPE_ID=' + nullToEmpty(jQuery('#CAR_TYPE_ID').val())
                + '&conditions.B_DATE=' + nullToEmpty(jQuery('#B_DATE').val())
                + '&conditions.E_DATE=' + nullToEmpty(jQuery('#E_DATE').val())
                + '&conditions.CLASS_TYPE=' + nullToEmpty(jQuery('#S_CLASS_TYPE').val())
                + '&conditions.fileName=report'
                + '&random=' + Math.random());
		document.getElementById("expList").src=url;
 }
    loadTable();//默认加载表格
    jQuery.post('stuinfo!findObjList.action', {//班别
        Action: 'post',
        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
        sqlName : 'common.getTimeType'
        },
        function (data, textStatus) {
          for (var i = 0; i < data.length; i++) {
              document.getElementById("S_TIME_TYPE").options[0] = new Option("全部", "");
              document.getElementById("S_TIME_TYPE").options[i+1] = new Option(data[i].OVALUE, data[i].OKEY);
          }
          document.getElementById("S_TIME_TYPE").value = "";
  	}, 'json'); 
    jQuery.post('stuinfo!findObjList.action', {//报名校区
        Action: 'post',
        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
        sqlName : 'common.getSchoolType'
        },
        function (data, textStatus) {
          for (var i = 0; i < data.length; i++) {
              document.getElementById("S_SCHOOL_TYPE").options[0] = new Option("全部", "");
              document.getElementById("S_SCHOOL_TYPE").options[i+1] = new Option(data[i].OVALUE, data[i].OKEY);
              
          }
          document.getElementById("S_SCHOOL_TYPE").value = "";
  	}, 'json'); 
    jQuery.post('stuinfo!findObjList.action', {//考场
        Action: 'post',
        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
        sqlName : 'common.getClassType'
        },
        function (data, textStatus) {
          for (var i = 0; i < data.length; i++) {
              document.getElementById("S_CLASS_TYPE").options[0] = new Option("全部", "");
              document.getElementById("S_CLASS_TYPE").options[i+1] = new Option(data[i].OVALUE, data[i].OKEY);
              
          }
          document.getElementById("S_CLASS_TYPE").value = "";
  	}, 'json'); 
    jQuery.post('stuinfo!findObjList.action', {//车型
        Action: 'post',
        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
        sqlName : 'common.getCarType'
        },
        function (data, textStatus) {
          for (var i = 0; i < data.length; i++) {
              document.getElementById("CAR_TYPE_ID").options[0] = new Option("全部", "");
              document.getElementById("CAR_TYPE_ID").options[i+1] = new Option(data[i].OVALUE, data[i].OKEY);
          }
          document.getElementById("CAR_TYPE_ID").value = "";
  	}, 'json'); 
</script>
</html>
