<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.postDAO" %>
<%@ page import="post.postDTO" %>
<%@ page errorPage="./updateErrorHandler.jsp" %>  <!-- page 지시문의 errorPage를 "errorHandler.jsp로 설정  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- viewport는 웹페이지의 크기를 결정 , device-width는 모니터가 스마트폰의 실제 액정크기를 따라가게함. 
  init-scale은 보여지는 화면의 zoom up정도를 1배율로! 이 값을 키우면 보여지는화면이 줌되어 크게보임. 
  shrink-to 는 사파리브라우저만 영향을 미치는데 viewport의 크기보다 보여줘야할 내용이 크면 , 보여줘야할 내용을 줄여서라도 보여주는데 그것을 방지하기위해 씀 -->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 부트스트랩3.0부터는 모바일 친화적이므로 이 코드를 써줌. -->
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">
<title>Overwatch Forums</title>

<style>
	#brand-image
	{
		height:50px;
	}
	
	body
	{
		background-color: black;
	} 
	.modal-content
	{
		background-image: url(img/mainbackgroundmodal.png);
		background-repeat: no-repeat;
		-webkit-background-size: cover;                 /* webkit부터 3줄은 웹페이지를 줄엿을때도 이미지를 설정한값으로 유지하게하려고 넣어줌. */
    	-moz-background-size: cover;
    	-o-background-size: cover;
    	background-size: cover;
	}
	 .navbar
	{
		background-image: url(img/mainbackground.png);
		background-repeat: no-repeat;
		-webkit-background-size: cover;
    	-moz-background-size: cover;
    	-o-background-size: cover;
		/* background-size: cover; */
	  /*   background-position:center center;  	 */
	}  
	 
	a, a:hover {
		color: white;
		text-decoration: none;
	}
	
	table, thead
	{
		background-image: url(img/overwatch_bg.jpg);
		background-repeat: no-repeat;
		background-size: cover;
	}
	
	tbody
	{
		color: white;
	}
	

</style>

</head>
<body style="width:100%; height:100%;">
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {            //로그인이 된 상태라면
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
	}
	int postID = 0;
	if(request.getParameter("postID") != null) {
		postID = Integer.parseInt(request.getParameter("postID"));
	}
	if(postID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	}
	postDTO dto = new postDAO().getPostDto(postID);             // 현재 작성한 글이 작성한 사람 본인인지 확인하는 코드
	if(!userID.equals(dto.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정할 권한이 없습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	}
%>
	<header>
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

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>

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
    
    </header>
  
  	
    <div class="container-fluid mt-5 pt-3" style="background: url(img/mainbackground.png) no-repeat center center;
                      background-size: cover; height: 1000px; ">        <!-- container-fluid로 하면 전체를 쓰지만(그리드 레이아웃을 최대폭 레이아웃으로),
                                                                             container로 하면 width를 줄여서 사용가능. (고정폭 그리드 레이아웃)  -->
        <div class="container mt-5">
    	
    	<div class="row">
    	<form method="post" action="updateAction.jsp?postID=<%= postID %>">
    		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; color: #00FFCC;">
    			<thead>
    				<tr>
    					<th colspan="3" style= "text-align: center;">게시판 글 수정</th>
    				</tr>
    			</thead>
    			<tbody>
    				<tr>
    					<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="20"
    					          value="<%= dto.getPostTitle() %>"></td>
    				</tr>
    				<tr>
    					<td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" 
    					      style="height: 330px; width:1000px;"><%= dto.getPostContent() %></textarea></td>
    				</tr>
    			</tbody>
    		</table>
    		<input type="submit" class="btn btn-primary float-right" value="글 수정">
    	</form>

    	</div>
   			 </div>
  				  </div>


    
    <!-- 제이쿼리 자바스크립트 추가하기 -->

    <script src="./js/jquery-3.4.1.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->

    <script src="./js/popper.min.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->

    <script src="./js/bootstrap.min.js"></script>

</body>
</html>