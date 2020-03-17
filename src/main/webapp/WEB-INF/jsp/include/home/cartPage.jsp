<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<div class="cartDiv">
	<div class="cartTitle pull-right">
		<span>已选商品 (不含运费)</span> <span class="cartTitlePrice redColor" price="0">
			¥0.00 </span>
		<button class="createOrderButton" disabled="disabled">结算</button>
	</div>
	<div style="clear: both;"></div>
	<div class="cartProductList">
		<table class="cartProductTable">
			<thead>
				<th class="selectAndImage"><img
					src="img/site/cartNotSelected.png" class="selectAllItem"
					selectit="false" />全选</th>
				<th>商品信息</th>
				<th>单价</th>
				<th>数量</th>
				<th>金额</th>
				<th>操作</th>
			</thead>
			<tbody>
			<c:if test="${empty ois}">
				<tr>
					<td colspan="6" align="center">购物车空空如也o(TヘTo)</td>
				</tr>
			</c:if>
			<c:forEach items="${ois}" var="oi" varStatus="i">
				<tr class="cartProductItemTR" oiid="${oi.id}" pid="${oi.product.id}">
					<td><img src="img/site/cartNotSelected.png"
						class="cartProductItemIfSelected" selectit="false" /> <!--<a style="display: none;">
									<img src="img/site/cartSelected.png" class="cartSelected"/>
								</a>--> <img data-src="img/productSingle/${oi.product.firstProductImage.id}.jpg"
						class="cartProductImg laztLoad" /></td>
					<td>
						<div class="cartProductLinkOutDiv">
							<a class="cartProductLink" href="product?pid=${oi.product.id}">${oi.product.name}</a>
							<div class="cartProductLinkInnerDiv">
								<img src="img/site/creditcard.png" title="支持信用卡支付" /> <img
									src="img/site/7day.png" title="消费者保障服务,承诺7天退货" /> <img
									src="img/site/promise.png" title="消费者保障服务,承诺如实描述" />
							</div>
						</div>
					</td>
					<td><span class="cartProductItemOringalPrice"
						style="display: block;"> ¥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" maxFractionDigits="1" minFractionDigits="1"/> </span> <span
						class="cartProductItemPromotionPrice redColor unitPrice" price="${oi.product.promotePrice}">
							¥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" maxFractionDigits="1" minFractionDigits="1"/> </span></td>
					<td>
						<div class="cartProductChangeNumberDiv">
							<a class="numberMinus">-</a> <input type="text" value="${oi.number}"
								style="width: 42px;" class="productCount" /> <a
								class="numberPlus">+</a>
						</div> <span style="color: #999999;">库存：<span class="inventory">${oi.product.stock}</span></span>
					</td>
					<td style="width: 120px;"><span
						class="cartProductItemSmallSumPrice redColor" price="${oi.number*oi.product.promotePrice}">¥<fmt:formatNumber type="number" value="${oi.number*oi.product.promotePrice}" maxFractionDigits="1" minFractionDigits="1"/></span></td>
					<td><a class="deleteOrderItem" style="cursor:default;">删除</a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="cartFoot">
		<span class="selectAndImage"><img
			src="img/site/cartNotSelected.png" class="selectAllItem"
			selectit="false" />全选</span>
		<div class="pull-right">
			<span>已选商品 <span class="cartSumNumber redColor"
				style="font-size: 16px;">0 </span>件
			</span> <span>合计 (不含运费)：</span> <span class="cartSumPrice redColor" price="0">¥0.00</span>
			<button class="createOrderButton" disabled="true">结 算</button>
		</div>
	</div>
</div>
<div class="modal" id="deleteModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span>确认要删除吗?</span>
				<button class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default">返回</button>
				<button class="btn btn-danger confirmDeleteBtn">删除</button>
			</div>
		</div>
	</div>
</div>
<script>
	//全选
	$(".selectAllItem").click(function() {
		if ($(this).attr("selectit") == "false") {
			$("img[selectit]").each(function() {
				$(this).attr("selectit", "selectit");
			});
		} else {
			$("img[selectit]").each(function() {
				$(this).attr("selectit", "false");
			});
		}
		changeSelect();
	});
	//修改已选中商品元素样式及修改选中商品显示数量
	function changeSelect() {
		var sumSelect = new Number(0); //选中商品数量
		$("img[selectit='selectit']").each(function() {
			$(this).attr("src", "img/site/cartSelected.png");
			if ($(this).attr("class") == "selectAllItem") {
				return true; //相当于js中的continue，跳过全选按钮
			}
			sumSelect++; //选中一个商品数量加1
			$(this).parent().parent().css("background", "#fff8e1"); //修改选中的元素的背景颜色
		});
		$(".cartSumNumber").text(sumSelect); //修改选中商品数量
		$("img[selectit='false']").each(function() {
			$(this).attr("src", "img/site/cartNotSelected.png");
			if ($(this).attr("class") == "selectAllItem") {
				return true;
			}
			$(this).parent().parent().css("background", "none");
		});
		if (isSelect() == true) { //如果有选中项，即改变结算按钮样式
			$(".createOrderButton").css("background", "#fa8c16");
			$(".createOrderButton").removeAttr("disabled");

		} else {
			$(".createOrderButton").css("background", "#aaaaaa");
			$(".createOrderButton").attr("disabled", "disabled");
		}
		changeSumPrice();
	}
	$(".cartProductItemIfSelected").click(function() {
		if ($(this).attr("selectit") == "false") {
			$(this).attr("selectit", "selectit");
			if ($(".cartProductItemIfSelected[selectit='false']").length == 0) {
				$(".selectAllItem").each(function() {
					$(this).attr("selectit", "selectit");
				});
			}
		} else {
			$(this).attr("selectit", "false");
			$(".selectAllItem").each(function() {
				$(this).attr("selectit", "false");
			});
		}
		changeSelect();
	});
	//监听数量输入框变动
	$(".productCount").on("keyup", changeCount);
	//商品数量的加减
	$(".numberMinus").click(function() {
		var parent = $(this).parents("tr");
		var productCount = parent.find(".productCount");
		var count = parent.find(".productCount").val();
		parent.find(".productCount").val(--count);
		 $(productCount).trigger("keyup"); 
	});
	$(".numberPlus").click(function() {
		var parent = $(this).parents("tr");
		var productCount = parent.find(".productCount");
		var count = productCount.val();
		parent.find(".productCount").val(++count);
		$(productCount).trigger("keyup");
	});
	//商品数量
	function changeCount() {
		var parent = $(this).parents("tr");
		var productCount = parent.find(".productCount");
		var count = productCount.val();
		var inventory = parseInt(parent.find(".inventory").text());
		if (count.length <= 0) {
			return false; //允许用户手动输入第一位数字
		}
		count = parseInt(count);
		if (isNaN(count) || count == 0)
			count = 1;
		if (count > inventory)
			count = inventory;
		productCount.val(count);
		var oiid = parent.attr("oiid");
		sysNum(oiid,count);//同步数据库商品数量
		price = (formatPrice(parent.find(".unitPrice").attr("price")) * count)
				.toFixed(1); //小计
		parent.find(".cartProductItemSmallSumPrice").text("¥" + price);
		parent.find(".cartProductItemSmallSumPrice").attr("price",price);
		if (isSelect() == true)
			changeSumPrice();
	}
	//所有选中商品的总价
	function changeSumPrice() {
		var sumPrice = new Number(0); //所有选中商品的总价格
		$(".cartProductItemIfSelected[selectit='selectit']").each(
				function() {
					sumPrice += formatPrice($(this).parents("tr").find(
							".cartProductItemSmallSumPrice").attr("price"));
				});
		sumPrice = sumPrice.toFixed(2);
		$(".cartSumPrice").attr("attr",sumPrice);
		$(".cartTitlePrice").attr("attr",sumPrice);
		$(".cartSumPrice").text("¥" + sumPrice);
		$(".cartTitlePrice").text("¥" + sumPrice);
	}
	//格式化价格
	function formatPrice(price) {
		price = parseFloat(price.replace(/¥/g, ""));
		return price;
	}
	//判断是否有商品被选中
	function isSelect() {
		var value = false;
		if ($("img[selectit='selectit']").length != 0) {
			value = true;
		}
		return value;
	}
	//同步后台商品数量
	function sysNum(oiid,number){
		$.post(
			"changeOrderItem",
			{"id":oiid,"number":number},
			function(result){
				if("success"!=result){
					window.location.href="login";
				}
			}
		);
	}
	var oiid = 0;
	$(".deleteOrderItem").click(function(){
		oiid = $(this).parents("tr").attr("oiid");
		$("#deleteModal").modal();
	});
	$(".confirmDeleteBtn").click(function(){
		$("#deleteModal").modal("hide");
		$.post(
			"deleteOrderItem",
			{"oiid":oiid},
			function(result){
				if("success"==result){
					$(".cartProductItemTR[oiid="+oiid+"]").hide();
					sysCartNumber(oiid);
					
				}
			}
		);
	});
	//同步top栏购物车商品数量
	function sysCartNumber(oiid){
		var cartNumber = $(".cartNumber").text();
		$(".cartNumber").text(cartNumber-1);
	}
	$(".createOrderButton").click(function(){
		var page = "buy?";
		$(".cartProductItemIfSelected[selectit='selectit']").each(
				function(i){
					 page += "&oiid="+$(this).parents("tr").attr("oiid");
				}
		);
		location.href = page;
	});
</script>