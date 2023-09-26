<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <%--반응형 웹,pc&모바일--%>
<link rel="stylesheet" href="css/bootstrap.min.css"> <%--부트스트랩 css 참조--%>
<title>JSP 게시판 사이트</title> 
</head>


<body>
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
       				aria-expanded="false">			<%-- 위 타겟과 같은 이름--%>
           <ul class="nav navbar-nav"> <%-- ul은 리스트를 보여줄 때 사용 --%>
                   <li><a href="main.jsp">메인</a></li> <%-- li 원소, 게시판 이름 옆 --%>
                   <li><a href="bbs.jsp">게시판</a></li>
           </ul>
           
           
           <ul class="nav navbar-nav navbar-right"> <%-- 게시판 오른쪽 --%>
              <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                     data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">접속하기<span class="caret"></span></a>
                     <%-- #:가르키는 링크가 없음, caret: 아이콘 --%>
                     
                     
           	<ul class="dropdown-menu"> <%-- 네비게이션 바 구축 --%>
                <li class="active"><a href="login.jsp">로그인</a></li><%-- active:현재 선택됨 --%>
                <li><a href="join.jsp">회원가입</a></li> <%-- 회원가입 페이지 연결 --%>
           </ul>
         </li>
       </ul>
       </div>
	</nav>
	
	<%-- 로그인 양식 --%>
    <div class="container">
    	<div class="col-Lg-4"></div>
        <div class="col-Lg-4">    <%-- 로그인 양식 --%>      
        	<div class="jumbotron" style="padding-top: 20px;">
               	<form method="post" action="loginAction.jsp"> <%--post:정보를 숨겨 전송, login action 페이지로 정보를 전송 --%>
                	<h3 style="text-align: center;">로그인 화면</h3>
                	<div class="form-group">
                		<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
                												<%-- 아무것도 없을 경우 보여주는 글자, user대문자 --%>
                  	</div>
                 	<div class="form-group">
                		<input type="password" class="form-control" placeholder="비밀번호" name="userPassID" maxlength="20">
                  	</div>
                   	<input type="submit" class="btn btn-primary form-control" value="로그인"> <%-- 로그인 버튼 --%>
                  </form>
              </div>
         </div>
         <div class="col-Lg-4"></div>        
     </div>      
     <script src="https://code.jquery.com-3.1.1.min.js"></script> <%--애니메이션 퀴리--%>
     <script src="js/bootstrap.min.js"></script> <%--기본 제공 자바스크랩트 파일 --%>
</body>
</html>