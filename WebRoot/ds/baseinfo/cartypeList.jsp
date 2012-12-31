<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../../base.jsp" %>
    <title>车型管理</title>
</head>

<body>

    <table id="data" class=""></table>
<div id="dlg" class="easyui-dialog" style="width:400px;height:130px;" closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post" MFASFD>
		<input name="IDCAR_TYPE" id="IDCAR_TYPE" type="hidden">
		<table border="0" cellpadding="0" cellspacing="0" class="formTable" width="100%" style="margin:auto;">
        <tbody>
        <tr>
            <th>驾照类型：</th>
            <td><input type="text" name="CAR_TYPE" id="CAR_TYPE" maxlength="20" class="input150" ><span style="color: red;">*</span></td>
            <tr>
            </tr>
            <th>车辆类型：</th>
            <td><input type="text" name="CAR_TYPE_NAME" id="CAR_TYPE_NAME" maxlength="20" class="input150"><span style="color: red;">*</span></td>
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
            title:'车型管理',//表格标题
            iconCls:'icon-search',//标题样式
            height:470,
            nowrap:true,//不换行 
            striped: true,//隔行换色
            url:'baseinfo!findList.action',
            loadMsg:'查询中,请等待...', 
            remoteSort:false,
            queryParams : {
                sqlName : 'carType.list',
                "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id}
            },
           
            columns:[
                [
                    {field:'rd',checkbox:true},
                    {title:'1',field:'IDCAR_TYPE',hidden:true},
                    {title:'驾照类型',field:'CAR_TYPE',width:200,sortable:true},
                    {title:'车辆类型',field:'CAR_TYPE_NAME',width:200,sortable:true}
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
		$('#dlg').dialog('open').dialog('setTitle','新增车型');
		$('#fm').form('clear');
		sqlName="carType.insert";
	}
	function editData(){
		var row = $('#data').datagrid('getSelected');
		if (row){
			$('#dlg').dialog('open').dialog('setTitle','修改车型');
			$('#fm').form('load',row);
		}
		sqlName="carType.update";
		
	}
	
	function saveData(){
		if(isNull($('#CAR_TYPE').val())){
			$.messager.alert( '提示', "驾照类型不能为空!");
			return false;
			}
		if(isNull($('#CAR_TYPE_NAME').val())){
			$.messager.alert( '提示', "车辆类型不能为空!");
			return false;
			}
			 $.post("baseinfo!addSave.action", {
	             Action: "post",
	             "conditions.IDCAR_TYPE" : $('#IDCAR_TYPE').val(),
	             "conditions.CAR_TYPE" : $('#CAR_TYPE').val(),
	             "conditions.CAR_TYPE_NAME" : $('#CAR_TYPE_NAME').val(),
	             "conditions.SCHOOL_FLAG_INT" : ${sessionScope.school_id},
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
						"conditions.IDCAR_TYPE":row.IDCAR_TYPE,
						sqlName : "carType.del"
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
