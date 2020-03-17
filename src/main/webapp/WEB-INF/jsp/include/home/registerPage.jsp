<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<script>
		$(function(){
				<c:if test="${!empty message}">
					$(".errorMessage").html("${message}");
					$(".registerErrorMessageDiv").css("visibility","visible");
				</c:if>
				$(".registerTable input").keypress(function(e){
					if(e.which == 13){
						$(".registerForm").submit();
					}
				});
				$(".registerForm").submit(function(){
					if($(".errorMessage").html().length!=0) return false;
					if($(".errorMessage").val()=="该用户名已存在，请更换") return false;
					if($("#name").val().length==0){
						$(".errorMessage").html("请输入用户名");
						$(".registerErrorMessageDiv").css("visibility","visible");
						return false;
					}
					if($("#password").val().length==0){
						$(".errorMessage").html("请输入密码");
						$(".registerErrorMessageDiv").css("visibility","visible");
						return false;
					}
					if($("#repeatpassword").val().length==0){
						$(".errorMessage").html("请重复输入密码");
						$(".registerErrorMessageDiv").css("visibility","visible");
						return false;
					}
					if($("#repeatpassword").val()!=$("#password").val()){
						$(".errorMessage").html("两次密码输入不一致");
						$(".registerErrorMessageDiv").css("visibility","visible");
						return false;
					}
				}); 
				$("#name").blur(function(){
					var name = $(this).val();
					$.ajax({
						type:"post",
						url:"existUserName",
						data:{"name":name},
						success:function(result){
							if(result=='failure'){
								$(".errorMessage").html("该用户名已存在，请更换");
								$(".registerErrorMessageDiv").css("visibility","visible");
							}else{
								$(".errorMessage").html("");
								$(".registerErrorMessageDiv").css("visibility","hidden");
							}
						}
					});
				});
		});
	</script>
<form method="post" action="register" class="registerForm">
	<div class="registerDiv">
		<div class="registerErrorMessageDiv" style="visibility:hidden;">
			<div class="alert alert-danger">
				<span class="errorMessage"></span>
			</div>
		</div>
		<table class="registerTable">
			<tr>
				<td class="registerTip registerTableLeftTD">设置会员名</td>
				<td></td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">登录名</td>
				<td class="registerTableRightTD"><input type="text"
					placeholder="会员名一旦设置成功，无法修改" name="name" id="name" /></td>
			</tr>
			<tr>
				<td class="registerTip registerTableLeftTD">设置登陆密码</td>
				<td class="registerTableRightTD">登陆时验证，保护账号信息</td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">登陆密码</td>
				<td class="registerTableRightTD"><input type="password"
					name="password" id="password" placeholder="设置你的登陆密码" /></td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">密码确认</td>
				<td class="registerTableRightTD"><input type="password"
					 id="repeatpassword" placeholder="请再次输入你的密码" /></td>
			</tr>
			<tr>
				<td class="registerButtonTD" colspan="2">
					<a>
						<button>提交</button>
					</a>
				</td>
			</tr>
		</table>
	</div>
</form>