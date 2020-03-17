<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="orders" name="navName"/>
</jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<title>订单管理</title>
<script>
	$(function(){
		$("button.orderPageCheckOrderItems").click(function(){
			var oid = $(this).attr("oid");
			$(".orderPageOrderItemTR[oid="+oid+"]").toggle();
		});
		$(".delivery").click(function(){
			var a = $(this).parents("a");
			$.ajax({
				type:"PUT",
				url:a.attr("href"),
				success:function(result){
					if(result=="success"){
						alert("发货成功！");
						location.reload();
					} 
				}
			});
		});
	});
</script>
<div class="workingArea">
	<h1 class="label label-info">订单管理</h1>
	<br>
	<br>
	<div class="listDataTableDiv">
		<table class="table table-striped table-condensed table-hover table-bordered">
			<thead>
				<tr class="info">
					<th>ID</th>
					<th>状态</th>
					<th>金额</th>
					<th>商品数量</th>
					<th>买家名称</th>
					<th>创建时间</th>
					<th>支付时间</th>
					<th>发货时间</th>
					<th>确认收货时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orders}" var="o">
					<tr>
						<td>${o.id}</td>
						<td>${o.statusDesc}</td>
						<td>
							<fmt:formatNumber type="number" value="${o.total}" minFractionDigits="2"/>
						</td>
						<td>${o.totalNumber}</td>
						<td>${o.user.name}</td>
						<td>
							<fmt:formatDate value="${o.createDate}" pattern="YYYY-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<fmt:formatDate value="${o.payDate}" pattern="YYYY-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<fmt:formatDate value="${o.deliveryDate}" pattern="YYYY-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<fmt:formatDate value="${o.confirmDate}" pattern="YYYY-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<button class="orderPageCheckOrderItems btn btn-primary btn-xs" oid="${o.id}">查看详情</button>
							<c:if test="${o.status=='waitDelivery'}">
								<a href="<c:url value="orders/${o.id}"/>" onclick="return false;">
									<button class="btn btn-primary btn-xs delivery">发货</button>
								</a>
							</c:if>
						</td>
					</tr>
					<tr class="orderPageOrderItemTR" oid="${o.id}">
						<td colspan="10" align="center">
							<div class="orderPageOrderItem">
								<table class="orderPageOrderItemTable" align="center" width="800px">
									<c:forEach items="${o.orderItems}" var="oi">
										<tr>
											<td align="left">
												<img src="<c:url value="../img/productSingle/${oi.product.firstProductImage.id}.jpg"/>" width="40px"/>
											</td>
											<td>
												<a href="<c:url value="/product?pid=${oi.product.id}"/>">${oi.product.name}</a>
											</td>
											<td align="right">
												${oi.number}个
											</td>
											<td align="right">
												单价：<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" minFractionDigits="2"/>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<%@ include file="../include/admin/adminPage.jsp"%>
</div>
<%@ include file="../include/admin/adminFooter.jsp"%>