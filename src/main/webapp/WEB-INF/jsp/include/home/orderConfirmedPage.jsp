<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="orderFinishDiv">
	<div class="orderFinishTextDiv">
		<img src="img/site/orderFinish.png" /> <span>交易已经成功，卖家将收到您的货款。</span>
		<br><span class="autoJump"><label>3</label>秒后将自动<a href="review?oid=${param.oid}"> 跳转 </a>至评价页面</span>
	</div>
</div>
<script>
	$(function(){
		setInterval(changeAutoJump,1000);
		function changeAutoJump(){
			var autoJump = $(".orderFinishDiv .autoJump label");
			if(parseInt(autoJump.text())<=1){
				location.href="review?oid=${param.oid}";
			}
			autoJump.text(parseInt(autoJump.text())-1);
		}
	});
</script>