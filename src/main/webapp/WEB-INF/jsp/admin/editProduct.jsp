<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<script>
	$(function(){
		$("#editForm").submit(function(){
			if(!checkEmpty("name","产品名称")||!checkEmpty("originalPrice","原价格")||!checkEmpty("promotePrice","促销价")||!checkEmpty("stock","库存"))
				return false;
			return true;
		});
	});
</script>
<title>商品编辑</title>
<div class="workingArea">
	<ul class="breadcrumb">
		<li>
			<a href="<c:url value="../../../categorys"/>">所有分类</a>
		</li>
		<li>
			<a href="../products">${p.category.name}</a>
		</li>
		<li class="active">
			${p.name}
		</li>
		<li class="active">
			编辑产品
		</li>
	</ul>
	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑产品</div>
		<div class="panel-body">
			<form id="editForm" action="<c:url value="../products/${p.id}"/>" method="post">
				<input type="hidden" name="_method" value="put"/>
				<table class="editTable">
					<tr>
						<td>
							产品名称
						</td>
						<td>
							<input type="text" name="name" id="name" class="form-control" value="${p.name}"/>
						</td>
					</tr>
					<tr>
						<td>
							产品小标题
						</td>
						<td>
							<input type="text" name="subTitle" id="subTitle" class="form-control" value="${p.subTitle}"/>
						</td>
					</tr>
					<tr>
						<td>
							原价格
						</td>
						<td>
							<input type="text" name="originalPrice" id="originalPrice" class="form-control" value="${p.originalPrice}"/>
						</td>
					</tr>
					<tr>
						<td>
							促销价
						</td>
						<td>
							<input type="text" name="promotePrice"  id="promotePrice" class="form-control" value="${p.promotePrice}"/>
						</td>
					</tr>
					<tr>
						<td>
							库存
						</td>
						<td>
							<input type="text" name="stock" id="stock" class="form-control" value="${p.stock}"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<input type="hidden" name="id" value="${p.id}"/>
							<button type="submit" class="btn btn-success">提交</button>
						</td>
					</tr>
				</table>	
			</form>
		
		</div>
	</div>
</div>

<%@ include file="../include/admin/adminFooter.jsp"%>