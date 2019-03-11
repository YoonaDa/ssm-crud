package com.crud.test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/10
 * @Time: 9:22 PM
 * 使用Spring测试模块提供的测试请求功能，测试crud其请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:dispatcherServlet.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    public void testPage() throws Exception{
        //模拟请求拿到返回值
        MvcResult result= mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();
        //请求成功后，请求
    }
}
