<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title> 
</head>
<body>
	<%
		String userID = null;	// userID는 기본 null
		if(session.getAttribute("userID") != null) {	
			userID = (String) session.getAttribute("userID");	// userID에 할당된 세션 값 저장
		}
		if (userID == null){	// 로그인이 되어있지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login'.jsp'");
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {	// 입력 값이 없어서 null인 경우
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");	
				} else {											
					BbsDAO bbsDAO = new BbsDAO();	// 
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());	// 
					if (result == -1) {					// 결과 값이 -1이 반환된 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {							//
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}
				}
			
		}
		
	
	%>

</body>
</html>