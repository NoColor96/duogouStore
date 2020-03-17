<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<script>
		$(function(){
			$(".duogouChatLink").click(function(){
				alert("模仿多购网站开发，并不会打开旺旺");
			});
		});
		
	</script>
<div class="searchResultDiv">
<%@include file="sortBarPage.jsp" %>
	<div class="productList">
		<c:forEach items="${ps}" var="product">
			<div class="productUnit" price="${product.promotePrice}">
					<div class="productUnitFrame">
					<a href="product?pid=${product.id}"> <img class="productImage lazyLoad"
						data-src="img/productSingle/${product.firstProductImage.id}.jpg"/>
					</a>
					<div class="productPrice">￥${product.promotePrice}</div>
					<a class="productLink" href="product?pid=${product.id}"> ${product.name} </a>
					<a class="duogouLink" href="product?pid=${product.id}"> 多购专卖 </a>
					<div class="productInfo">
						<span class="monthDeal "> 月成交 <span
							class="productDealNumber">  ${product.saleCount}笔 </span>
						</span> <span class="productReview"> 评价 <span
							class="productReviewNumber">  ${product.reviewCount}  </span>
						</span> <span class="duogouChat" title="咨询客服" data-toggle="tooltip" data-placement="bottom">		
							<img src="img/site/duogouChat.png" />
						</span>
					</div>
				</div>
			</div>
		</c:forEach>
		<c:if test="${empty ps}">
			<div>没有满足条件的商品</div>
		</c:if>
		<script>
		</script>
	</div>
</div>