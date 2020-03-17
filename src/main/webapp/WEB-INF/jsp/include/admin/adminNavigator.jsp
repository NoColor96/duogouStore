<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="navigatorDiv">
	<nav class="navbar navbar-default navbar-fixed-top navbar-inverse" >
		<a href="<c:url value="/home"/>" style="user-select:none;"><img src="<c:url value="/img/site/DuoGouMiniLogo.png"/>" style="margin-left:10px; margin-right:0px;" class="pull-left" height="45px"></a>
		<c:if test="${empty adminUser}">
			<a class="navbar-brand <c:if test="${param.navName eq 'login'}">navbar-active</c:if>" href="/admin">多购后台</a>
		</c:if>
		<c:if test="${!empty adminUser}">
			<a class="navbar-brand <c:if test="${param.navName eq 'categorys'}">navbar-active</c:if>" href="<c:url value="/admin/categorys"/>">分类管理</a>
			<a class="navbar-brand <c:if test="${param.navName eq 'orders'}">navbar-active</c:if>" href="<c:url value="/admin/orders"/>">订单管理</a>
			<a class="navbar-brand <c:if test="${param.navName eq 'users'}">navbar-active</c:if>" href="<c:url value="/admin/users"/>">用户管理</a>
			<a class="navbar-brand" href="#nowhere" onclick="openChat()">用户消息</a>
			<a class="navbar-brand logout pull-right" style="min-width:160px;" href="<c:url value="/admin/logout"></c:url>">管理员：${sessionScope.adminUser.name}</a>
		</c:if>
		<script>
			$(".logout").mouseenter(function(){
				$(this).text("单击注销");
			});
			$(".logout").mouseleave(function(){
				$(this).text("管理员："+"${sessionScope.adminUser.name}");
			});
			function openChat(){
				window.open("<c:url value='/chat/?t=cm9sZT0tMjE1'></c:url>",'','width=739,height=622,toolbar=no, status=yes, menubar=no, resizable=no, scrollbars=no,left=200,top=100')
			}
		</script>
	</nav>
</div>
