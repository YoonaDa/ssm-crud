package com.crud.service;

import com.crud.bean.Employee;
import com.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/10
 * @Time: 9:01 PM
 */
@Service
public class EmployeeService {

    @Autowired

    private EmployeeMapper employeeMapper;

    /**
     *
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }
}
