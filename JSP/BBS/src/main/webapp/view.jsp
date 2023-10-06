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
		int bbsID = 0;				
		if (request.getParameter("bbsID") != null){		// bbsID 매개변수가 존재할 경우
			bbsID = Integer.parseInt(request.getParameter("bbsID"));	
		}
		if (bbsID == 0) {		// 번호가 존재해야 특정한 글을 볼 수 있음
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); 		// bbsID가 유효한 경우 구체적인 정보를 bbs라는 인스턴스 안에 저장
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
              <%
              		if(userID == null) {		// 로그인이 되어 있지 않은 경우
              			
              %>   
              <ul class="nav navbar-nav navbar-right">		 <%-- 게시판 오른쪽 --%>
				  <li class="dropdown">
           			  <a href="#" class="dropdown-toggle"
                    	  data-toggle="dropdown" role="button" aria-haspopup="true"
                    	  aria-expanded="false">접속하기<span class="caret"></span></a>
                    		<%-- #:가리키는 링크가 없음, caret: 아이콘 --%>                                 
           			  <ul class="dropdown-menu"> 		<%-- 네비게이션 바 구축 --%>
                		  <li><a href="login.jsp">로그인</a></li>		
                		  <li><a href="join.jsp">회원가입</a></li>		 <%-- 회원가입 페이지 연결 --%>
           			  </ul>
         		  </li>
       		  </ul>
              <%
              		} else {
              %>
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
              <%
              		}
              %>
       	 </div>
	</nav>     
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: ipx solid #dddddd">
				<thead>
					<tr>	<%-- colspan: 3개 열 크기까지 가능 --%>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>						</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>	
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "&<br>;") %></td>
						<%-- Cross-Site Scripting 공격 방지 --%>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>	
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시" + bbs.getBbsDate() %></td>
					</tr>						
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "&<br>;") %></td>
						<%-- 내용 크기 200px, 특수문자로 인해 게시글 내용이 보이지 않는 경우 방지 --%>
					</tr>		
				</tbody> 
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){		// 글의 작성자가 본인인 경우
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<% 		// onclick: 팝업 내용을 띄움
				}
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">	<%-- 글쓰기 버튼 --%>		
		</div>
	</div>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> <%--애니메이션 퀴리--%>					
     <script src="js/bootstrap.min.js"></script> <%--기본 제공 자바스크랩트 파일 --%>
     
</body>
</html>