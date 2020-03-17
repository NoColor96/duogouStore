<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="productPageDiv"> 
	<a href="category?cid=${product.category.id}"><img src="img/category/${product.category.id}.jpg" class="brandImage" /></a>
	<div class="imgAndInfo">
		<div class="imgInimgAndInfo">
			<img class="bigImg" src="img/productSingle/${product.firstProductImage.id}.jpg"/>
			<div class="smallImageDiv">
				<c:forEach items="${product.productSingleImages}" var="productImage">
					<img class="smallImage" src="img/productSingle/${productImage.id}.jpg" />
				</c:forEach>
			</div>
		</div>
		<div class="infoInimgAndInfo">
			<div class="productTitle">${product.name}</div>
			<div class="productSubTitle">${product.subTitle}</div>
			<div class="ganji">
				<span class="ganjiBig">赶集</span> <span> 此商品即将参加赶集， <span
					class="ganjiTime">1天19小时</span> 后开始
				</span>
			</div>
			<div class="productPriceDiv">
				<div class="gouwuquanDiv">
					<img src="img/site/gouwujuan.png" style="height: 16px;" /> <span>全多购实物商品通用</span>
				</div>
				<div class="originaDiv">
					<span class="originalPriceDesc">价格</span> <span
						class="originalPriceYuan">¥</span> <span class="originalPrice">${product.originalPrice}</span>
				</div>
				<div class="promotionDiv">
					<span class="promotionPriceDesc">促销价</span> <span
						class="promotionPriceYuan">¥</span> <span class="promotionPrice redColor boldWord">${product.promotePrice}</span>
				</div>
			</div>
 			<div class="productSaleAndReviewNumber">
				<div class="productSale">
					销量 <span class="productSaleNumber redColor boldWord">${product.saleCount}</span>
				</div>
				<div class="productReview">
					评价 <span class="productReviewNumber redColor boldWord">${product.reviewCount}</span>
				</div>
			</div> 
			<div class="productNumber grayMinFont">
				<span>数量</span> <span class="productNumberSettingSpan"> <input
					type="text" value="1" name="productCount"/>
				</span> <span class="arrow"> <a class="increaseNumber"> <span
						class="updown"> <img src="img/site/increase.png" />
					</span>
				</a> <a class="decreaseNumber"> <span class="updown"> <img
							src="img/site/decrease.png" />
					</span>
				</a>
				</span> <span> 件&nbsp;&nbsp;&nbsp;库存 <span class="productInventory">${product.stock}</span>
					件
				</span>
				<div class="duogouChatDiv duogouChat" title="咨询客服" data-toggle="tooltip" data-placement="right">
				</div>
				
			</div>
			<div class="serviceCommitment">
				<span class="serviceCommitmentDesc grayMinFont">服务承诺</span> <span
					class="serviceCommitmentLink"> <a href="#nowhere">正品保证</a> <a
					href="#nowhere">极速退款</a> <a href="#nowhere">赠运费险</a> <a
					href="#nowhere">七天无理由退换</a>
				</span>
			</div>
			<div class="buyDiv" >
				<a class="buyLink" id="buylink">
					<button class="buyButton" >立即购买</button>
				</a> <a class="addCartLink">
					<button class="addCartButton">加入购物车</button>
				</a>
			</div>
		</div>
	</div>
	<div class="productReviewDiv">
		<div class="productReviewTopPart">
		 	<a class="productDetailTopPartSelectedLink selected">商品详情</a> <a
				class="productDetailTopReviewLink"> 累计评价 <span
				class="productDetailTopReviewLinkNumber">${product.reviewCount}</span>
			</a> 
		</div>
		<div class="productParamterPartAndImage">
			<div class="productParamterPart">
				<div class="productParamter grayMinFont">产品参数：</div>
				<ul class="productParamterList">
					 <c:forEach items="${pvs}" var="pv">
						<li>${pv.property.name}: ${fn:substring(pv.value,0,10)}</li>
					</c:forEach> 
				</ul>
			</div>
			<div class="productDetailImagesPart">
				<c:forEach items="${product.productDetailImages}" var="productImage">
					<img data-src="img/productDetail/${productImage.id}.jpg" class="lazyLoad"/>
				</c:forEach>
			</div>
		</div>
 		<div class="productReviewContentPart">
		<c:if test="${empty reviews}">
			该商品暂时无评价
		</c:if>
		<c:if test="${!empty reviews}">
			<c:forEach items="${reviews}" var="review">
				<div class="productReviewItem">
					<div class="productReviewItemDesc">
						<div class="productReviewItemContent">${review.content}</div>
						<div class="productReviewItemDate"><fmt:formatDate value="${review.createDate}" pattern="YYYY-MM-dd"/></div>
					</div>
					<div class="productReviewItemUserInfo">
						${review.user.anonymousName}<span class="userInfoGrayPart">(匿名)</span>
					</div>
				</div>		
			</c:forEach>
		</c:if>
		</div> 
	</div>
</div>
<script>
	$(".smallImage").mouseenter(function() {
		$(this).css("border", "1px solid black");
		$(".bigImg").attr("src", $(this).attr("src"));
	});
	$(".smallImage").mouseleave(function() {
		$(this).css("border", "1px solid white");
	});
	$(".increaseNumber").click(function() {
		var text = parseInt($(".productInventory").text());
		var count = parseInt($(".productNumberSettingSpan input").val());
		if (count >= text) {
			return;
		}
		$(".productNumberSettingSpan input").val(++count);
	});

	$(".decreaseNumber").click(function() {
		var count = parseInt($(".productNumberSettingSpan input").val());
		if (count <= 1) {
			return;
		}
		$(".productNumberSettingSpan input").val(--count);
	});
	$(".productNumberSettingSpan input").keyup(function() {
		var count = $(".productNumberSettingSpan input").val();
		var text = parseInt($(".productInventory").text());
		if (count.length <= 0) {
			return false;
		}
		if (parseInt(count) < 1) {
			$(".productNumberSettingSpan input").val("1");
		}
		if (isNaN(count)) {
			count = parseInt(count);
			if (isNaN(count)) {
				$(".productNumberSettingSpan input").val("1");
				return false;
			}
			$(".productNumberSettingSpan input").val(count);
		}
		if (parseInt(count) > text) {
			$(".productNumberSettingSpan input").val(text);
		}
	});
	$(".productReviewTopPart a")
			.click(
					function() {
						$(".productReviewTopPart a[class*='selected']")
								.removeClass("selected");
						$(this).addClass("selected");
						var classDiv = $(this).attr("class");
						if (!classDiv
								.localeCompare("productDetailTopPartSelectedLink selected")) {
							$(".productParamterPartAndImage").show();
							$(".productReviewContentPart").hide();
						} else {
							$(".productReviewContentPart").show();
							$(".productParamterPartAndImage").hide();
						}
					});
	$(".buyDiv button").click(function(){
		<c:if test="${empty user}">
			$("#loginModal").modal("show");
		</c:if>
		<c:if test="${!empty user}">
			var pid = ${product.id};
			var task = $(this).attr("class");
			var num = $("input[name=productCount]").val();
 			$.post(
				"buyone",
				{"pid":pid,"number":num},
				function(result){
					if(result!=null){
						if(task=="buyButton")
							window.location.href=result;
						else if(task=="addCartButton"){
							$(".addCartButton").addClass("addCartedButton");
							$(".addCartButton").html("已加入购物车");
							$(".addCartButton").get(0).blur();
							//更新加入购物车商品数量
							var cartNumber = parseInt($(".cartNumber").text());
							$(".cartNumber").text(cartNumber+1);
						}
					}
				}
			); 
		</c:if>
	});
</script>