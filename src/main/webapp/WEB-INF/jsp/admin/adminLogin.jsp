<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="login" name="navName"/>
</jsp:include>
<title>多购后台管理系统</title>
<div class="workingArea">
	<div class="panel panel-info <c:if test="${!empty sessionScope.errorMsg}">panel-danger</c:if> loginDiv">
		<div class="panel-heading">
		<h4>
			<c:if test="${!empty sessionScope.errorMsg}">${sessionScope.errorMsg}</c:if>
			<c:if test="${empty sessionScope.errorMsg}">请登录</c:if>	
		</h4>
		</div>
		<div class="panel-body">
			<form class="adminloginForm" action="<c:url value="admin/login"/>" method="post">
				<table>
					<tr>
						<td>管理员：</td>
						<td class="tdInput">
							<input type="text" class="form-control tdInput" name="name">
						</td>
					</tr>
					<tr>
						<td>密码：</td>
						<td class="tdInput">
							<input type="password" class="form-control tdInput" name="password"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn btn-primary" style="width:100px;">登录</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/admin/adminFooter.jsp"%>