<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<jsp:include page="../include/admin/adminNavigator.jsp">
	<jsp:param value="categorys" name="navName"/>
</jsp:include>
<title>属性值编辑</title>
<div class="workingArea">
	<ul class="breadcrumb">
		<li>
			<a href="<c:url value="/admin/categorys"/>">所有分类</a>
		</li>
		<li>
			<a href="<c:url value="../../products"/>">${p.category.name}</a>
		</li>
		<li class="active">
			${p.name}
		</li>
		<li class="active">
			编辑产品属性
		</li>
	</ul>
	<div class="editPVDiv">
		<c:forEach items="${properties}" var="property">
			<div class="eachPV">
				<span class="pvName">${property.name}</span>
				<span class="pvValue">
					<input type="text" class="pvValue" pvid="${property.propertyValue.id}" value="${property.propertyValue.value}" ptid="${property.id}"/>
				</span>
			</div>
		</c:forEach>
	</div>
</div>
<script>
	$(function(){
		$("input.pvValue").blur(function(){
			var currentDom = $(this);
			var ptid = currentDom.attr("ptid");//属性名id
			var pvid = currentDom.attr("pvid");//属性值id
			
			var value = currentDom.val();
			var parentSpan = currentDom.parent("span");
			if(pvid==''){			//当属性值id为空时代表该商品还没添加该属性，调用post方法添加
				if(value=='') return false;
				$.ajax({
					url:"propertyValues",
					type:"post",
					data:{"value":value,"ptid":ptid},
					success:function(result){
						currentDom.attr("pvid",result);
						currentDom.attr("value",value);
						parentSpan.css("border","1px solid green");
					}
				});
			}else if(pvid!=""&&value==""){//删除属性值就删除该商品的该属性
				$.ajax({
					type:"delete",
					url:"propertyValues/"+pvid,
					success:function(result){
						currentDom.attr("pvid","");
						currentDom.attr("value","");
					}
				});
			}else{
				$.ajax({//当属性值id不为空且属性值不为空时则为更新状态
					type:"put",
					dataType:"json",
					contentType:"application/json;charset=utf8", 
					url:"propertyValues",
					data:JSON.stringify({"id":pvid,"value":value}),
					success:function(){
						parentSpan.css("border","1px solid green");
						currentDom.attr("value",value);
					}
				});
			}
		});
	});
</script>
<%@ include file="../include/admin/adminFooter.jsp"%>