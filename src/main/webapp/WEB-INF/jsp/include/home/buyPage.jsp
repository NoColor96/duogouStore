<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="buyPageDiv">
	<form action="createOrder" method="post">
		<div class="buyFlow">
			<img src="img/site/simpleLogo.png" class="pull-left" id="simpleLogo"/> <img
				src="img/site/buyflow.png" class="pull-right" />
			<div style="clear: both;"></div>
		</div>
		<div class="address">
			<div class="addressTip">输入收货地址</div>
			<div class="tableDiv">
				<table class="addressTable">
					<tr>
						<td class="firstColumn">详细地址 <span class="redStart">*</span>
						</td>
						<td colspan="2"><textarea name="address" cols="62"
								placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea></td>
					</tr>
					<tr>
						<td>邮政编码</td>
						<td style="width:160px;"><input type="text" name="post"
							placeholder="如果您不清楚邮递区号，请填写000000" onblur="checkNum(this)"></input></td>
							<td class="checkPost">
								邮编只能为数字
							</td>
					</tr>
					<tr>
						<td>收货人姓名 <span class="redStart">*</span>
						</td>
						<td><input type="text" name="receiver"
							placeholder="长度不超过25个字符"></input></td>
					</tr>
					<tr>
						<td>手机号码 <span class="redStart">*</span>
						</td>
						<td><input type="text" name="mobile" placeholder="请输入11位手机号码" onblur="checkNum(this)"></input></td>
						<td class="checkMobile">
								手机号码只能为11位数字
						</td>
					</tr>
					<c:if test="${!empty receiver}">
						<tr>
							<td colspan="2">
								<button class="useHistoryRecBtn" onclick="useHistoryReceiver(); return false;">使用上次下单地址</button>
							</td>
						</tr>
					</c:if>
				</table>
			</div>
			
		</div>
	<div class="productList">
		<div class="productListTip">确认订单信息</div>
		<table class="productListTable">
			<thead>
				<th class="productName" colspan="2"><img class="duogoubuy"
					src="img/site/DuoGouMiniLogo.png" /> <a class="marketLink">店铺：多购店铺
				</a> <a class="duogouChatLink"> <span class="duogouChatGif duogouChat"></span>
				</a></th>
				<th>单价</th>
				<th>数量</th>
				<th>小计</th>
				<th class="lastTh">配送方式</th>
			</thead>
			<tbody>
				<c:forEach items="${sessionScope.ois}" var="oi" varStatus="i">
					<tr class="orderItemTR">
						<td class="orderItemFirstTD"><img
							src="img/productSingle/${oi.product.firstProductImage.id}.jpg" class="productSmallImage" />
						</td>
						<td class="orderItemProductInfoPartTD productTitle">
							<div class="orderListItemProductLinkOutDiv">
								<a href="product?pid=${oi.product.id}">${oi.product.name}</a>
								<div class="orderListItemProductLinkInnerDiv">
									<img src="img/site/creditcard.png" /> <img
										src="img/site/7day.png" /> <img src="img/site/promise.png" />
								</div>
							</div>
						</td>
						<td class="orderItemProductInfoPartTD">
							<div class="orderItemProductPrice">¥${oi.product.promotePrice}</div>
						</td>
						<td class="orderItemOrderInfoPartTD"><span
							class="orderItemProductNumber">${oi.number}</span></td>
						<td class="orderItemUnitSumTD"><span class="orderItemUnitSum">¥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" maxFractionDigits="1" minFractionDigits="1"/></span>
						</td>
						<c:if test="${i.count==1}">
							<td class="orderItemLastTD" rowspan="5">
								<label
									class="orderItemDeliveryLabel"> <input type="radio"
										checked="checked">普通配送
								</label> 
								<select class="orderItemDeliverySelect">
									<option>快递 免邮费</option>
								</select>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="orderItemSumDiv">
			<div class="leaveWord">
				<span>给卖家留言：</span>
				<textarea placeholder="选填,请先和商家协商一致" rows="1" cols="30" name="userMessage"></textarea>
				<div class="astrictWord">
					还可以输入<b class="residuceWord">100</b>个字
				</div>
			</div>
			<span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${sessionScope.total}" maxFractionDigits="1" minFractionDigits="1"/></span>
		</div>
		<div class="orderItemTotalSumDiv">
			<div class="pull-right">
				<span>实付款：</span> <span class="orderItemTotalSumSpan">￥${sessionScope.total}</span>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="submitOrderDiv">
			<button type="submit" class="submitOrderButton">提交订单</button>
			<div style="clear:both;"></div>
		</div>
	</div>
</form>
</div>
<script>
	$(".orderItemSumDiv textarea").focus(function() {
		$(this).attr("rows", "5");
		$(this).css("border", "1px solid #fa8c16");
		$(".astrictWord").show();
	});
	$(".orderItemSumDiv textarea").blur(function() {
		$(this).attr("rows", "1");
		$(this).css("border", "1px solid #999999");
		$(".astrictWord").hide();
	});
	$(".orderItemSumDiv textarea").keyup(function() {
		var wordSize = $(this).val().length;
		if (wordSize >= 100) {
			var word = new String($(this).val());
			word = word.substring(0, 100);
			$(this).val(word);
			$(".astrictWord").css("color", "#fa8c16");
		} else {
			$(".astrictWord").css("color", "#999999");
		}
		$(".astrictWord .residuceWord").text(100 - parseInt(wordSize));
	});
	function checkNum(tag){
		const value = tag.value;
		switch(tag.getAttribute("name")){
			case 'post':
				if(isNaN(value)){
					$(".checkPost").show();
				}else $(".checkPost").hide();
				break;
			case 'mobile':
				if(isNaN(value) || value.length != 11){
					$('.checkMobile').show();
				}else $(".checkMobile").hide();
				break;
		}
	}
	$(".submitOrderButton").click(function(){
		let inputs = $(".addressTable :input");
		console.log(inputs);
		let isNull = false;
		for(let i = 0;i < inputs.length;i++){
			if(!inputs[i].value && inputs[i].getAttribute("name") != "post"){
				if(inputs[i].className=='useHistoryRecBtn') continue;
				isNull = true;
				break;
			}
		} 
		if(!$(".checkPost").is(":hidden") || !$(".checkMobile").is(":hidden") || isNull){
			alert("请完善收货信息");
			return false;
		}
		return true;
	});
	function useHistoryReceiver(){
	 	$("textarea[name='address']").val("${sessionScope.receiver.address}");
	 	$("input[name='post']").val("${sessionScope.receiver.post}");
	 	$("input[name='post']").val("${sessionScope.receiver.post}");
	 	$("input[name='receiver']").val("${sessionScope.receiver.receiver}");
	 	$("input[name='mobile']").val("${sessionScope.receiver.mobile}");
	}
</script>