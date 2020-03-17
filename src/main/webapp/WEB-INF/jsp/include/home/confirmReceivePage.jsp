<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="cconfirmReceivePageDiv">
	<div class="cconfirmReceiveImageDiv">
		<img src="img/site/comformPayFlow.png" />
		<div class="playOrderTime">
			<fmt:formatDate value="${order.createDate}"
				pattern="YYYY-MM-dd HH:mm:ss" />
		</div>
		<div class="confirmReceiveTime">
			<fmt:formatDate value="${order.payDate}"
				pattern="YYYY-MM-dd HH:mm:ss" />
		</div>
		<div class="shipmentTime">
			<fmt:formatDate value="${order.deliveryDate}"
				pattern="YYYY-MM-dd HH:mm:ss" />
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="confirmReceiveOrderInfoDiv">我已收到货，同意支付宝付款</div>
	<div class="confirmReceiveOrderItemDiv">
		<div class="confirmReceiveOrderItemText">订单信息</div>
		<table class="confirmReceiveOrderItemTable">
			<thead>
				<th colspan="2">宝贝</th>
				<th>单价</th>
				<th>数量</th>
				<th>商品总价</th>
				<th>运费</th>
			</thead>
			<tbody>
				<c:forEach items="${order.orderItems}" var="orderItem">
					<tr>
						<td class="ImageTD"><img
							src="img/productSingle/${orderItem.product.firstProductImage.id}.jpg" />
						</td>
						<td class="confirmReceiveOrderItemProductLink"><a
							href="product?pid=${orderItem.product.id}">${orderItem.product.name}</a></td>
						<td>￥${orderItem.product.promotePrice}</td>
						<td>${orderItem.number}</td>
						<td><span class="productSumPrice">￥<fmt:formatNumber
									type="number"
									value="${orderItem.product.promotePrice*orderItem.number}"
									maxFractionDigits="1" minFractionDigits="1" /></span>
						<td><span class="freight">快递 ： 0.00 </span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="confirmReceiveOrderItemText pull-right">
			实付款：<span class="confirmReceiveOrderItemSumPrice">￥${order.total}</span>
		</div>
		<div class="confirmReceiveOrderDetailDiv">
			<table class="confirmReceiveOrderDetailTable">
				<tr>
					<td>订单编号：</td>
					<td>${order.orderCode}<img src="img/site/DuoGouMiniLogo.png"
						width="23px" />
					</td>
				</tr>
				<tr>
					<td>卖家昵称：</td>
					<td>多购商铺 <span class="confirmReceiveOrderDetailduogouChatGif duogouChat"  title="联系客服" data-toggle="tooltip" data-placement="right"></span>
					</td>
				</tr>
				<tr>
					<td>收货信息：</td>
					<td>${order.address}</td>
				</tr>
				<tr>
					<td>备注信息：</td>
					<td><c:if test="${empty order.userMessage}">无</c:if>${order.userMessage}</td>
				</tr>
			</table>
		</div>
		<div class="confirmReceiveButtonDiv">
			<div class="confirmReceiveWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
			<a href="orderConfirmed?oid=${order.id}"><button class="confirmReceiveButton">确认支付</button></a>
		</div>
	</div>
</div>