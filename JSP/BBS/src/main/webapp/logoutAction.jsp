<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 사이트</title> 
</head>
<body>
	<%
		session.invalidate();		// 할당된 세션 제거
	%>
	<script>
		location.herf = 'main.jsp';		// main으로 이동
	</script>
</body>
</html>