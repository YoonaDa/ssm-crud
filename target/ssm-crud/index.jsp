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
    pageContext.setAttribute("APP_PATH", request.getContextPath());
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
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="application/javascript">
    $(function () {
        //去首页
        to_page(1);
    });

    // 构建表格
    function build_emps_table(result) {
        //清空table表格，以防数据重复
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td style=\"text-align: center\"></td>").append(item.empId);
            var empNameTd = $("<td style=\"text-align: center\"></td>").append(item.empName);
            var genderTd = $("<td style=\"text-align: center\"></td>").append(item.gender);
            var emailTd = $("<td style=\"text-align: center\"></td>").append(item.email);
            var deptNameTd = $("<td style=\"text-align: center\"></td>").append(item.department.deptName);
            // <button class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>编辑 </button>
            // var editBtn=$("<button></button>").addClass("btn btn-success").append($("<span aria-hidden=\"true\"></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var editBtn = $("<button></button>").addClass("btn btn-success").append($("<span aria-hidden=\"true\" class='glyphicon glyphicon-pencil'></span>").append("编辑"));
            var delBtn = $("<button></button>").addClass("btn btn-danger").append($("<span aria-hidden=\"true\"></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            // 创建一个单元格,将两个按钮添加到一个单元格中(td)中
            var btnTd = $("<td style=\"text-align: center\"></td>").append(editBtn).append("  ").append(delBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    function to_page(pn) {

        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn="+pn,
            type: "GET",
            success: function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        })
    }



    // 解析构建分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总" +
            result.extend.pageInfo.pages + "页，总" +
            result.extend.pageInfo.total + "条记录");
    }

    // 解析构建显示分页条
    // 原本的分页条
    // <nav aria-label="Page navigation">
    //     <ul class="pagination">
    //     <li>
    //     <a href="#" aria-label="Previous">
    //     <span aria-hidden="true">&laquo;</span>
    // </a>
    // </li>
    // <li><a href="#">1</a></li>
    // <li><a href="#">2</a></li>
    // <li><a href="#">3</a></li>
    // <li><a href="#">4</a></li>
    // <li><a href="#">5</a></li>
    // <li>
    // <a href="#" aria-label="Next">
    //     <span aria-hidden="true">&raquo;</span>
    // </a>
    // </li>
    // </ul>
    // </nav>

    // 动态构建分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        //上一页
        var prePageLi = $("<li></li>").append($("<a aria-label=\"Previous\"></a>").append($("<span aria-hidden=\"true\"></scan>").append("&laquo;")));
        if(result.extend.pageInfo.hasPreviousPage === false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击翻页的事件
            //首页按钮触发事件
            firstPageLi.click(function () {
                to_page(1);
            });
            // 上一页触发事件
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }
        //下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("aria-label","Next").append($("<span aria-hidden=\"true\"></scan>").append("&raquo;")));
        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if(result.extend.pageInfo.hasNextPage === false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            //下一页触发事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum +1);
            });
            //末页触发事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum === item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
</script>
</body>
</html>
