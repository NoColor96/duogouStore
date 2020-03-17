<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<script>
	$(function(){
		$("#addForm").submit(function(){
			if(!checkEmpty("name","产品名称")||!checkEmpty("originalPrice","原价格")||!checkEmpty("promotePrice","促销价")||!checkEmpty("stock","库存"))
				return false;
			return true;
		});
	});
</script>
<title>商品管理</title>
<div class="workingArea">
	<ul class="breadcrumb">
		<li>
			<a href="<c:url value="../../categorys"/>">所有分类</a>
		</li>
		<li>
			<a href="?start=0">${products[0].category.name}</a>
		</li>
		<li>
			<a href="">产品管理</a>
		</li>
	</ul>
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordersed table-hover table-condensed">
			<thead>
				<tr class="info">
					<th>ID</th>
					<th>图片</th>
					<th>产品名称</th>
					<th>产品小标题</th>
					<th>原价格</th>
					<th>促销价</th>
					<th>库存数量</th>
					<th>图片管理</th>
					<th>设置属性</th>
					<th>编辑</th>
					<th>删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${products}" var="p">
					<tr>
						<td>${p.id}</td>
						<td>
							<c:if test="${!empty p.firstProductImage}">
								<img src="../../../img/productSingle/${p.firstProductImage.id}.jpg" width="40px">
							</c:if>
						</td>
						<td>${p.name}</td>
						<td>${p.subTitle}</td>
						<td>${p.originalPrice}</td>
						<td>${p.promotePrice}</td>
						<td>${p.stock}</td>
						<td>
							<a href="<c:url value="products/${p.id}/productImages"/>">
								<span class="glyphicon glyphicon-picture"></span>
							</a>
						</td>
						<td>
							<a href="<c:url value="products/${p.id}/propertyValues"/>">
								<span class="glyphicon glyphicon-th-list"></span>
							</a>
						</td>
						<td>
							<a href="<c:url value="products/${p.id}"/>">
								<span class="glyphicon glyphicon-edit"></span>
							</a>	
						</td>
						<td>
							<a href="<c:url value="products/${p.id}?start=${param.start==null?0:param.start}"/>" deleteLink="true" onclick="return false;">
								<span class="glyphicon glyphicon-trash" onclick="deleteBtn(this);"></span>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<%@ include file="../include/admin/adminPage.jsp"%>
	<div class="panel panel-info addDiv">
		<div class="panel-heading">新增产品</div>
		<div class="panel-body">
			<form id="addForm" action="<c:url value="products"/>" method="post">
				<table class="addTable">
					<tr>
						<td>
							产品名称
						</td>
						<td>
							<input type="text" name="name" id="name" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>
							产品小标题
						</td>
						<td>
							<input type="text" name="subTitle" id="subTitle" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>
							原价格
						</td>
						<td>
							<input type="text" name="originalPrice" id="originalPrice" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>
							促销价
						</td>
						<td>
							<input type="text" name="promotePrice"  id="promotePrice" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>
							库存
						</td>
						<td>
							<input type="text" name="stock" id="stock" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="hidden" name="cid" value="${p.category.id}"/>
							<button type="submit" class="btn btn-success">提交</button>
						</td>
					</tr>
				</table>	
			</form>
		
		</div>
	</div>
</div>

<%@ include file="../include/admin/adminFooter.jsp"%>