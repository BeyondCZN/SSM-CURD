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
				<button type ="button" class = "btn btn-primary">新增</button>
				<button type ="button" class = "btn btn-danger">删除</button>
			</div>
		</div>
		
		<!-- 显示表格 -->
		<table class = "table table-hover">
			<tr>
				<th>#</th>
				<th>empName</th>
				<th>gender</th>
				<th>email</th>
				<th>department</th>
				<th>操作</th>
			</tr>
			
			<c:forEach items="${pageInfo.list }" var = "emp">
				<tr>
				<td>${emp.empId }</td>
				<td>${emp.empName }</td>
				<td>${emp.gender== "M"?"男":"女" } </td>
				<td>${emp.email }</td>
				<td>${emp.department.deptName }</td>
				<td>
					<button class = "btn btn-primary">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						编辑
					</button>
					<button class = "btn btn-danger">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 
						删除
					</button>
				</td>
			</tr>
			</c:forEach>
			
		</table>
		
		<!-- 显示分页 -->
		<div class = "row">
			<!-- 分页文字信息 -->
			<div class ="col-md-6" >
				当前第 ${pageInfo.pageNum}页
				总${pageInfo.pages }页
				总${pageInfo.total }条记录
			</div>
			
			<!-- 分页条 -->
			<div class = "col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  
				  		<!-- 下一页的跳转和首页的跳转 -->
				  		<li><a href="${pageContext.request.contextPath }/emps?pn=1">首页</a></li>
				  		<c:if test="${pageInfo.hasPreviousPage }">
				    		<li>
						      <a href="${pageContext.request.contextPath }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
					   		</li>
				  		</c:if>
				   		
				   		<!-- 控制页数高亮 -->
				   		<c:forEach items="${pageInfo.navigatepageNums }" var = "page_num">
				   			<c:if test="${pageInfo.pageNum == page_num}">
				   				<li class="active">
				   					<a href="${pageContext.request.contextPath }/emps?pn=${page_num }">${page_num }</a>
				   				</li>
				   			</c:if>
				   			<c:if test="${pageInfo.pageNum != page_num}">
					  	  		<li>
					  	  			<a href="${pageContext.request.contextPath }/emps?pn=${page_num }">${page_num }</a>
					  	  		</li>
				   			</c:if>
				   			
				   		<!-- 下一页的跳转和末页的跳转 -->
				   		</c:forEach>
				   		<c:if test="${pageInfo.hasNextPage }">
				   			<li>
					      		<a  href="${pageContext.request.contextPath }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
						        </a>
			    			</li>
				   		</c:if>
				   		
				  		<li><a href="${pageContext.request.contextPath }/emps?pn=${pageInfo.pages}">末页</a></li>
				  		
				  	</ul>
				</nav>
			</div>
		</div>
	</div>
	
	
</body>
</html>