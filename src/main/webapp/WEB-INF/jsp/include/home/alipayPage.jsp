<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="alipayPageDiv">
	<div class="alipayLogo">
		<img src="img/site/simpleLogo.png" class="pull-left" id="simpleLogo"/>
		<div style="clear: both;"></div>
	</div>
	<div class="payHeader">
		<span>扫一扫付款（元）</span>
		<div class="confirmMoney">￥${sessionScope.total}</div>
	</div>
	<div class="payBody">
		<img src="img/site/alipay2wei.png" />
	</div>
	<div class="payFooter">
		<a href="payed">
			<button class="confirmPay">确认支付</button>
		</a>
	</div>
</div>