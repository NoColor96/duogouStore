<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<script>
		$(function(){
			$(".sortBarPrice").focus(function(){
				$(".isPriceFilter").fadeIn(200);
			});
			$(".sortBarPrice").blur(function(){
				$(".isPriceFilter").fadeOut(200);
			});
			$(".sortBarPrice").keyup(function(){
				if(isNaN($(this).val())){
					$(this).val("");
				}
			});
		
			$(".sure").click(function(){
				var beginPrice = new Number($(".beginPrice").val());
				var endPrice = new Number($(".endPrice").val());
				if(beginPrice==""&&endPrice==""){
					return;
				}
				for(var i = 0;i < $(".productUnit").length;i++){
					$(".productUnit").eq(i).hide();
					var price = new Number($(".productUnit").eq(i).attr("price"));
					if(beginPrice<price&&price<endPrice){
						$(".productUnit").eq(i).show();
					}
				}
			});
			$(".cancel").click(function(){
				$(".beginPrice").val("");
				$(".endPrice").val("");
				
			});
		});
		
	</script>
	<div class="sortBar">
		<table class="sortBarTable">
			<c:if test="${empty param.cid}">
				<c:set var="urlPath" value="search?keyword=${param.keyword}" scope="page"/>
			</c:if>
			<c:if test="${!empty param.cid}">
				<c:set var="urlPath" value="category?cid=${param.cid}" scope="page"/>
			</c:if>
			<tr>
				<td class="grayColunm">
					<a href="${pageScope.urlPath}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a>
				</td>
				<td>
					<a href="${pageScope.urlPath}&sort=heat"">人气<span class="glyphicon glyphicon-arrow-down"></span></a>
				</td>
				<td>
					<a href="${pageScope.urlPath}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a>
				</td>
				<td>
					<a href="${pageScope.urlPath}&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a>
				</td>
				<td>
					<a href="${pageScope.urlPath}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a>
				</td>
			</tr>
		</table>
		<div class="priceFilter">
			<table class="sortBarTable">
				<tr class="priceSort">
					<td>
						<input type="text" placeholder="请输入" class="sortBarPrice beginPrice" />
					</td>
					<td class="grayColumn priceMiddleColumn">~</td>
					<td>
						<input type="text" placeholder="请输入" class="sortBarPrice endPrice" />
					</td>
			</table>
			<div class="isPriceFilter">
				<button class="cancel">取消</button>
				<button class="sure">确定</button>
			</div>
		</div>
	</div>
