package com.atguigu.tests;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.beans.Department;
import com.atguigu.crud.beans.Employee;
import com.atguigu.dao.DepartmentMapper;
import com.atguigu.dao.EmployeeMapper;
/**
 * 测试dao层工作
 * Spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration指定spring配置文件的位置
 * 3、直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired // byType类型自动注入
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCURD() {
		// 不推荐用下面这种
//		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
//		DepartmentMapper bean = ac.getBean(DepartmentMapper.class);
//		bean.insert(new Department(null,"开发部"));
		System.out.println(departmentMapper);
		// 插入部门
		departmentMapper.insert(new Department(null, "开发部"));
		// 插入员工
		employeeMapper.insert(new Employee(null, "张三", "M", "zhangsan@atguigu.com", 1));
		// 批量插入（采用批量操作的sqlSession的方法）
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insert(new Employee(null, uid, "M", uid+"@atguigu.com", 1));
		}
		
		System.out.println("ok");

	}
}
