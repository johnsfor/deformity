<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../../base.jsp" %>
    <title>考场管理</title>
</head>

<body>

    <table id="data" class=""></table>
<div id="dlg" class="easyui-dialog" style="width:400px;height:130px;" closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post" MFASFD>
		<input name="IDCLASS" id="IDCLASS" type="hidden">
		<table border="0" cellpadding="0" cellspacing="0" class="formTable" width="100%" style="margin:auto;">
	        <tbody>
	        <tr>
	            <th>考场名称:</th>
	            <td><input type="text" name="CLASS_NAME" id="CLASS_NAME" maxlength="50" class="input150" ><span style="color: red;">*</span></td>
	            <tr>
	            </tr>
	            <th>考场描述:</th>
	            <td><input type="text" name="CLASS_DESC"  id="CLASS_DESC" maxlength="50" class="input150"></td>
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
        $('#data').datagrid({
            title:'考场管理',//表格标题
            iconCls:'icon-search',//标题样式
            height:470,
            nowrap:true,//不换行 
            striped: true,//隔行换色
            url:'baseinfo!findList.action',
            remoteSort:false,
            loadMsg:'查询中,请等待...',   
            queryParams : {
                sqlName : 'classlist.list',
                "conditions.SCHOOL_FLAG" : ${sessionScope.school_id}
            },
           
            columns:[
                [
                    {field:'rd',checkbox:true},
                    {title:'1',field:'IDCLASS',hidden:true},
                    {title:'考场名称',field:'CLASS_NAME',width:200,sortable:true},
                    {title:'考场描述',field:'CLASS_DESC',width:200,sortable:true}
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
		$('#dlg').dialog('open').dialog('setTitle','新增考场');
		$('#fm').form('clear');
		sqlName="classlist.insert";
	}
	function editData(){
		var row = $('#data').datagrid('getSelected');
		if (row){
			$('#dlg').dialog('open').dialog('setTitle','修改考场');
			$('#fm').form('load',row);
		}
		sqlName="classlist.update";
		
	}
	
	function saveData(){
		if(isNull($('#CLASS_NAME').val())){
			$.messager.alert( '提示', "考场名称不能为空!");
			return false;
			}
		
			 $.post("baseinfo!addSave.action", {
	             Action: "post",
	             "conditions.IDCLASS" : $('#IDCLASS').val(),
	             "conditions.CLASS_NAME" : $('#CLASS_NAME').val(),
	             "conditions.CLASS_DESC" : $('#CLASS_DESC').val(),
	             "conditions.SCHOOL_FLAG_INT" : 1,
	             sqlName : sqlName
	
	         },
	               function (data, textStatus) {
	                   if (data.tip == 'success') {
	                	   $.messager.alert( '提示', "保存成功!"); 
	                       $('#dlg').dialog('close');		// close the dialog
	           			   $('#data').datagrid('reload');	// reload the user data 
	                   } else {
	                	   $.messager.alert( '提示', "保存失败!"); 
	                   }
	               }, "json")
	}
	function removeData(){
		var row = $('#data').datagrid('getSelected');
		if (row){
			$.messager.confirm('确认','是否删除选中记录?',function(r){
				if (r){
					$.post('baseinfo!del.action',{
						"conditions.IDCLASS":row.IDCLASS,
						sqlName : "classlist.del"
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
