<%@ page language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <%@ include file="../base.jsp" %>
    <title>列表</title>
</head>

<body>
<table width="99%" border="0" cellspacing="0" cellpadding="0" class="Treebg">
    <tr>
        <td class="ico5"></td>
        <td><a href="#">&nbsp;列表</a></td>
        <td class="ico0">&nbsp;</td>
    </tr>
</table>
<div style="width:98%;" class="p5">
    <table border="0" cellpadding="0" cellspacing="0" class="formTable" width="97%">
        <tbody>
        <tr>
            <th>查询条件</th>
            <td><input name="activityName" type="text" class="input150" id="activityId" value="2222"/></td>
            <th>查询条件</th>
            <td><input type="radio" name="shortProcess" value='all' checked="checked" id="id2"/>全部
                <input type="radio" name="shortProcess" value='Y'/>是
                <input type="radio" name="shortProcess" value='N'/> 否
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="p5" style="width:95%;">
    <table id="data"></table>
</div>
</body>
<script type="text/javascript">
    function loadTable() {
        $('#data').datagrid({
            title:'列表',//表格标题
            iconCls:'icon-search',//标题样式
            //width: 1000,
            height:400,
            pageSize: 15,  
            pageList: [5,10,15,20,30,40,50], 
            nowrap:true,//不换行 
            striped: true,//隔行换色
            url:'demo!findList.action',
            loadMsg:'查询中,请等待...',
            queryParams : {
                "conditions.id" :$('#activityId').val(),
                sqlName : 'demo.myList'
            },//分页条件
            frozenColumns:[
                [
                    {field:'rd',checkbox:true},
                    {title:'ID', field:'FIRST_NAME',width:50,sortable:true,
                        sorter:function(a, b) {
                            return (a > b ? 1 : -1);
                        }}
                ]
            ],//表格列冻结
            columns:[
                [
                    {title:'多表头',colspan:1},
                    {title:'多表头',colspan:2}
                ],
                [
                    {title:'名',   field:'FIRST_NAME', width :fixWidth(0.2),sortable:true},
                    {title:'姓',field:'LAST_NAME',width : fixWidth(0.1),sortable:true},
                    {title:'名',   field:'FIRST_NAME', width :fixWidth(0.2),sortable:true}
                ]
            ],
            fitColumns:true,
            pagination:true,   //分页工具
            rownumbers:true,   //行标识
            singleSelect:true,//是否只能选择一行
            toolbar:[
                {
                    text:'新增',
                    iconCls:'icon-add',
                    handler:function() {
                        $.messager.alert('新增', '新增!');
                        //window.open('add.jsp','_blank');
                    }
                },
                {
                    text:'修改',
                    iconCls:'icon-cut',
                    //disabled:true,
                    handler:function() {
                        $.messager.alert('修改', '修改!');
                    }
                },
                '-',
                {
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function() {
                        del();
                    }},
                '-',
                {
                    text:'下一步',
                    iconCls:'icon-ok',
                    handler:function() {
                        window.location.href = 'qryActivity.jsp';
                    }
                },
                {
                    text:'导出Excel',
                    iconCls:'icon-save',
                    handler:function() {
                        tableToExcel('datagrid');
                    }
                }
            ]
        });
    }
    function del() {  //删除操作
        var selectedRow = $('#data').datagrid('getSelected');  //获取选中行
        var rows = $('#data').datagrid('getSelections');//获取选中行列标识
        alert(rows[0]);
        if (isNull(selectedRow)) {
            $.messager.alert('请选择删除列', '请选择删除列!');
            return;
        }
        $.messager.confirm('确认', '确认删除?', function(row) {
            if (row) {
                $.ajax({
                    url:'demo!delById.action?id=' + selectedRow.CHANNEL_CD + "&random=" + Math.random(),
                    success:function() {
                        $.messager.alert('提示', '删除成功!');
                    }
                });
                $('#data').datagrid('deleteRow', rows[0]);
            }
        })
    }
    function search() {
        loadTable();//查询
    }
    loadTable();//默认加载表格
</script>
</html>
