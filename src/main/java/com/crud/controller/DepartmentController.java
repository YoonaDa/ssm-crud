package com.crud.controller;


import com.crud.bean.Department;
import com.crud.common.Msg;
import com.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/17
 * @Time: 4:00 PM
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired

    private DepartmentService departmentService;


    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {

        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }

}
