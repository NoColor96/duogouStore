<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="simpleSearchOutDiv">
	<a> <img src="img/site/simpleLogo.png" id="simpleLogo" />
	</a>
	<div class="simpleSearchDiv pull-right">
		<input type="text" id="keyword" placeholder="搜一搜" />
		<button class="searchButton" type="submit">搜多购</button>
		<div class="searchBelow">
			<c:forEach items="${randomCategorys}" var="randomCategory"
				varStatus="i">
				<span> <a href="category?cid=${randomCategory.id}">${randomCategory.name}</a>
					<c:if test="${i.count<4}">
						<span>|</span>
					</c:if>
			</c:forEach>
		</div>
	</div>
</div>
<script>
	$(".searchButton").click(function() {
		location.href = "search?keyword=" + $("#keyword").val();
	});
</script>