<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(function() {
		$(".rightMenu span").mouseenter(function() {
			var left = $(this).position().left;
			var width = parseInt($(this).css("width"));
			var seat = left + width / 2+5;
			$("#catear").css("left", seat);
			$("#catear").css("top", 161);
			$("#catear").fadeIn(500);
		});
		$(".rightMenu span").mouseleave(function() {
			$("#catear").hide();
		});
		$(".eachCategory").mouseenter(function() {
			$(".categoryMenu").show();
			$(".categoryMenu").css("opacity", "1");
			var cid = $(this).attr("cid");
			$(".productsAsideCategorys[cid=" + cid + "]").show();

		});
		$(".eachCategory").mouseleave(function() {
			$(".productsAsideCategorys").hide();
			$(".categoryMenu").css("opacity", "0.8");
		});
		$(".productsAsideCategorys").mouseenter(function() {
			$(this).show();
			$(".categoryMenu").show();
			$(".categoryMenu").css("opacity", "1");
			var cid = $(this).attr("cid");
			$(".eachCategory[cid=" + cid + "]").css("background", "white");
			$(".eachCategory[cid=" + cid + "] a").css("color", "lightblue");
		});
		$(".productsAsideCategorys").mouseleave(function() {
			$(this).hide();
			var cid = $(this).attr("cid");
			$(".eachCategory[cid=" + cid + "]").css("background", "#e2e2e3");
			$(".eachCategory[cid=" + cid + "] a").css("color", "black");
			$(".categoryMenu").css("opacity", "0.6");
		});
	});
</script>
<img id="catear" src="img/site/catear.png" />
<div class="categoryWithCarousel">
	<div class="headbar">
		<div class="headbarMini">
			<div class="head">
				<span class="glyphicon glyphicon-th-list"></span> <span>
					&nbsp;商品分类 </span>

			</div>
			<div class="rightMenu">
				<span id="superMarket">多多购</span> <span><a href="category?cid=68">品牌女装</a></span> <span><a href="category?cid=79">平衡车</a></span> <span><a href="category?cid=64">太阳镜</a></span>
				<span><a href="category?cid=81">沙发</a></span> <span><a href="category?cid=69">男鞋</a></span>
			</div>
		</div>
	</div>
	<div class="carousel-of-product carousel slide" data-ride="carousel"
		id="carousel-of-product">
		<ol class="carousel-indicators">
			<li data-target="#carousel-of-product" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-of-product" data-slide-to="1"></li>
			<li data-target="#carousel-of-product" data-slide-to="2"></li>
			<li data-target="#carousel-of-product" data-slide-to="3"></li>
			<li data-target="#carousel-of-product" data-slide-to="4"></li>
		</ol>
		<div class="carousel-inner" data-target="#carousel-of-product">
			<div class="item active">
				<a href="category?cid=81">
					<img src="https://s2.ax1x.com/2020/03/11/8AD40I.png" class="carouselImage" />
				</a>
			</div>
			<div class="item">
				<a href="category?cid=71">
					<img src="https://s2.ax1x.com/2020/03/10/8P4QpV.png" class="carouselImage" />
				</a>
			</div>
			<div class="item">
				<a href="category?cid=74">
					<img src="https://s2.ax1x.com/2020/03/10/8P416U.png" class="carouselImage" />
				</a>
			</div>
			<div class="item">
				<a href="category?cid=77">
					<img src="https://s2.ax1x.com/2020/03/11/8ADhnA.png" class="carouselImage" />
				</a>
			</div>
			<div class="item">
				<a href="category?cid=80">
					<img src="https://s2.ax1x.com/2020/03/10/8P4nkn.png" class="carouselImage" />
				</a>
			</div>
			
		</div>
 		<div class="categoryMenu">
			<c:forEach items="${cs}" var="c" varStatus="i">
				<c:if test="${i.count<=17}">
					<div class="eachCategory" cid="${c.id}">
						<span class="glyphicon glyphicon-link"></span> <a href="category?cid=${c.id}">${c.name}</a>
					</div>
					<div class="productsAsideCategorys" cid="${c.id}">
						<c:forEach items="${c.productsByRow}" var="productByRow" varStatus="j">
							<div class="row">
								<c:forEach items="${productByRow}" var="product">
									<a href="product?pid=${product.id}">
										<c:forEach items="${fn:split(product.subTitle,' ')}" var="title" varStatus="st">
												<c:if test="${st.index==0}">
													${title}
												</c:if>
										</c:forEach>
									</a>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</c:forEach>
		</div> 
	</div>
	<div class="homepageCategoryProducts">
		<c:forEach items="${cs}" var="c" varStatus="i">
			<div class="eachHomepageCategoryProducts">
				<div class="left-mark"></div>
				<span class="categoryTitle">${c.name}</span> <br>
				<c:forEach items="${c.products}" var="product" varStatus="j">
					<div class="productItem">
						<a href="product?pid=${product.id}"> <img data-src="img/productSingle/${product.firstProductImage.id}.jpg" class="lazyLoad"/>
							<div class="productItemDesc">${fn:substring(product.name,0,23)}</div>
							<span class="productPrice"> ${product.promotePrice}
							</span>
						</a>
					</div>
				</c:forEach>
			</div>
		</c:forEach>
<img src="img/site/end.png" class="endpng" id="endpng" />
	</div>