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
		<div class="categoryPageDiv">
			<img src="img/category/${param.cid}.jpg" class="brandImg" />
			<div class="categoryProducts">
				<%@include file="searchResultPage.jsp"%>
			</div>
			</div>
