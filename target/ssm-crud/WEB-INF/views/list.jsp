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
            <table class="table table-hover">
                <tr>
                    <th style="text-align: center">#</th>
                    <th style="text-align: center">名字</th>
                    <th style="text-align: center">性别</th>
                    <th style="text-align: center">邮箱</th>
                    <th style="text-align: center">部门</th>
                    <th style="text-align: center">操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th style="text-align: center">${emp.empId}</th>
                        <th style="text-align: center">${emp.empName}</th>
                        <th style="text-align: center">${emp.gender}</th>
                        <th style="text-align: center">${emp.email}</th>
                        <th style="text-align: center">${emp.department.deptName}</th>
                        <th style="text-align: center">
                            <button class="btn btn-success btn-sm">
                                <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash " aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6">
            <br>
            当前${pageInfo.pageNum}页，总${pageInfo.pages}页，总${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a> </li>
                    <%--判断是否有前一页--%>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <%--判断是否有下一页--%>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a> </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
