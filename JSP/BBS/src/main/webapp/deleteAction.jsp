<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>			<%-- 게시글 작성을 위한 데이터베이스 --%>
<%@ page import = "bbs.Bbs" %> 
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
			script.println("location.href = 'login'.jsp'");	// 로그인 페이지로 이동
			script.println("</script>");		
		} 
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {				// 로그인이 되어있는 경우									
				BbsDAO bbsDAO = new BbsDAO();	// 
				int result = bbsDAO.delete(bbsID);	
				if (result == -1) {					// 결과 값이 -1이 반환된 경우 = 데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {							// 글 삭제 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");	// 게시판으로 이동
					script.println("</script>");
				}
		}
		
	
	%>

</body>
</html>