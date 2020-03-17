<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
	<script src="<c:url value="/js/jquery/2.0.0/jquery.min.js"/>"></script>
	<link href="<c:url value="/css/bootstrap/3.3.6/bootstrap.min.css"/>" rel="stylesheet">
	<script src="<c:url value="/js/bootstrap/3.3.6/bootstrap.min.js"/>"></script>
	<link rel="shortcut icon" type="image/x-icon" href="/img/site/favicon.ico">
	<link href="<c:url value="/css/back/style.css"/>" rel="stylesheet">
<script>
	function checkEmpty(id,name){
		var value=$("#"+id).val();
		if(value.length==0){
			alert(name+"不能为空");
			$("#"+id)[0].focus();
			return false;
		}
		return true;
	}
	function checkNumber(id,name){
		checkEmpty(id,name);
		var value=$("#"+id).val();
		if(isNaN(value)){
			alert(name+"必须是数字");
			return false;
		}
		return true;
	}
	function checkInt(id,name){
		checkEmpty(id,name);
		var value=$("#"+id).val();
		if(parseInt(value)!=value){
			alert(name+"必须是整数");
			return false;
		}
		return true;
	}
</script>
</head>
<body>