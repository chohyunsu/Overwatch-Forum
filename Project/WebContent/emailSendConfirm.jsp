<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
	if(session.getAttribute("userID") != null) {            //로그인이 된 상태라면
		userID = (String) session.getAttribute("userID");
	}
	 if(userID == null) {          // 로그인이 안된 상태라면 로그인페이지로 보내줌.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
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

    <div class="container mt-3" style="max-width: 560px;">

      <div class="alert alert-warning mt-4" role="alert">            <!-- 사용자에게 이메일 인증을 받으라고 알려줌. -->
      		이메일 인증을 하셔야 이용 가능합니다.
      </div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>        <!-- 사용자에게 인증메일을 보내주는 액션으로 링크! -->
    </div>

    <!-- 제이쿼리 자바스크립트 추가하기 -->

    <script src="./js/jquery-3.4.1.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->

    <script src="./js/popper.min.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>
