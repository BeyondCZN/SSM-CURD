package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.beans.Employee;
import com.atguigu.crud.beans.MSG;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	//删除单个员工或者多个员工
	/**
     * 单个批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     * @param ids
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public MSG delEmp(@PathVariable("ids") String ids) {
		if(ids.contains("-")) {
			List<Integer> ids_list = new ArrayList<>();
			String[] ids_str = ids.split("-");
			for (String id_str : ids_str) {
				Integer id = Integer.parseInt(id_str);
				ids_list.add(id);
			}
			employeeService.deleteAllSelect(ids_list);
			return MSG.success();
		}else {
			Integer empid = Integer.parseInt(ids);
			employeeService.delEmp(empid);
			return MSG.success();
		}
	}
	
	
	// 更新员工数据
	/**
     * 解决方案
     * 要能支持直接发送PUT之类的请求，还要封装请求体中的数据
     * 1、配置上HttpputFormContentFilter；
     * 2、作用：将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * 员工更新方法
     * @param employee
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public MSG saveEmp(Employee employee) {
		System.out.println("employee = "+employee);
		employeeService.updateEmp(employee);
		return MSG.success();
	}
	
	// 根据id查询员工
	@ResponseBody
	@RequestMapping("/emp/{id}")
	public MSG getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return MSG.success().add("emp", employee);
	}

	// 查询员工姓名是否可用
	@ResponseBody
	@RequestMapping("/checkuser")
	public MSG checkuser(String empName) {

		// 对传过来的empName进行正则表达式校验，通过了才发请求到数据库查询是否重复
		String regex = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if (!empName.matches(regex)) {
			return MSG.fail().add("msg", "用户名为1-16英文数字(包括_和-)或2-5个中文的组合 ");
		}
		// 向数据库查询是否有重复的名字
		boolean b = employeeService.checkUser(empName);
		System.out.println(b);
		if (b) {
			return MSG.success();
		} else {
			return MSG.fail().add("msg", "抱歉！用户名重复，请更换一个！");
		}
	}

	// 新增员工
	/**
     * 员工保存
     * 1、支持jsr303校验
     * 2、导入Hibernate-Validator
     */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public MSG saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				System.out.println("错误的字段名" + fieldError.getField());
				System.out.println("错误的信息" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return MSG.fail().add("errorFields", map);
		} else {
			employeeService.addEmp(employee);
			return MSG.success();
		}
	}

	// 分页查询所有员工返回JSON数据
    /**
     * responsebody需要导入jackson包
     * @param pn
     * @return
     */
	@RequestMapping("/emps")
	@ResponseBody // 会将数据转换为JSON格式
	public MSG getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 第一个参数是传入的页码，第二个参数是页码的记录数
		// 在查询之前只需调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就可以了
		// 封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return MSG.success().add("pageInfo", page);
	}

	// @RequestMapping(value = "/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 第一个参数是传入的页码，第二个参数是页码的记录数
		// 在查询之前只需调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就可以了
		// 封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		// 将PageInfo对象交给页面
		model.addAttribute("pageInfo", page);// model相当于request.setAttribute，可以传入对象
		return "list";
	}
	
}
