<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav class="top">
	<div class="top_middle">
		<a href="home"> <span class="glyphicon glyphicon-home"></span>
			多购首页
		</a> <span>嗨，欢迎来多购</span>
		<c:if test="${empty user}">
			<a href="login">请登录</a>
			<a href="register">免费注册</a>
		</c:if>
		<c:if test="${!empty user}">
			<a>${user.name}</a>
			<a href="logout">退出</a>
		</c:if>
		<span class="pull-right topRight"> <a href="myOrder">我的订单</a> <a
			href="cart"> <span class="glyphicon glyphicon-shopping-cart"></span>
				购物车<strong class="cartNumber">0</strong>件
		</a>
		</span>
	</div>
</nav>
<script>
	<c:if test="${!empty user}">
		$(function() {
			$.post(
					"getCartNumber", 
					function(result) {
						if ("faild" != result) {
							$(".cartNumber").text(result);
						}
					}
				);
		});
	</c:if>
</script>