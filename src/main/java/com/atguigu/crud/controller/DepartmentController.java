package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.beans.Department;
import com.atguigu.crud.beans.MSG;
import com.atguigu.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 */
@Controller
@ResponseBody
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;


    /**
     * 返回所有的部门信息
     */
	@RequestMapping("/depts")
	public MSG getDepts() {

		List<Department> list = departmentService.getAll();

		return MSG.success().add("depts", list);
	}

}
