package com.crud.service;

import com.crud.bean.Department;
import com.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/17
 * @Time: 4:01 PM
 */
@Service
public class DepartmentService {

    @Autowired

    private DepartmentMapper departmentMapper;

    /**
     * 根据条件查所有，这里的条件为null
     * @return
     */
    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
