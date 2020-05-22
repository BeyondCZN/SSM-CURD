<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
<!-- 引入jQuery文件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/static/jq/jquery-3.3.1.js"></script>
<!-- 引入css样式 -->
<link href="${pageContext.request.contextPath }/static/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入js文件 -->
<script src="${pageContext.request.contextPath }/static/dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 新增员工的模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加员工</h4>
      </div>
      
      <div class="modal-body">
      		<form class="form-horizontal">
      			<!-- 员工姓名栏 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="emp_add_empName_input" placeholder="zhangsan">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <!-- 员工emial栏 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="emp_add_email_input" placeholder="zhangsan@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <!-- 性别单选 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="emp_add_gender_inpurt1" value="M" checked> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="emp_add_gender_inpurt2" value="F"> 女
					</label>
			    </div>
			  </div>
			  
		  	<!-- 部门下拉列表 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<select class="form-control" name="dId" id="emp_add_dept_input"></select>
			    </div>
			  </div>
		</form>
     </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_add_save">保存</button>
      </div>
    </div>
  </div>
</div>

												<!-- 员工修改的模态框 -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工信息修改</h4>
      </div>
      <div class="modal-body">
      		<form class="form-horizontal">
      			<!-- 员工姓名栏 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			       <p class="form-control-static" id = "emp_update_empName_static"></p>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <!-- 员工emial栏 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="emp_update_email_input" placeholder="zhangsan@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <!-- 性别单选 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="emp_udpate_gender_inpurt1" value="M" checked> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="emp_update_gender_inpurt2" value="F"> 女
					</label>
			    </div>
			  </div>
			  
			  <!-- 部门下拉列表 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<select class="form-control" name="dId" id="emp_update_dept_input">
					</select>
			    </div>
			  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_save">更新</button>
      </div>
    </div>
  </div>
</div>

	<div class = "container">
		<!-- 显示项目名 -->
		<div class = "row">
			<div class="col-md-12">
				<h1>SSM-CURD</h1>@CZN
			</div>
		</div>
		<!-- 显示新增和删除按钮 -->
		<div class = "row">
			<div class="col-md-2 col-md-offset-9">
				<button type ="button" class = "btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type ="button" class = "btn btn-danger" id="emp_delete_all_btn">批量删除</button>
			</div>
		</div>
		
		<!-- 显示表格 -->
		<table class = "table table-hover" id = "emps_table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id = "check_all"/>
					</th>
					<th>#</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>department</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		
		<!-- 显示分页 -->
		<div class = "row">
			<!-- 分页文字信息 -->
			<div class ="col-md-7" id = "page_info_areas" ></div>
			<div class ="col-md-5" id = "page_info_nav" ></div>
		</div>
	</div>
	
	<script type="text/javascript">
		var totalRecords,currentPage;
		$(function(){
			//页面加载完毕默认跳转到第一页
			to_page(1)
		})
		
		//该函数负责发送AJAX请求，跳转到指定的页面
		function to_page(pn){
			$.ajax({
				url:"${pageContext.request.contextPath}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					/* console.log(result) */
					//1.解析并显示员工数据
					build_emp_table(result)
					//2.解析并显示分页数据
					build_page_areas(result)
					//3.解析并显示分页条
					build_page_nav(result)
				}
				
			})
		}
		
		//1.解析并显示员工数据
		function build_emp_table(result){
			$("#emps_table tbody").empty(); //发送新的AJAX请求之后要把原来的数据清空
			var emps = result.extend.pageInfo.list
			//拼接表单数据
			$.each(emps,function(index,emp){
				var checkBoxTd = $("<td><input type = 'checkbox' class = 'check_item'/></td>")
				var empIdTd = $("<td></td>").append(emp.empId).addClass("active");
				var empNameTd= $("<td></td>").append(emp.empName).addClass("active");
				var genderTd = $("<td></td>").append(emp.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(emp.email);
				var deptNameTd = $("<td></td>").append(emp.department.deptName)
				var editBtnTd = $("<button></button>")
								.addClass("btn btn-primary btn-sm edit_btn emp_update")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
								.append("编辑")
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
            	editBtnTd.attr("edit_id",emp.empId);
				var delBtnTd = $("<button></button>")
								.addClass("btn btn-danger btn-sm del_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
								.append("删除")
				//为删除按钮添加一个自定义的属性，来表示当前员工id
				delBtnTd.attr("del_id",emp.empId);
				//拼接编辑和删除两个按钮
				var BtnsTd = $("<td></td>").append(editBtnTd).append(" ").append(delBtnTd);
				//将每个单元格拼接成一行
				$("<tr></tr>")
				.append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(BtnsTd)
				.appendTo("#emps_table tbody");
			})
		}
		
		//2.解析并显示分页数据
		function build_page_areas(result){
			$("#page_info_areas").empty();  //发送新的AJAX请求之后要把原来的数据清空
			var pageNum = result.extend.pageInfo.pageNum;
			var pages = result.extend.pageInfo.pages;
			var total = result.extend.pageInfo.total;
			totalRecords = total;
			currentPage = pageNum;
			$("#page_info_areas").append("当前 "+pageNum+" 页  总 "+pages+" 页   总 "+total+" 条记录")
		}
		
		
		//3.解析并显示分页条
		function build_page_nav(result){
			$("#page_info_nav").empty();  //发送新的AJAX请求之后要把原来的数据清空
			var pagesArray = result.extend.pageInfo.navigatepageNums;
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"))
			
			//如果是在第一页，则首页和下一页不点击
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			}else{
				//跳转到首页
				firstPage.click(function(){
					to_page(1)
				})
				//跳转到上一页
				prePage.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				})
			}
			
			var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			//如果是最后一页，则末页和下一页不能点击
			if(result.extend.pageInfo.hasNextPage == false){
				nextPage.addClass("disabled");
				lastPage.addClass("disabled");
			}else{
				//跳转到下一页
				nextPage.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				})
				//跳转到末页
				lastPage.click(function(){
					to_page(result.extend.pageInfo.pages);
				})
			}
			ul.append(firstPage).append(prePage);
			$.each(pagesArray,function(index,item){
				var pageEle = $("<li></li>").append($("<a></a>").append(item));
				//当前页高亮显示
				if(result.extend.pageInfo.pageNum == item){
					pageEle.addClass("active");
				}
				ul.append(pageEle)
				pageEle.click(function(){
					to_page(item)
				})
			})
			ul.append(nextPage).append(lastPage)
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_info_nav");
		}
		
		
		//清除表单数据和样式
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		
		
		//给新增按钮绑定单击事件
		$("#emp_add_modal_btn").click(function(){
			//清空上一次填写的表单信息
			reset_form("#myModal form");
			getDepts("#emp_add_dept_input");
			//弹出模态框
			$("#myModal").modal({
				backdrop:"static"
			})
		})
		
		//发送ajax请求获取部门信息
		function getDepts(ele){
			//清空原来的部门信息
			$(ele).empty();
			//发送ajax请求
			$.ajax({
				url:"${pageContext.request.contextPath}/depts",
				type:"GET",
				success:function(result){
					var depts = result.extend.depts;
					$.each(depts,function(index,dept){
						var optionEle = $("<option></option>").append(dept.deptName).attr("value",dept.deptId)
						optionEle.appendTo($(ele));
					})
				}
				
			})
		}
		

		//用户信息校验的提示
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg)
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
			
		} 
		
		
		//检查用户名是否可用
		$("#emp_add_empName_input").change(function(){
			var empName = $(this).val();
			$.ajax({
				url:"${pageContext.request.contextPath}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if("100" == result.code){
						show_validate_msg("#emp_add_empName_input","success","恭喜你，用户名可用");
						$("#emp_add_save").attr("ajax_va","success");
					}else{
						show_validate_msg("#emp_add_empName_input","error",result.extend.msg);
						$("#emp_add_save").attr("ajax_va","error");
					}
				}
				
			})
			
		})
		
		//对用户填入的数据进行校验
		function validate_emp_add(){
			
			//获取到用户填入的用户名
			var empName = $("#emp_add_empName_input").val();
			//用户名的正则表达式
			var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				show_validate_msg("#emp_add_empName_input","error","用户名为1-16英文数字(包括_和-)或2-5个中文的组合 ")
				return false;
			}else{
				show_validate_msg("#emp_add_empName_input","success","")
			}
			//获取用户填入的email
			var Email = $("#emp_add_email_input").val();
			//email的正则表达式
			var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
			if(!regEmail.test(Email)){
				show_validate_msg("#emp_add_email_input","error","邮箱格式不正确 ")
				return false;
			}else{
				show_validate_msg("#emp_add_email_input","success","")
			}
			return true;
		}
		
		//给保存按钮绑定点击事件
		$("#emp_add_save").click(function(){
			
			//1.对用户输入的数据进行校验，如不合法给出提示信息
			if(!validate_emp_add()){
				return; 
			}
			
			//2.若出现校验出错的提示信息，那么保存按钮将不提交ajax请求
			if("error" == $(this).attr("ajax_va")){
				show_validate_msg("#emp_add_empName_input","error","抱歉！用户名重复，请更换一个！");
				return;
			}
			//3.发送新增员工的ajax请求
			$.ajax({
				url:"${pageContext.request.contextPath}/emp",
				type:"POST",
				data:$("#myModal form").serialize(),
				success:function(result){
					if(result.code == "100"){
						//1.把模态框关掉
						$('#myModal').modal('hide')
						//2.跳转到最后一页
						to_page(totalRecords)
					}else {
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#emp_add_email_input","error",result.extend.errorFields.email)
						}
						
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#emp_add_empName_input","error",result.extend.errorFields.empName)
						}
					}
					
				}
			})
		})
		
		//1）、我们是按钮创建之前就绑定了click，所以绑不上
	    //2）、可以在创建按钮的时候绑定事件
	    //3）、绑定点击.live()
	    //jquery新版没有live，使用on方法进行替代
		$(document).on("click",".edit_btn",function(){
			//清空上一次填写的表单信息
			reset_form("#myModal2 form");
			//通过ajax请求获取部门信息
			getDepts("#emp_update_dept_input");
			//获取编辑按钮的属性，期属性存的是记录的id
			getEmp($(this).attr("edit_id"))
			//将编辑按钮的edit_id（记录的id）传递给更新按钮
			$("#emp_update_save").attr("edit_id",$(this).attr("edit_id"))
			//弹出模态框
			$("#myModal2").modal({
				backdrop:"static"
			})
		})
		
		//通过id获取员工的信息，并填入员工修改的表单中
		function getEmp(id){
			$.ajax({
				url:"${pageContext.request.contextPath}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					$("#emp_update_empName_static").text(empData.empName);
					$("#emp_update_email_input").val(empData.email);
					$("#myModal2 input[name=gender]").val([empData.gender])
					$("#myModal2 select").val([empData.dId])
				}
			})
		}
		
		
		//点击更新按钮，更新员工数据
		$("#emp_update_save").click(function(){
			//1.前端数据校验
			//获取用户填入的email
			var Email = $("#emp_update_email_input").val();
			//email的正则表达式
			var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
			if(!regEmail.test(Email)){
				show_validate_msg("#emp_update_email_input","error","邮箱格式不正确 ")
				return false;
			}else{
				show_validate_msg("#emp_update_email_input","success","")
			}
			
			//2.发送AJAX请求跟新数据库的数据
			$.ajax({
				url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit_id"),
				//一种方法：
				/* 
				type:"POST",
				data:$("#myModal2 form").serialize()+"&_method=PUT",
				success:function(result){
					alert(result.msg) 
				*/
				
				//另一种方法：
				type:"PUT",
				data:$("#myModal2 form").serialize(),
				success:function(result){
					/* alert(result.msg)  */
					//1.关闭模态框
					$('#myModal2').modal('hide')
					//2.跳转到当前页面
					to_page(currentPage)
				}
			})
		})
		
		
		//点击删除按钮
		$(document).on("click",".del_btn",function(){
			//1.获取要删除的记录的empName和empId
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del_id");
			//2.弹出对话框，确认是否删除
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg)
						to_page(currentPage)
					}
				})
			}
		})
		
		//点击全选按钮框，员工选择框都被选中
		$(document).on("click","#check_all",function(){
			//获取全选的复选框的状态
			var flag = $(this).prop("checked");
			//将获取的状态赋给每个员工的复选框
			$(".check_item").prop("checked",flag);
		})
		
		//把一页的员工单选的复选框选中，则全选框选中
		$(document).on("click",".check_item",function(){
			//判断被选中员工的个数与员工数是否相等
			var flag = $(".check_item:checked").length == $(".check_item").length
			//将结果赋值给全选框
			$("#check_all").prop("checked",flag);
		})
		
		
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var empIds = "";
			$.each($(".check_item:checked"),function(){
				var empName = $(this).parents("tr").find("td:eq(2)").text()+","
				var empId = $(this).parents("tr").find("td:eq(1)").text()+"-"
				empNames+=empName
				empIds+=empId
			})
			empNames = empNames.substring(0,empNames.length-1)
			empIds = empIds.substring(0,empNames.length-1)
			if(confirm("确定删除【"+empNames+"】吗？")){
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+empIds,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
						$("#check_all").prop("checked",false)
					}
				})
			}
		})
			
			
		
	</script>
</body>
</html>