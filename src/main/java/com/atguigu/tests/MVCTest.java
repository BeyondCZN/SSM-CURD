package com.atguigu.tests;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.beans.Employee;
import com.github.pagehelper.PageInfo;

/**
 * Spring-test模块提供的测试请求功能，测试curd请求的正确性
 * 
 * @author 阿楠
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // 传入SpringMVC的ioc容器
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:springmvc.xml" })
public class MVCTest {

	// 虚拟MVC请求，获取处理结果
	MockMvc mockMVC;

	// 传入SpringMVC的ioc容器
	@Autowired
	WebApplicationContext context;

	@Before
	public void initMockMVC() {
		mockMVC = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {
		// 模拟请求获取返回值
		MvcResult result = mockMVC.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();

		PageInfo pageInfo = (PageInfo) result.getRequest().getAttribute("pageInfo");

		int pageNum = pageInfo.getPageNum();
		System.out.println("当前请求的页数：" + pageNum);

		int pages = pageInfo.getPages();
		System.out.println("当前请求的总页数：" + pages);

		long total = pageInfo.getTotal();
		System.out.println("当前请求的总记录数：" + total);

		System.out.println("连续显示的页码数：");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" " + i);
		}

		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println("ID:" + employee.getEmpId() + " Name:" + employee.getEmpName());
		}
	}
}
