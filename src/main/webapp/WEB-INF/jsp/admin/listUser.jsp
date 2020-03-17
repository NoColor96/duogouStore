<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="users" name="navName"/>
</jsp:include>
<title>用户管理</title>
<div class="workingArea">
	<h1 class="label label-info">用户管理</h1>
	<br>
	<br>
	<div class="listDataTableDiv">
		<table class="table table-striped table-condensed table-bodered table-hover">
			<thead>
				<tr class="info">
					<th>ID</th>
					<th>用户名称</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="u">
					<tr>
						<td>${u.id}</td>
						<td>${u.name}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<%@ include file="../include/admin/adminPage.jsp"%>	
</div>
<%@ include file="../include/admin/adminFooter.jsp"%>