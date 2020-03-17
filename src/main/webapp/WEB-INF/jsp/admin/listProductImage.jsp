<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<script>
	$(function(){
		$(".addFormSingle").submit(function(){
			if(!checkEmpty("filepathSingle","图片"))
				return false;
			return true;
		});	
		$(".addFormDetail").submit(function(){
			if(!checkEmpty("filepathDetail","详情图片"))
				return false;
			return true;
		});	
	});
</script>
<title>商品图片</title>
<div class="workingArea">
	<ul class="breadcrumb">
		<li><a href="<c:url value="../../../../categorys"/>">所有分类</a></li>
		<li><a href="<c:url value="../../products"/>">${p.category.name}</a></li>
		<li class="active">${p.name}</li>
		<li class="active">产品图片管理</li>
	</ul>
	<table class="addPictureTable" align="center">
		<tr>
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-info addPictureDiv">
						<div class="panel-heading">
							新增产品<b class="text-primary"> 单个 </b>图片
						</div>
						<div class="panel-body">
							<form class="addFormSingle" method="post" action="<c:url value="productImages"/>" enctype="multipart/form-data">
								<table class="addTable">
									<tr>
										<td>请选择本地图片 尺寸400X400 为佳</td>
									</tr>
									<tr>
										<td>
											<input type="file" name="imageFile" id="filepathSingle"/>
										</td>
									</tr>
									<tr>
										<td>
											<input type="hidden" name="type" value="single"/>
											<button type="submit" class="btn btn-success">提交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-stiped table-hover table-condensed table-bordered">
						<thead>
							<tr class="info">
								<th>ID</th>
								<th>产品单个图片缩略图</th>
								<th>删除</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${p.productSingleImages}" var="pi">
							<tr>
								<td>${pi.id}</td>
								<td>
									<a href="<c:url value="/img/productSingle/${pi.id}.jpg"/>" title="点击查看原图">
										<img src="<c:url value="/img/productSingle/${pi.id}.jpg"/>" height="50px"/>
									</a>
								</td>
								<td>
									<a href="<c:url value="productImages/${pi.id}"/>" deleteLink="true" onclick="return false;">
										<span class="glyphicon glyphicon-trash" onclick="deleteBtn(this);"></span>
									</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</td>
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-info addPictureDiv">
						<div class="panel-heading">
							新增产品<b class="text-primary"> 详情 </b>图片
						</div>
						<div class="panel-body">
							<form class="addFormDetail" method="post" action="<c:url value="productImages"/>" enctype="multipart/form-data">
								<table class="addTable">
									<tr>
										<td>请选择本地图片 宽度790 为佳</td>
									</tr>
									<tr>
										<td>
											<input type="file" name="imageFile" id="filepathDetail"/>
										</td>
									</tr>
									<tr>
										<td>
											<input type="hidden" name="type" value="detail"/>
											<input type="hidden" name="pid" value="${p.id}"/>
											<button type="submit" class="btn btn-success">提交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-stiped table-hover table-condensed table-bordered">
						<thead>
							<tr class="info">
								<th>ID</th>
								<th>产品详情图片缩略图</th>
								<th>删除</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${p.productDetailImages}" var="pi">
							<tr>
								<td>${pi.id}</td>
								<td>
									<a href="<c:url value="/img/productDetail/${pi.id}.jpg"/>" title="点击查看原图">
										<img src="<c:url value="/img/productDetail/${pi.id}.jpg"/>" height="50px"/>
									</a>
								</td>
								<td>
									<a href="<c:url value="productImages/${pi.id}"/>" deleteLink="true"  onclick="return false;">
										<span class="glyphicon glyphicon-trash" onclick="deleteBtn(this);"></span>
									</a>
								</td>
							</tr>
						</c:forEach>
							
						</tbody>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>


<%@ include file="../include/admin/adminFooter.jsp"%>