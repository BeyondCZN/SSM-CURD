package com.atguigu.crud.beans;

import java.util.HashMap;
import java.util.Map;

/**
 * 对JSON数据进行扩充 添加状态码和提示信息 100-处理成功 200-处理失败
 * 
 * @author 阿楠
 *
 */
public class MSG {
	//状态码  100-成功  200-失败
	private String code;
    //提示信息
	private String msg;
    //用户返回给浏览器的数据
	private Map<String, Object> extend = new HashMap<>();

	public static MSG success() {
		MSG result = new MSG();
		result.setCode("100");
		result.setMsg("处理成功！");
		return result;
	}

	public static MSG fail() {
		MSG result = new MSG();
		result.setCode("200");
		result.setMsg("处理失败！");
		return result;
	}

	public MSG add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}
