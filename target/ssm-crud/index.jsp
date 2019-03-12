<%--
  Created by IntelliJ IDEA.
  User: yoona
  Date: 2019/3/10
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--WEB路径问题：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
以/开始的相对路径，找资源，以服务器的路径为标准--%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工页</title>
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <%--js要放在BootStrap前面--%>
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <br>
    <br>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th style="text-align: center">#</th>
                    <th style="text-align: center">名字</th>
                    <th style="text-align: center">性别</th>
                    <th style="text-align: center">邮箱</th>
                    <th style="text-align: center">部门</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6">
            <br>
            当前页，总页，总条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a> </li>

                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a> </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<script type="application/javascript">
    $(function () {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=1",
            type:"GET",
            success:function (result) {
               build_emps_table(result);
            }
        })
    });
    // 构建表格
    function build_emps_table(result) {
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIdTd =$("<td style=\"text-align: center\"></td>").append(item.empId);
            var empNameTd = $("<td style=\"text-align: center\"></td>").append(item.empName);
            var genderTd =$("<td style=\"text-align: center\"></td>").append(item.gender);
            var emailTd = $("<td style=\"text-align: center\"></td>").append(item.email);
            var deptNameTd=$("<td style=\"text-align: center\"></td>").append(item.department.deptName);
            // <button class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>编辑 </button>
            var editBtn=$("<button></button>").addClass("btn btn-success btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            // 创建一个单元格,将两个按钮添加到一个单元格中(td)中
            var btnTd=$("<td style=\"text-align: center\"></td>").append(editBtn).append(  ).append(delBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    // 构建标签
    function build_page_nav(result) {

    }
</script>
</body>
</html>
