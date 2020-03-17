<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="searchOutDiv">
	<!-- src="img/site/logo.gif" -->
	<a> <img src="img/site/1_hixStore.png" id="logo" />
	</a>
	<div class="searchDiv">
			<input type="text" placeholder="搜一搜" id="keyword" />
			<button class="searchButton" type="submit">搜索</button>
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
	$(".searchButton").click(function(){
		location.href="search?keyword="+$("#keyword").val();
	});
</script>
