<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <%--반응형 웹,pc&모바일--%>
<link rel="stylesheet" href="css/bootstrap.min.css"> <%--부트스트랩 css 참조--%>
<title>JSP 게시판 웹 사이트</title> 
</head>

<body>
	<%
		String userID = null;		// 로그인 안 한 경우 userID = null
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");		// 로그인 한 경우 userID
		}
		if (userID == null) {		// 로그인을 하지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;				
		if (request.getParameter("bbsID") != null) {		// bbsID 값을 전달 받음
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {			// bbsID 값이 전달되지 않음
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);		
		if (!userID.equals(bbs.getUserID())) {			// bbsID 값이 글을 작성한 사람인지 확인
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	%>
                                     <%-- 웹사이트 전반적인 구성 --%>
                                     
    <nav class="navbar navbar-default"> 
        <div class="navbar-header"> <%-- 헤더 --%>
             <button type="button" class="navbar-toggle collapsed"
             	data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
             	aria-expanded="false">
             	<span class="icon-bar"></span> <%-- 아이콘 바(작대기) --%>
             	<span class="icon-bar"></span>
             	<span class="icon-bar"></span>
             </button>
             <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a> <%-- 로고 --%>
        </div>
               
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"
       				aria-expanded="false">			<%-- 위 data-target과 같은 이름--%>
           	  <ul class="nav navbar-nav"> <%-- ul은 리스트를 보여줄 때 사용 --%>
                   <li><a href="main.jsp">메인</a></li> 
                   <li class="active"><a href="bbs.jsp">게시판</a></li>	<%-- active:현재 선택됨 --%>
           	  </ul>
              <ul class="nav navbar-nav navbar-right">		 <%-- 게시판 오른쪽 --%>
				  <li class="dropdown">
           			  <a href="#" class="dropdown-toggle"
                    	  data-toggle="dropdown" role="button" aria-haspopup="true"
                    	  aria-expanded="false">회원관리<span class="caret"></span></a>
                    		<%-- #:가리키는 링크가 없음, caret: 아이콘 --%>                                 
           			  <ul class="dropdown-menu"> 		<%-- 네비게이션 바 구축 --%>
                		  <li><a href="logoutAction.jsp">로그아웃</a></li>		
           			  </ul>
         		  </li>
       		  </ul>
       	 </div>
	</nav>     
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">	<%-- 내용을 updateAction.jsp로 전송 --%>
				<table class="table table-striped" style="text-align: center; border: ipx solid #dddddd">
					<thead>
						<tr>	<%-- colspan: 2개 열 크기 --%>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>																								      <%-- 수정하기 전 내용을 보여줌 --%>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>																											 	 <%-- 수정하기 전 내용을 보여줌 --%>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
						</tr>	<%-- textarea: 장문의 글 --%>
					</tbody> 
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정">	<%-- 글 수정 버튼 --%>
			</form>			
		</div>
	</div>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> <%--애니메이션 퀴리--%>					
     <script src="js/bootstrap.min.js"></script> <%--기본 제공 자바스크랩트 파일 --%>
     
</body>
</html>