<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
                   <li class="active"><a href="main.jsp">메인</a></li> <%-- li 원소, active:현재 선택됨 --%>
                   <li><a href="bbs.jsp">게시판</a></li>
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
              		} else {					// 로그인이 되어 있는 경우
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
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> <%--애니메이션 퀴리--%>					
     <script src="js/bootstrap.min.js"></script> <%--기본 제공 자바스크랩트 파일 --%>
     
</body>
</html>