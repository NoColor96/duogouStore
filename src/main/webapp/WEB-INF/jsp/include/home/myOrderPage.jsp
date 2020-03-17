<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType">
			<a class="all">所有订单</a>
		</div>
		<div>
			<a class="waitPay">待付款</a>
		</div>
		<div>
			<a class="waitDelivery">待发货</a>
		</div>
		<div>
			<a class="waitConfirm">待收货</a>
		</div>
		<div>
			<a class="waitReview">待评价</a>
		</div>
		<div class="orderTypeLastOne">
			<a class="noRightborder">&nbsp;</a>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr>
				<td class="tradeTitle">宝贝</td>
				<td>单价</td>
				<td>数量</td>
				<td>实付款</td>
				<td>交易操作</td>
			</tr>
		</table>
	</div>
	<div class="orderListItem">
		<c:if test="${empty orders}">
				您还没有订单记录，快去购物吧！
		</c:if>
		<c:forEach items="${orders}" var="order" varStatus="i">
			<table class="orderListItemTable" orderStatus="${order.status}">
				<tr class="orderListItemFirstTR">
					<td class="tradeTitle"><b><fmt:formatDate value="${order.createDate}" pattern="YYYY-MM-dd HH:mm:ss"/></b> <span>订单号:
							${order.orderCode}</span></td>
					<td colspan="2" class="seller"><img
						src="img/site/DuoGouMiniLogo.png" /> 多购商城</td>
					<td>
							<div class="duogouChat orderItemduogouChatGif"  title="联系客服" data-toggle="tooltip" data-placement="top"></div>
					</td>
					<td class="orderItemDeleteTD"><a class="deleteOrderLink" oid="${order.id}"> <span
							class="orderListItemDelete glyphicon glyphicon-trash"></span>
					</a></td>
				</tr>
				<c:forEach items="${order.orderItems}" var="orderItem" varStatus="j">		
					<tr class="orderItemProductInfoPartTR">
						<td class="orderItemProductInfoPartTD productTitle"><img
							data-src="img/productSingle/${orderItem.product.firstProductImage.id}.jpg" class="productSmallImage lazyLoad" />
							<div class="orderListItemProductLinkOutDiv">
								<a href="product?pid=${orderItem.product.id}">${orderItem.product.name}</a>
								<div class="orderListItemProductLinkInnerDiv">
									<img src="img/site/creditcard.png" /> <img
										src="img/site/7day.png" /> <img src="img/site/promise.png" />
								</div>
							</div>
						</td>
						<td class="orderItemProductInfoPartTD">
							<div class="orderListItemProductOriginalPrice">¥${orderItem.product.originalPrice}</div>
							<div class="orderListItemProductPrice">¥${orderItem.product.promotePrice}</div>
						</td>
						<td class="orderItemProductInfoPartTD">
							<span class="orderListItemNumber">${orderItem.number}</span>
						</td>
						<c:if test="${j.count<=1}">
							<td class="orderListItemProductRealPriceTD" rowspan="5"><span
								class="orderListItemProductRealPrice">¥${order.total}</span>
								<div class="orderListItemPriceWithTransport">
									(含运费：¥0.00)</span></td>
							<td class="orderListItemButtonTD " rowspan="5">
								<c:choose>
									<c:when test="${order.status=='waitPay'}">
										<a href="alipay?oid=${order.id}&total=${order.total}">
											<button class="orderListItemAlipay">付款</button>
										</a>
									</c:when>
									<c:when test="${order.status=='waitDelivery'}">
										<button class="orderListItemDelivery" oid="${order.id}">待发货</button>
									</c:when>
									<c:when test="${order.status=='waitConfirm'}">
										<a href="confirmReceive?oid=${order.id}"><button class="orderListItemConfirm">确认收货</button></a>
									</c:when>
									<c:when test="${order.status=='waitReview'}">
										<a href="review?oid=${order.id}"><button class="orderListItemReview">评价</button></a>
									</c:when>
									<c:when test="${order.status=='finish'}">
										<button class="orderListItemFinish">已完成</button>
									</c:when>
									<c:otherwise>
										<button class="orderListItemFinish">未知订单</button>
									</c:otherwise>
								</c:choose>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
	</div>
</div>
<div class="modal" id="deleteModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span>此订单将永久删除</span>
				<button class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default">返回</button>
				<button class="btn btn-danger confirmDeleteBtn">删除</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(".orderListItemDelivery").click(function(){
		var oid = $(this).attr("oid");
		$.post(
			"delivery",
			{"oid":oid},
			function(result){
				if("success"==result){
					alert("催单成功！商品已发出，刷新当前页面即可确认收货");
				}
			}
		);
	});
	//删除订单
	var oid = 0;
	$(".deleteOrderLink").click(function(){
		$("#deleteModal").modal();
		oid = $(this).attr("oid");
	});
	$(".confirmDeleteBtn").click(function(){
		$.post(
			"deleteOrder",
			{"oid":oid},
			function(result){
				if("success"==result){
					$("#deleteModal").modal("hide");
					$(".deleteOrderLink[oid="+oid+"]").parents("table").hide();
				}
			}
		);
	});
	//导航栏
	$(".orderType div[class!='orderTypeLastOne']").click(
			function() {
				$(".orderType div[class*=selectedOrderType]").removeClass(
						"selectedOrderType");
				$(this).addClass("selectedOrderType");
				var orderStatus = $(this).children().attr("class");
				if (orderStatus == "all") {
					$(".orderListItemTable").show();
					return true;//相当于break
				}
				$(".orderListItemTable").hide();
				$(".orderListItemTable[orderStatus=" + orderStatus + "]")
						.show();
	});
	//待发货按钮变化
	$(".orderListItemDelivery").mouseenter(function() {
		$(this).text("催单");
	});
	$(".orderListItemDelivery").mouseleave(function() {
		$(this).text("待发货");
	});
</script>