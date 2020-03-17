<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<script>
	$(function(){
		$("ul.pagination li.disabled a").click(function(){
			return false;
		});
	});
	
</script>
<nav>
	<ul class="pagination">
		<li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
			<a href="?start=0">
				<span>&laquo;</span>
			</a>
		</li>
		<li <c:if test="${!page.hasPreviouse}"> class="disabled"</c:if>>
			<a href="?start=${param.start-page.count}">
				<span>‹</span>
			</a>
		</li>
		<c:forEach begin="0" end="${page.totalPage-1<0?0:page.totalPage-1}" varStatus="status"> 
			<li <c:if test="${param.start==status.index*page.count || param.start==null && status.index==0}">class="disabled"</c:if>>
				<a href="?start=${status.index*page.count}" <c:if test="${param.start==status.index*page.count || param.start==null && status.index==0}">class="current"</c:if>>${status.count}</a>
			</li>
		</c:forEach>
		
		<li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
			<a href="?start=${param.start+page.count}">
				<span>›</span>
			</a>
		</li>
		<li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
			<a href="?start=${page.last}">
				<span>»</span>
			</a>
		</li>
	</ul>
</nav>
