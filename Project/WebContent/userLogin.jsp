<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page errorPage="./loginErrorHandler.jsp" %>  <!-- page 지시문의 errorPage를 "errorHandler.jsp로 설정  -->
<!doctype html>

<html>

  <head>

    <title>Overwatch Forums</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- 커스텀 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/custom.css">
    
    <style>
    	#brand-image
		{
			height:50px;
		}
	 	.navbar
		{
			background-image: url(img/blizarrdbg.jpg);
			background-repeat: no-repeat;
			-webkit-background-size: cover;
    		-moz-background-size: cover;
    		-o-background-size: cover;
			background-size: cover;
	    	background-position:center center;  	
		}  
		body
		{
			background-image: url(img/blizarrdbg.jpg);
			background-repeat: no-repeat;
			-webkit-background-size: cover;                 /* webkit부터 3줄은 웹페이지를 줄엿을때도 이미지를 설정한값으로 유지하게하려고 넣어줌. */
    		-moz-background-size: cover;
    		-o-background-size: cover; 
    		background-size: cover;
		}
    </style>

  </head>

  <body>
 <%
	String userID = null;
	if(session.getAttribute("userID") != null) {            
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {                //로그인이 된 상태라면 로그인 페이지에 접속할수 없게 만듬.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
	}
%>
   <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">        <!-- bg는 background의 약자임. -->
	<div class="container">

      <a class="navbar-brand" href="index.jsp">       <!-- 로고 -->
      	오버워치 토론장
      	<img id="brand-image" src="img/blizarrd3.jpg" alt="Website Logo" > 
      </a>
      

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">                  <!-- 리스트를 구현 -->

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">메인</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              회원 관리

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">
            <%
            	if(userID == null) {                         // 로그인이 안된 상태라면
            %>

              <a class="dropdown-item" href="userLogin.jsp">로그인</a>

              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>
              
            <%
            	} else {
            %>

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            <%
            	}
            %>

            </div>

          </li>

        </ul>

         <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요.">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>

        </form>

      </div>
		</div>
    </nav>

    <div class="container-fluid mt-5 pt-5" style="max-width: 560px; 
    background: url(img/blizarrdbg.png) no-repeat center center;  background-size: cover; height: 1000px;">                <!-- (mt-5 == margin top을 5만큼) 최대 560px -->
																	<!-- (pt-5 == padding top을 5만큼)  -->
      <form method="post" action="./userLoginAction.jsp">
      
      	<h3 style="text-align: center;">로그인 화면</h3>        

        <div class="form-group">

          <label><b>아이디</b></label>

          <input type="text" name="userID" class="form-control" placeholder="아이디" maxlength="20" >

        </div>

        <div class="form-group">

          <label><b>비밀번호</b></label>

          <input type="password" name="userPassword" class="form-control" placeholder="비밀번호" maxlength="20" >

        </div>

        <button type="submit" class="btn btn-primary">로그인</button>
      </form>

    </div>

    <!-- 제이쿼리 자바스크립트 추가하기 -->

    <script src="./js/jquery-3.4.1.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->

    <script src="./js/popper.min.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>
