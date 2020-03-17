<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<script>
	$(function(){
		$("#editForm").submit(function(){
			if(!checkEmpty("name","分类名称"))
				return false;
			return true;
		});
	});
</script>
<title>分类编辑</title>
<div class="workingArea">
	<ol class="breadcrumb">
		<li><a href="<c:url value="/admin/categorys"/>">所有分类</a></li>
		<li class="active">编辑分类</li>
	</ol>
	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑分类</div>
		<div class="panel-body">
			<form action="<c:url value="/admin/categorys"/>" method="post" enctype="multipart/form-data" id="editForm">
				<input type="hidden" name="_method" value="put"/>
				<table class=editTable>
					<tr>
						<td>分类名称</td>
						<td>
							<input type="text" name="name" id="name" value="${c.name}" class="form-control">
							<input type="hidden" name="id" value="${c.id}">
						</td>
					</tr>
					<tr>
						<td>分类图片</td>
						<td>
							<input type="file" name="imageFile" id="categoryPic">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button class="btn btn-success" type="submit">提交</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/admin/adminFooter.jsp"%>