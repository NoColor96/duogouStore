<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="reviewDiv">
	<div class="reviewProductInfoDiv">
		<div class="reviewProductInfoImg">
			<a href="product?pid=${orderItem.product.id}">
			<img
				src="img/productSingle/${orderItem.product.firstProductImage.id}.jpg" />
			</a>
		</div>
		<div class="reviewProductInfoRightDiv">
			<div class="reviewProductInfoRightText">${orderItem.product.name}</div>
			<table class="reviewProductInfoTable">
				<tr>
					<td>价格:</td>
					<td><span class="reviewProductInfoTablePrice">￥${orderItem.product.promotePrice}</span>
						元</td>
				</tr>
				<tr>
					<td>配送:</td>
					<td>快递：<span class="freight">0.00</span>元
					</td>
				</tr>
				<tr>
					<td>月销量:</td>
					<td><span class="reviewProductInfoTableSellNumber">${orderItem.product.saleCount}</span>
						件</td>
				</tr>
			</table>
			<div class="reviewProductInfoRightBelowDiv">
				<span class="reviewProductInfoRightBelowImg"> <img
					src="img/site/reviewLight.png" />
				</span> <span class="reviewProductInfoRightBelowText"> 现在查看的是
					您所购买商品的信息 于<fmt:formatDate value="${order.createDate}" />下单购买了此商品
				</span>
				<div style="clear: both;"></div>
			</div>
		</div>
			<div class="reviewStasticsDiv">
				<div class="reviewStasticsLeft">
					累计评价 <span class="reviewStasticsNumber">${orderItem.product.reviewCount}</span>
				</div>
				<div class="reviewStasticsRightEmpty"></div>
			</div>
		<c:if test="${empty showonly}">
			<div class="makeReviewDiv">
				<form method="post" action="review">
					<div class="makeReviewText">其他买家需要你的建议哦！</div>
					<table class="makeReviewTable">
						<tr>
							<td class="reviewTableTD1">评价商品</td>
							<td><textarea rows="7" name="content"></textarea></td>
						</tr>
					</table>
					<div class="makeReviewButtonDiv">
						<input type="hidden" name="oid" value="${oid}" /> <input
							type="hidden" name="pid" value="${orderItem.product.id}" />
						<button type="submit">提交评价</button>
					</div>
				</form>
			</div>
		</c:if>
		<c:if test="${showonly=='showonly'}">
			<div class="reviewDivlistReviews">
				<c:forEach items="${reviews}" var="review" varStatus="i">
					<div class="reviewDivlistReviewsEach">
						<span class="reviewDate"> <fmt:formatDate value="${review.createDate}" pattern="YYYY-MM-dd"/> </span> <span
							class="reviewContent"> ${review.content}  </span>
						<div class="reviewUserInfo pull-right">
							${review.user.anonymousName} <span class="reviewUserInfoAnonymous"> (匿名) </span>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>