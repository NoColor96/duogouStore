<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<title>属性编辑</title>
<div class="workingArea">
	<ul class="breadcrumb">
		<li><a href="<c:url value="../../categorys"/>">所有分类</a></li>
		<li><a href="<c:url value="../properties"/>">${p.category.name}</a></li>
		<li>编辑属性</li>
	</ul>
	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑属性</div>
		<div class="panel-body">
			<form action="<c:url value="../properties"/>" method="post" id="editForm">
				<input type="hidden" name="_method" value="put"/>
				<table class="editTable">
					<tr>
						<td>属性名称</td>
						<td>
							<input type="text" class="form-control" name="name" id="name" value="${p.name}"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="hidden" name="id" value="${p.id}"/>
							<button class="btn btn-success" type="submit">提交</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<%@include file="../include/admin/adminFooter.jsp"%>