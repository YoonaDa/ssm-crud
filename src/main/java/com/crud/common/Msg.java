package com.crud.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * @Email: m15602498163@163.com
 * @Author: yoonada
 * @Date: 2019/3/12
 * @Time: 8:47 PM
 */
@Data
public class Msg {

    private int code;

    private String msg;

    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){

        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("请求成功");
        return result;

    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(400);
        result.setMsg("请求出现错误");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }


}
