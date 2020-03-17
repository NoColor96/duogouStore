<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<script>
	$(function(){
		$("#addForm").submit(function(){
			if(!checkEmpty("name","属性名称"))
				return false;
			return true;
		});
	});
</script>
<title>属性管理</title>
<div class="workingArea">
	<ol class="breadcrumb">
		<li><a href="<c:url value="../../categorys"/>">所有分类</a></li>
		<li><a href="?start=0">${properties[0].category.name}</a></li>
		<li class="active">属性管理</li>
	</ol>
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover table-condensed">
			<thead>
				<tr class="info">
					<th>ID</th>
					<th>属性名称</th>
					<th>编辑</th>
					<th>删除</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${properties}" var="p">
				<tr>
						<td>${p.id}</td>
						<td>${p.name}</td>
						<td><a href="<c:url value="properties/${p.id}"/>"><span class="glyphicon glyphicon-edit"></span></a></td>
						<td><a href="<c:url value="properties/${p.id}?start=${param.start}"/>" deleteLink="true" onclick="return false;"><span class="glyphicon glyphicon-trash" onclick="deleteBtn(this);"></span></a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<%@include file="../include/admin/adminPage.jsp"%>
	<div class="panel panel-info addDiv">
		<div class="panel-heading">新增属性</div>
		<div class="panel-body">
			<form method="post" id="addForm" action="properties">
				<table class="addTable">
					<tr>
						<td>属性名称</td>
						<td>
							<input type="text" class="form-control" id="name" name="name"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="hidden" name="cid" value="${cid}"/>
							<button class="btn btn-success" type="submit">提交</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<%@include file="../include/admin/adminFooter.jsp"%>
