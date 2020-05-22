package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.beans.Employee;
import com.atguigu.crud.beans.EmployeeExample;
import com.atguigu.crud.beans.EmployeeExample.Criteria;
import com.atguigu.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 获取所有的员工
	 * 
	 * @return
	 */
	public List<Employee> getAll() {

		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 插入新增的员工
	 * 
	 * @param employee
	 */
	public void addEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 查询传入的员工姓名是否可用
	 * 
	 * @param empName
	 * @return true:说明员工姓名可用 false:说明员工姓名不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		// 创建查询条件
		Criteria criteria = example.createCriteria();
		// 给查询条件添加信息
		criteria.andEmpNameEqualTo(empName);
		// 获取数据库中emp_ame是传入的empName的数据记录条数
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	// 根据id查询员工
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	// 更新员工数据
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	// 删除单个员工
	public void delEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	//删除多个员工
	public void deleteAllSelect(List<Integer> ids_list) {
		EmployeeExample example = new EmployeeExample();
		//创建查询条件
		Criteria createCriteria = example.createCriteria();
		//给查询条件添加信息
		createCriteria.andEmpIdIn(ids_list);
		//根据信息去操作数据库 delete from tbl_emp where id in (1,2,4);
		employeeMapper.deleteByExample(example);
	}

}
