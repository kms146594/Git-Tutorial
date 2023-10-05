<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>					
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>		<%-- 게시판 목록 출력 --%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <%--반응형 웹,pc&모바일--%>
<link rel="stylesheet" href="css/bootstrap.min.css"> <%--부트스트랩 css 참조--%>
<title>JSP 게시판 웹 사이트</title> 
<style type="text/css">	 <%-- 링크 스타일 변경--%>
	a, a/hover {
		color: #000000;  <%-- 링크 태그 검정--%>
		text-decoration: none;	<%-- 링크 밑줄 삭제--%>
	}
</style>
</head>

<body>
	<%
		String userID = null;		// 로그인 안 한 경우 userID = null
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");		// 로그인 한 경우 userID
		}
		int pageNumber = 1;			// 기본 페이지 번호
		if (request.getParameter("pageNumber") != null){	// 파라미터로 값이 넘어온 경우 pageNumer 변경
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));	// parseInt:정수형으로 변경
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
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();		// 인스턴스 생성
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);	// 현재 페이지에서 가져온 목록
						for(int i = 0; i < list.size(); i++) {		// 가져온 목록 출력
					%>
					<tr>
						<td><%= list.get(i).getBbsID()  %></td>		
						<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID()  %>"><%= list.get(i).getBbsTitle() %></a></td>
						<%-- 제목 클릭 시, 해당 게시글의 번호에 맞게 view 페이지에서 출력할 수 있도록 --%>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
						<%-- 팔요한 정보(날짜)만 출력 --%>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {		// pageNumebr가 1이 아닌 경우
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
				<%-- 이전 페이지 화면으로 이동, 화살표 모양 버튼 --%>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) {	// 다음 페이지가 존재하는 경우
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
				<%-- 다음 페이지 화면으로 이동, 버튼 --%>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> <%--애니메이션 퀴리--%>					
     <script src="js/bootstrap.min.js"></script> <%--기본 제공 자바스크랩트 파일 --%>
     
</body>
</html>