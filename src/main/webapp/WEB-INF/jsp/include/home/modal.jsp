<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<div class="modal fade" id="loginModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<div class="alert alert-danger failureMessage"></div>
					<div class="login_acount_text">账户登录</div>
					<div class="loginInput ">
						<span class="loginInputIcon "> <span
							class="glyphicon glyphicon-user"></span> <input type="text"
							name="name" placeholder="手机/会员名/邮箱" />
						</span>
					</div>
					<div class="loginInput ">
						<span class="loginInputIcon "> <span
							class="glyphicon glyphicon-lock"></span> <input type="password"
							name="password" placeholder="密码" />
						</span>
					</div>
					<span class="text-danger">请输入您的多购账号与密码</span>
					<div class="forgetAndRegister">
						<a class="notImplementLink">忘记登录密码</a> <a class="pull-right"
							href="register">免费注册</a>
						<div style="clear: both;"></div>
					</div>
					<button type="submit" class="btn btn-block redButton loginModalBtn">登录</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(function(){
		 $(".modal-dialog .loginInput input").keypress(function(e) {
			if (e.which == 13) {
				$(".loginModalBtn").click();
			}
		}); 
		$(".loginModalBtn").click(function(){
			var name = $("input[name=name]").val();
			var pwd = $("input[name=password]").val();
			if(name.length==0){
				$(".failureMessage").html("用户名不能为空");
				$(".failureMessage").css("visibility","visible");
				return;
			}
			if(pwd.length==0){
				$(".failureMessage").html("密码不能为空");
				$(".failureMessage").css("visibility","visible");
				return;	
			}
			$.post(
					"login",
					{"name":name,"password":pwd},
					function(result){
						if(result=="failure"){
							$(".failureMessage").html("用户名或密码错误");
							$(".failureMessage").css("visibility","visible");
						}else if(result=="success"){
							location.reload();
						}
					}
			); 
		});
	});
</script>