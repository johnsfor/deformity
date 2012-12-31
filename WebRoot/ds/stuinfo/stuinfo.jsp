<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../../base.jsp" %>
    <script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
    <title>学员管理</title>
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
			             </tr> <tr>
			            <th>班别：</th>
			            <td><select  id="S_TIME_TYPE"  class="input150"></select></td>
			            <th>报名校区：</th>
			            <td><select  id="S_SCHOOL_TYPE" class="input150"/></select></td>
			            <th>考场：</th>
			            <td><select  id="S_CLASS_TYPE" class="input150"/></select></td>
			            </tr>
			            <tr>
			             <td colspan="6" style="text-align: center">
			             <input type="button" name="search" id="search" value="查询" class="btn1" onclick="search()">
			             </td>
			            </tr>
			        </tbody>
			    </table>
			    <br/>
    <table id="data"></table>
		<div id="dlg" class="easyui-dialog" style="width:600px;height:380px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
				<form id="fm" method="post" MFASFD>
							<input name="STU_ID" id="STU_ID" type="hidden">
		<table border="0" cellpadding="0" cellspacing="0" class="formTable" width="100%" style="margin:auto;">
	        <tbody>
	        <tr>
	            <th>学员编号:</th>
	            <td><input type="text" name="STU_CODE" id="STU_CODE" maxlength="100" class="input150" ><span style="color: red;">*</span></td>
	            <th>姓名:</th>
	            <td><input type="text" name="STU_NAME" id="STU_NAME"  maxlength="100" class="input150" ><span style="color: red;">*</span></td>
	            
	            <tr>
	        </tr>
	        <tr>
	            <th>性别:</th>
	            <td><select name="SEX_ID" id="SEX_ID">
	               <option value="1">男</option>
	               <option value="2">女</option>
	            </select><span style="color: red;">*</span></td>
	            <th>联系电话:</th>
	            <td><input type="text"  name="PHONE"  id="PHONE"   maxlength="20" class="input150" ><span style="color: red;">*</span></td>
	          </tr>
	        <tr>
	            <th>户籍:</th>
	            <td><select name="LICENSE_ADDR_ID" id="LICENSE_ADDR_ID">
	               <option value="1">本地</option>
	               <option value="2">外地</option>
	            </select><span style="color: red;">*</span></td>
	            <th>身份证号码:</th>
	            <td><input type="text"  name="CARD_ID"  id="CARD_ID" maxlength="20" class="input150" ></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>住址:</th>
	            <td colspan="3"><textarea name="ADDR"  id="ADDR" maxlength="300" cols=50 rows=2 ></textarea></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>报名时间:</th>
	            <td><input name="BEGIN_DATE" id="BEGIN_DATE" class="Wdate" maxlength="10" style="width:100px" readyOnly="readyOnly" onfocus="WdatePicker()"/>
	            <span style="color: red;">*</span></td>
	            <th>报名校区:</th>
	            <td><select name="SCHOOL_TYPE_ID" id="SCHOOL_TYPE_ID" class="input150"></select><span style="color: red;">*</span></td>
	            
	            <tr>
	        </tr>
	        <tr>
	        <th>课别:</th>
	            <td><select name="TIME_TYPE_ID" id="TIME_TYPE_ID"  class="input150"></select><span style="color: red;">*</span></td>
	            <th>驾照类型:</th>
				<td><select name="CAR_TYPE_ID" id="CAR_TYPE_ID"  class="input150"></select><span style="color: red;">*</span></td>	
				</tr>
	        <tr>
	            <th>考场:</th>
				<td><select name="CLASS_TYPE_ID"  id="CLASS_TYPE_ID"   class="input150"></select><span style="color: red;">*</span></td>	
	            <th><span style="color: blue;"><b>缴费金额:</b></span></th>
				<td><input name="MONEY" id="MONEY" maxlength="5" class="input150" 
				onpropertychange="if(isNaN(value)) value=value.substring(0,value.length-1);" ><span style="color: red;">*</span></td>	
	        </tr>
	         <tr>
	            <th>备注:</th>
	            <td colspan="3"><textarea name="NOTE" id="NOTE"  maxlength="300" cols=50 rows=2 ></textarea></td>
	            <tr>
	            </tbody>
				</form>
		</div>
		<div id="dlg-buttons" style="text-align: center">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveData()">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:jQuery('#dlg').dialog('close')">关闭</a>
	</div>
</body>
<script type="text/javascript">
  jQuery.noConflict();
   jQuery('BEGIN_DATE').attr("readonly","readonly");
    function loadTable() {
        jQuery('#data').datagrid({
            title:'学员管理',//表格标题
            iconCls:'icon-search',//标题样式
            height:380,
            nowrap:true,//不换行 
            striped: true,//隔行换色
            url:'stuinfo!findList.action',
            remoteSort:false,
            loadMsg:'查询中,请等待...',
     
            queryParams : {
                sqlName : 'stuinfo.list',
                "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id}
            },
           
            columns:[
                [
                    {field:'rd',checkbox:true},
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
            singleSelect:true,//是否只能选择一行
            toolbar:[
                {
                    text:'新增',
                    iconCls:'icon-add',
                    handler:function() {
                        newData();
                    }
                },
                {
                    text:'修改',
                    iconCls:'icon-cut',
                    //disabled:true,
                    handler:function() {
                	  editData();
                    }
                },
                '-',
                {
                    text:'作废',
                    iconCls:'icon-remove',
                    handler:function() {
                	 removeData();
                    }}
            ]
        });
    }
    var url="";
    var sqlName="";
    function newData(){
    	jQuery.post('stuinfo!findNumById.action', {//取出学员编码
	        Action: 'post',
	        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
	        sqlName : 'stuinfo.getUserCode'
	        },
	        function (data, textStatus) {
	        	jQuery('#STU_CODE').val(data.obj);
	  	}, 'json'); 
		jQuery('#dlg').dialog('open').dialog('setTitle','新增学员');
		jQuery('#fm').form('clear');
		sqlName="stuinfo.insert";
	}
	function editData(){
		var row = jQuery('#data').datagrid('getSelected');
		if (row){
			jQuery('#dlg').dialog('open').dialog('setTitle','修改学员');
			jQuery('#fm').form('load',row);
		}
		sqlName="stuinfo.update";
		
	}
	
	function saveData(){
		if(isNull(jQuery('#STU_CODE').val())){
			jQuery.messager.alert( '提示', "学员编码不能为空!");
			return false;
			}
		if(isNull(jQuery('#STU_NAME').val())){
			jQuery.messager.alert( '提示', "学员姓名不能为空!");
			return false;
			}
		if(isNull(jQuery('#SEX_ID').val())){
			jQuery.messager.alert( '提示', "性别不能为空!");
			return false;
			}
		if(isNull(jQuery('#PHONE').val())){
			jQuery.messager.alert( '提示', "联系电话不能为空!");
			return false;
			}
		if(isNull(jQuery('#LICENSE_ADDR_ID').val())){
			jQuery.messager.alert( '提示', "户籍不能为空!");
			return false;
			}
		if(isNull(jQuery('#BEGIN_DATE').val())){
			jQuery.messager.alert( '提示', "报名时间不能为空!");
			return false;
			}
		if(isNull(jQuery('#SCHOOL_TYPE_ID').val())){
			jQuery.messager.alert( '提示', "报名校区不能为空!");
			return false;
			}
		if(isNull(jQuery('#TIME_TYPE_ID').val())){
			jQuery.messager.alert( '提示', "课别不能为空!");
			return false;
			}
		if(isNull(jQuery('#CAR_TYPE_ID').val())){
			jQuery.messager.alert( '提示', "驾照类型不能为空!");
			return false;
			}
		if(isNull(jQuery('#CLASS_TYPE_ID').val())){
			jQuery.messager.alert( '提示', "考场不能为空!");
			return false;
			}
		if(isNull(jQuery('#MONEY').val())){
			jQuery.messager.alert( '提示', "缴费金额不能为空!");
			return false;
			}
		jQuery.post('stuinfo!findNumById.action', {//判断学员编码是否重复
	        Action: 'post',
	        "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
            "conditions.STU_CODE" : jQuery('#STU_CODE').val(),
	        sqlName : 'stuinfo.getUserCodeHas'
	        },
	        function (data, textStatus) {
		        if(data.obj==0) {
		        	jQuery.post("stuinfo!addSave.action", {
			             Action: "post",
			             "conditions.STU_ID" : jQuery('#STU_ID').val(),
			             "conditions.STU_NAME" : jQuery('#STU_NAME').val(),
			             "conditions.STU_CODE" : jQuery('#STU_CODE').val(),
			             "conditions.SEX_ID" : jQuery('#SEX_ID').val(),
			             "conditions.PHONE" : jQuery('#PHONE').val(),
			             "conditions.LICENSE_ADDR_ID" : jQuery('#LICENSE_ADDR_ID').val(),
			             "conditions.CARD_ID" : jQuery('#CARD_ID').val(),
			             "conditions.ADDR" : jQuery('#ADDR').val(),
			             "conditions.BEGIN_DATE" : jQuery('#BEGIN_DATE').val(),
			             "conditions.SCHOOL_TYPE_ID" : jQuery('#SCHOOL_TYPE_ID').val(),
			             "conditions.TIME_TYPE_ID" : jQuery('#TIME_TYPE_ID').val(),
			             "conditions.CAR_TYPE_ID" : jQuery('#CAR_TYPE_ID').val(),
			             "conditions.CLASS_TYPE_ID" : jQuery('#CLASS_TYPE_ID').val(),
			             "conditions.MONEY" : jQuery('#MONEY').val(),
			             "conditions.NOTE" : jQuery('#NOTE').val(),
			             "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
			             sqlName : sqlName
			
			         },
			               function (data, textStatus) {
			                   if (data.tip == 'success') {
			                	   jQuery.messager.alert( '提示', "保存成功!"); 
			                       jQuery('#dlg').dialog('close');		// close the dialog
			           			   jQuery('#data').datagrid('reload');	// reload the user data 
			                   } else {
			                	   jQuery.messager.alert( '提示', "保存失败!"); 
			                   }
			               }, "json")
			    }else{
			    	jQuery.messager.alert( '提示', "学院编码重复,请重新选择!");
					return false;}
	  	}, 'json'); 
			 
	}
	function removeData(){
		var row = jQuery('#data').datagrid('getSelected');
		if (row){
			jQuery.messager.confirm('确认','是否作废选中记录?',function(r){
				if (r){
					jQuery.post('stuinfo!addSave.action',{
						"conditions.STU_ID":row.STU_ID,
						sqlName : "stuinfo.del"
						},function(data){
						if (data.tip == 'success'){
							jQuery.messager.alert( '提示', "作废成功!"); 
							jQuery('#data').datagrid('reload');	// reload the user data
						} else {
							jQuery.messager.alert( '提示', "作废失败!"); 
						}
					},'json');
				}
			});
		}
	}
	function search(){
		jQuery('#data').datagrid('reload',{
            sqlName : 'stuinfo.list',
            "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
            "conditions.STU_NAME" : nullToEmpty(jQuery('#S_STU_NAME').val()),
            "conditions.PHONE" : nullToEmpty(jQuery('#S_PHONE').val()),
            "conditions.ADDR" : nullToEmpty(jQuery('#S_ADDR').val()),
            "conditions.TIME_TYPE" : nullToEmpty(jQuery('#S_TIME_TYPE').val()),
            "conditions.SCHOOL_TYPE" : nullToEmpty(jQuery('#S_SCHOOL_TYPE').val()),
            "conditions.CLASS_TYPE" : nullToEmpty(jQuery('#S_CLASS_TYPE').val())
        });
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
              document.getElementById("TIME_TYPE_ID").options[i] = new Option(data[i].OVALUE, data[i].OKEY);
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
              document.getElementById("SCHOOL_TYPE_ID").options[i] = new Option(data[i].OVALUE, data[i].OKEY);
              
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
              document.getElementById("CLASS_TYPE_ID").options[i] = new Option(data[i].OVALUE, data[i].OKEY);
              
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
              document.getElementById("CAR_TYPE_ID").options[i] = new Option(data[i].OVALUE, data[i].OKEY);
              
          }
  	}, 'json'); 
</script>
</html>
