<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>sosu: 소소한 수도권 사람들의 모임</title>

</head>
<body>

	<!-- header -->
	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<!-- body -->
	<tiles:insertAttribute name="body"/>
	
	<!-- footer --> 
	<tiles:insertAttribute name="footer"/>
	
</body>
</html>