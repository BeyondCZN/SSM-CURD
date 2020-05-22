package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.beans.Department;
import com.atguigu.dao.DepartmentMapper;
@Service
public class DepartmentService {
	
	@Autowired
	private  DepartmentMapper departmentMapper;
	
	public List<Department> getAll() {
		
		return departmentMapper.selectByExample(null);
	}

}
