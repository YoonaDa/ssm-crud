package com.crud.controller;

import com.crud.bean.Employee;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/10
 * @Time: 8:58 PM
 */
@Controller
public class EmployeeController {

    @Autowired

    private EmployeeService employeeService;


    /**
     * 查询员工数据(分页查询)
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询前只需要调用，传入页码，以及每页的大小
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }


}
