package com.crud.test;

import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/10
 * @Time: 6:58 PM
 * 测试dao层的工作
 * 推荐Spring的项目就可以使用Spring配置文件的位置
 * 1、导入SpringTest模块
 * 2、使用ContextConfiguration
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){

//        // 1.创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        // 2.从容器中获取mapper
//        DepartmentMapper bean =ioc.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);

//        1、插入几个部门
//        departmentMapper.insertSelective(new Department(null,"设计部"));
//        2、生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"林允儿","女",null,2));
//        3.批量新增信息
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=0;i<100;i++){
//            String uid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid,"男",uid+"@163.com",1));
//        }
//        System.out.println("批量新增完成");

    }

}
