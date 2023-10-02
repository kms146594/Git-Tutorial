<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 사이트</title> 
</head>
<body>
	<%
		String userID = null;	// userID는 기본 null
		if(session.getAttribute("userID") != null) {	
			userID = (String) session.getAttribute("userID");	// userID에 할당된 세션 값 저장
		}
		if (userID != null){	// 로그인이 되어있는 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}		
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
			|| user.getUserGender() == null || user.getUserEmail() == null) {	// 입력 값이 없어서 null인 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		} else {											
			UserDAO userDAO = new UserDAO();	// 데이터베이스에 접근 가능한 객체
			int result = userDAO.join(user);	// join 함수 수행
			if (result == -1) {					// 결과 값이 -1이 반환된 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {							// 전부 다 회원가입 가능
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'"); 	// 메인 페이지로 이동
				script.println("</script>");
			}
		}
	
	%>

</body>
</html>