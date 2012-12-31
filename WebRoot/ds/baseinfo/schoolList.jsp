<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../../base.jsp" %>
    <title>校区管理</title>
</head>

<body>

    <table id="datas" class=""></table>
	<div id="dlg" class="easyui-dialog" style="width:400px;height:300px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" MFASFD>
			<input name="IDSCHOOL_LIST" id="IDSCHOOL_LIST" type="hidden">
		<table border="0" cellpadding="0" cellspacing="0" class="formTable" width="100%" style="margin:auto;">
	        <tbody>
	        <tr>
	            <th>校区名称:</th>
	            <td><input type="text" name="SCHOOL_NAME" id="SCHOOL_NAME" maxlength="100" class="input150" ><span style="color: red;">*</span></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>校区电话:</th>
	            <td><input type="text"  name="SCHOOL_TEL"  id="SCHOOL_TEL" maxlength="20" class="input150" ><span style="color: red;">*</span></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>校区热线:</th>
	            <td><input type="text" name="SCHOOL_TEL2"  id="SCHOOL_TEL2" maxlength="20" class="input150" ></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>校区传真:</th>
	            <td><input name="SCHOOL_FAX"  id="SCHOOL_FAX" maxlength="20" class="input150"></td>
	            <tr>
	        </tr>
	        <tr>
	            <th>校区地址:</th>
	            <td><textarea name="SCHOOL_ADDRESS"  id="SCHOOL_ADDRESS" maxlength="300" cols=30 rows=5 ></textarea></td>
	            <tr>
	        </tr>
	            </tbody>
				</form>
		</div>
		<div id="dlg-buttons" style="text-align: center">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveData()">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
</body>
<script type="text/javascript">
    function loadTable() {
        $('#datas').datagrid({
            title:'校区管理',//表格标题
            iconCls:'icon-search',//标题样式
            height:470,
            nowrap:true,//不换行 
            striped: true,//隔行换色
            url:'baseinfo!findList.action',
            loadMsg:'查询中,请等待...',  
            remoteSort:false, 
            queryParams : {
                sqlName : 'schoollist.list',
                "conditions.SCHOOL_FLAG" : ${sessionScope.school_id}
            },
            columns:[
                [
                    {field:'rd',checkbox:true},
                    {title:'1',field:'IDSCHOOL_LIST',hidden:true},
                    {title:'校区名称',field:'SCHOOL_NAME',width:100,sortable:true},
                    {title:'校区电话',field:'SCHOOL_TEL',width:100,sortable:true},
                    {title:'校区热线',field:'SCHOOL_TEL2',width:100,sortable:true},
                    {title:'校区传真',field:'SCHOOL_FAX',width:100,sortable:true},
                    {title:'校区地址',field:'SCHOOL_ADDRESS',width:400,sortable:true}
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
                    text:'删除',
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
		$('#dlg').dialog('open').dialog('setTitle','新增校区');
		$('#fm').form('clear');
		sqlName="schoollist.insert";
	}
	function editData(){
		var row = $('#datas').datagrid('getSelected');
		if (row){
			$('#dlg').dialog('open').dialog('setTitle','修改校区');
			$('#fm').form('load',row);
		}
		sqlName="schoollist.update";
		
	}
	
	function saveData(){
		if(isNull($('#SCHOOL_NAME').val())){
			$.messager.alert( '提示', "校区名称不能为空!");
			return false;
			}
		if(isNull($('#SCHOOL_TEL').val())){
			$.messager.alert( '提示', "校区电话不能为空!");
			return false;
			}
			 $.post("baseinfo!addSave.action", {
	             Action: "post",
	             "conditions.IDSCHOOL_LIST" : $('#IDSCHOOL_LIST').val(),
	             "conditions.SCHOOL_NAME" : $('#SCHOOL_NAME').val(),
	             "conditions.SCHOOL_TEL" : $('#SCHOOL_TEL').val(),
	             "conditions.SCHOOL_TEL2" : $('#SCHOOL_TEL2').val(),
	             "conditions.SCHOOL_FAX" : $('#SCHOOL_FAX').val(),
	             "conditions.SCHOOL_ADDRESS" : $('#SCHOOL_ADDRESS').val(),
	             "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
	             sqlName : sqlName
	
	         },
	               function (data, textStatus) {
	                   if (data.tip == 'success') {
	                	   $.messager.alert( '提示', "保存成功!"); 
	                       $('#dlg').dialog('close');		// close the dialog
	           			   $('#datas').datagrid('reload');	// reload the user data 
	                   } else {
	                	   $.messager.alert( '提示', "保存失败!"); 
	                   }
	               }, "json")
	}
	function removeData(){
		var row = $('#datas').datagrid('getSelected');
		if (row){
			$.messager.confirm('确认','是否删除选中记录?',function(r){
				if (r){
					$.post('baseinfo!del.action',{
						"conditions.IDSCHOOL_LIST":row.IDSCHOOL_LIST,
						sqlName : "schoollist.del"
						},function(data){
						if (data.tip == 'success'){
							$.messager.alert( '提示', "删除成功!"); 
							$('#data').datagrid('reload');	// reload the user data
						} else {
							$.messager.alert( '提示', "删除失败!"); 
						}
					},'json');
				}
			});
		}
	}
    function search() {
        loadTable();//查询
    }
    loadTable();//默认加载表格
</script>
</html>
