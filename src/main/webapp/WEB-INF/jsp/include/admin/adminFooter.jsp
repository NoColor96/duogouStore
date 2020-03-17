<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<div class="footer">
	<!-- restful表单提交delete隐藏域 -->
	<form action="" method="post" id="deleteForm">
		<input type="hidden" name="_method" value="delete"/>
	</form>
	<script>
		function deleteBtn(e){
			var a = $(e).parents("a");
			if(a.attr("deleteLink")=="false"){
				alert("该条目有关联子项，为确保数据安全，请删除相关子项后再删除此条目！");
				return false;
			}else if(a.attr("deleteLink")=="true"){
					if(confirm("确认要删除吗？")){
						$("#deleteForm").attr("action",a.attr("href"));
						$("#deleteForm").submit();  
					}else return false;
			}
			
		}
	</script>
</div>
</body>
</html>