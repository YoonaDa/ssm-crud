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
    <script src="${APP_PATH}/static/toastr/toastr.js"></script>
    <link href="${APP_PATH}/static/toastr/toastr.scss" rel="stylesheet">
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
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
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

<%--模态框--%>
<!-- 添加员工Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input" name="empName"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>

                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_add_input" name="email"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">确定</button>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">
    <%--初始化弹出框插件的位置(上中等)--%>
    toastr.options.positionClass = 'toast-top-center';

    // 总记录数
    var totalRecord;

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
            var genderTd = $("<td style=\"text-align: center\"></td>").append(item.gender === 'M' ? "男" : "女");
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
            data: "pn=" + pn,
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
        totalRecord = result.extend.pageInfo.total;
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
        if (result.extend.pageInfo.hasPreviousPage === false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页的事件
            //首页按钮触发事件
            firstPageLi.click(function () {
                to_page(1);
            });
            // 上一页触发事件
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        //下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("aria-label", "Next").append($("<span aria-hidden=\"true\"></scan>").append("&raquo;")));
        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage === false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //下一页触发事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            //末页触发事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum === item) {
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

    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");

    }

    //点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function () {
        //表单重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示下拉列表中
        getDepts();
        $("#empAddModal").modal({
            //点击背景不消失
            backdrop: "static"
        })
    });
    //查出所有部门信息并显示在下拉列表中
    function getDepts() {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $("#empAddModal select").empty();
                // console.log(result);
                // $("#empAddModal select").append("")
                // {"code":200,"msg":"请求成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"},{"deptId":9,"deptName":"设计部"}]}}
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo("#empAddModal select");
                })
            }
        })
    }
    //校验表单数据
    function validate_add_form() {
        //1、拿到校验数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        // 正则表达式：校验用户名(3~16位)且允许使用中文(2~5位)
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名可以是2~5位中文或者6~16位英文");
            // $("#empName_add_input").parents().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2~5位中文或者6~16位英文");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        //2、校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱不符合标准");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }
    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parents().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" === status) {
            $(ele).parents().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parents().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = this.value;
       //发送ajax请求校验用户名是否可用
        $.ajax({
            url:'${APP_PATH}/checkUser',
            data:'empName='+empName,
            type:'POST',
            success: function (result) {
                if (result.code === 400){
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    //给其自定义一个属性
                    $("#emp_save_btn").attr("ajax-va","error");
                }else if (result.code ===200) {
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }
            }

        })

    });

    //新增modal的确定保存按钮
    $("#emp_save_btn").click(function () {
        //1、模态框中填写的表单数据提交给服务器进行保存
        //1、先要对提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //1、判断之前的ajax用户名校验是否成功.如果成功。
        if ($(this).attr("ajax-va")==="error"){
            return false;
        }
        //2、发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code === 200) {
                    toastr.success('新增员工成功');
                } else {
                    toastr.error('新增失败');
                }
                //1、关闭模态框
                $("#empAddModal").modal('hide');
                //2、来到最后一页显示，显示刚才保存的数据
                to_page(totalRecord);
            }
        })
    })
</script>
</body>
</html>
