<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="home/modal.jsp"%>
<div class="footer">
	<div class="footer_ensure" id="footer_ensure">
		<a> <img src="img/site/ensure.png" />
		</a>
	</div>
	<div class="footer_desc" id="footer_desc">
		<div class="descColumn">
			<span class="descColumnTitle">购物指南</span> <a>免费注册</a> <a>开通支付宝</a> <a>支付宝充值</a>
		</div>
		<div class="descColumn">
			<span class="descColumnTitle">多购保障</span> <a>发票保障</a> <a>售后规则</a> <a>缺货赔付</a>
		</div>
		<div class="descColumn">
			<span class="descColumnTitle">支付方式</span> <a>快捷支付</a> <a>信用卡</a> <a>蚂蚁花呗</a>
			<a>货到付款</a>
		</div>
		<div class="descColumn">
			<span class="descColumnTitle">商家服务</span> <a>商家入驻</a> <a>商家中心</a> <a>多购智库</a>
			<a>多购规则</a> <a>物流服务</a> <a>喵言喵语</a> <a>运营服务</a>
		</div>
		<div class="descColumn">
			<span class="descColumnTitle">手机多购</span> <a><img
				src="img/site/ma.png" /></a>
		</div>
	</div>
	<div style="clear: both;"></div>
		<img src="img/site/cateye.png" class="cateye" id="cateye" />
		<div class="copyright" id="copyright">
		<div class="coptyrightMiddle">
			<div class="wite_link">
				<a href="#nowWhere">关于多购</a> <a href="#nowWhere">帮助中心</a> <a
					href="#nowWhere">开放平台</a> <a href="#nowWhere">诚聘英才</a> <a
					href="#nowWhere">联系我们</a> <a href="#nowWhere">网站合作</a> <a
					href="#nowWhere">法律声明</a> <a href="#nowWhere">知识产权</a> <a
					href="#nowWhere">廉正举报</a>
			</div>
			<div class="wite_link">
				<a href="#nowWhere">阿里巴巴集团</a><span class="slash">|</span> <a
					href="#nowWhere">淘宝网</a><span class="slash">|</span> <a
					href="#nowWhere">多购</a><span class="slash">|</span> <a
					href="#nowWhere">赶集</a><span class="slash">|</span> <a
					href="#nowWhere">全球速卖通</a><span class="slash">|</span> <a
					href="#nowWhere">1688</a><span class="slash">|</span> <a
					href="#nowWhere">阿里妈妈</a><span class="slash">|</span> <a
					href="#nowWhere">阿里旅行·去啊</a><span class="slash">|</span> <a
					href="#nowWhere">阿里云计算</a><span class="slash">|</span> <a
					href="#nowWhere">阿里通信</a><span class="slash">|</span> <a
					href="#nowWhere">YunOS</a><span class="slash">|</span> <a
					href="#nowWhere">万网</a> <span class="slash">|</span> <a
					href="#nowWhere">高德</a> <span class="slash">|</span> <a
					href="#nowWhere">优视</a> <span class="slash">|</span> <a
					href="#nowWhere">友盟</a> <span class="slash">|</span> <a
					href="#nowWhere">天天动听</a> <span class="slash">|</span> <a
					href="#nowWhere">来往</a><span class="slash">|</span> <a
					href="#nowWhere">钉钉</a> <span class="slash">|</span> <a
					href="#nowWhere">支付宝</a>
			</div>
			<div class="license">
				<span>本站以学习为目的开发，无任何商业用途，素材取自天猫官方商城，非常感谢！</span>
				<div class="copyRightYear">duogou.hixqz.com</div>
				<a rel="nofollow" href="http://www.beian.miit.gov.cn" target="_blank" style="color:#686868;">闽ICP备18028426号-2</a>
			</div>
		</div>
	</div>
</div>
</body>
<script>
	$(function(){
	 	$(".footer a").click(function(){
			alert("本站以学习为目的开发，素材取自天猫官方商城，非常感谢！ψ(._. )>");
		}) 
		$(".notImplementLink").click(function(){
			alert("这个功能还没开发(￣y▽,￣)╭ ");	
		});	
		
		var clickCount = 0;
		$("#catear").css("transition","all 0.3s");
		$("#superMarket").click(function(){
			if(clickCount>=10) return false;
			clickCount++;
			$("#catear").css("top",161-clickCount*2+"px");
			if(clickCount==10){			
				$("#catear").css("top",92+"px");
				setTimeout(function(){$("#catear").css("left",720+"px");},300);
				setTimeout(function(){$("#catear").css("left",710+"px");},600);
				setTimeout(function(){$("#catear").css("left",720+"px");},900);
				setTimeout(function(){$("#catear").css("left",710+"px");},1200);
				setTimeout(function(){$("#catear").css("left",720+"px");},1500);
				var keywords = "正在进入后台管理系统......";
				keywords = keywords.split("");
				$("#keyword").attr("placeholder","");
				var keyIndex = 0;
				var keywordSiv = setInterval(function(){
					if(keyIndex>=keywords.length-1){ 
						clearInterval(keywordSiv);
						location.href="/admin";
					}
					var preKeyWord = $("#keyword").attr("placeholder");
					$("#keyword").attr("placeholder",preKeyWord+keywords[keyIndex]);
					keyIndex++;
				},300); 
			}
		});
		
		//是否允许打开聊天窗口
		$(".duogouChat").click(function(){
			if(!"${sessionScope.user}"){
				$("#loginModal").modal("show");
			}else{
				window.open("<c:url value='/chat/?t=${sessionScope.role}'></c:url>",'','width=500,height=622,toolbar=no, status=yes, menubar=no, resizable=no, scrollbars=no,left=200,top=100')
			}
		});
		//提示标签
		$(".duogouChat").tooltip();
		
	 	$("#keyword").keyup(function(e) {
			if (e.which == 13) {
				$(".searchButton").click();
			}
		}); 
	});
</script>