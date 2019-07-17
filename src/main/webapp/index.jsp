<%--
  Created by gaoxu.
  User: gaoxu
  Date: 2019/7/17 0017
  Time: 17:26
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic DataGrid - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script>
        var url;

        function deleteUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $.messager.confirm("系统提示", "您确定要删除这条记录吗?", function (r) {
                    if (r) {
                        $.post('user!delete', {delId: row.id}, function (result) {
                            if (result.success) {
                                $.messager.alert("系统提示", "已成功删除这条记录!");
                                $("#dg").datagrid("reload");
                            } else {
                                $.messager.alert("系统提示", result.errorMsg);
                            }
                        }, 'json');
                    }
                });
            }
        }

        function newUser() {
            $("#dlg").dialog('open').dialog('setTitle', '添加用户');
            $('#fm').form('clear');
            url = 'user!save';
        }


        function editUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $("#dlg").dialog('open').dialog('setTitle', '编辑用户');
                $("#name").val(row.name);
                $("#phone").val(row.phone);
                $("#email").val(row.email);
                $("#qq").val(row.qq);
                url = 'user!save?id=' + row.id;
            }
        }


        function saveUser() {
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.errorMsg) {
                        $.messager.alert("系统提示", result.errorMsg);
                        return;
                    } else {
                        $.messager.alert("系统提示", "保存成功");
                        $('#dlg').dialog('close');
                        $("#dg").datagrid("reload");
                    }
                }
            });
        }


        function exportUser() {
            window.open('user!export');
        }

        function exportUserByTemplate() {
            window.open('user!exportByTemplate');
        }

        function openUploadFileDialog() {
            $("#dlg2").dialog('open').dialog('setTitle', '批量导入数据');
        }

        function downloadTemplate() {
            window.open('template/userExporTemplate.xls');
        }

        function uploadFile() {
            $("#uploadForm").form("submit", {
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.errorMsg) {
                        $.messager.alert("系统提示", result.errorMsg);
                    } else {
                        $.messager.alert("系统提示", "上传成功");
                        $("#dlg2").dialog("close");
                        $("#dg").datagrid("reload");
                    }
                }
            });
        }

    </script>
</head>
<body>
<table id="dg" title="用户管理" class="easyui-datagrid" style="width:700px;height:365px"
       url="user!list"
       toolbar="#toolbar" pagination="true"
       rownumbers="true" fitColumns="true" singleSelect="true">
    <thead>
    <tr>
        <th field="id" width="50" hidden="true">编号</th>
        <th field="name" width="50">姓名</th>
        <th field="phone" width="50">电话</th>
        <th field="email" width="50">Email</th>
        <th field="qq" width="50">QQ</th>
    </tr>
    </thead>
</table>
<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
       onclick="editUser()">编辑用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="exportUser()">导出用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-export" plain="true"
       onclick="exportUserByTemplate()">用模版导出用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-import" plain="true"
       onclick="openUploadFileDialog()">用模版批量导入数据</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:250px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="10px;">
            <tr>
                <td>姓名：</td>
                <td><input id="name" name="user.name" class="easyui-validatebox" required="true" style="width: 200px;">
                </td>
            </tr>
            <tr>
                <td>联系电话：</td>
                <td><input id="phone" name="user.phone" class="easyui-validatebox" required="true"
                           style="width: 200px;"></td>
            </tr>
            <tr>
                <td>Email：</td>
                <td><input id="email" name="user.email" class="easyui-validatebox" validType="email" required="true"
                           style="width: 200px;"></td>
            </tr>
            <tr>
                <td>QQ：</td>
                <td><input id="qq" name="user.qq" class="easyui-validatebox" required="true" style="width: 200px;"></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg').dialog('close')">关闭</a>
</div>


<div id="dlg2" class="easyui-dialog" style="width:400px;height:180px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons2">
    <form id="uploadForm" action="user!upload" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>下载模版：</td>
                <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="downloadTemplate()">导入模版</a></td>
            </tr>
            <tr>
                <td>上传文件：</td>
                <td><input type="file" name="userUploadFile"></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons2">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="uploadFile()">上传</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg2').dialog('close')">关闭</a>
</div>

</body>
</html>
