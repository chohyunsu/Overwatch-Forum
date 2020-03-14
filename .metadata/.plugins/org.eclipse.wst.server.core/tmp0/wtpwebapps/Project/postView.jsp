<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.postDTO" %>
<%@ page import="post.postDAO" %>
<%@ page errorPage="./postViewErrorHandler.jsp" %>  <!-- page 지시문의 errorPage를 "errorHandler.jsp로 설정  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {           // 로그인이 된 상태라면 
			userID = (String) session.getAttribute("userID");
		}
		int postID = 0;
		if(request.getParameter("postID") != null) {                   //글번호가 정상적으로 넘어왔다면
			postID = Integer.parseInt(request.getParameter("postID"));
		}
		if(postID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href= 'index.jsp'");
			script.println("</script>");
			script.close();
		}
		
		postDTO postdto = new postDAO().getPostDto(postID);           // 유효한 글이라면 postdto에 담아둠.
		
		if(userID == session.getAttribute("userID")){
			new postDAO().count(postID);
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
    
     <div class="container-fluid mt-5 pt-3" style="background: url(img/mainbackground.png) no-repeat center center;
                      background-size: cover; height: 1000px; ">
    
    <div class="container mt-5 pt-5">
    	<div class="row">
    		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; color: #00FFCC;">
    			<thead>
    				<tr>
    					<th colspan="3" style= "text-align: center;">게시판 글 보기 </th>
    				</tr>
    			</thead>
    			<tbody>
    				<tr>
    					<td style="width:20%;">글제목</td>
    					<td colspan="2"><%= postdto.getPostTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
     					       .replaceAll("\n","<br>")  %></td>
    				</tr>
    				<tr>
    					<td>작성자</td>
    					<td colspan="2"><%= postdto.getUserID() %></td>
    				</tr>
    				<tr>
    					<td>닉네임</td>
    					<td colspan="2"><%= postdto.getNickName() %></td>
    				</tr>
    				<tr>
    					<td>작성일자</td>
    					<td colspan="2"><%= postdto.getPostDate().substring(0,11) + postdto.getPostDate().substring(11,13) 
    					        + "시" + postdto.getPostDate().substring(14,16) + "분 "%></td>
    				</tr>
    				<tr>
    					<td>내용</td>
    					<td colspan="2" style="min-height: 200px; text-align: left;">
    					       <%= postdto.getPostContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
    					       .replaceAll("\n","<br>") %></td>
    				</tr>
    			</tbody>
    		</table>
    		<a href="index.jsp" class="btn btn-primary">목록</a>
    		<%
    			if(userID != null && userID.equals(postdto.getUserID())) {
    		%>
    				&nbsp; <a href="update.jsp?postID=<%= postID %>" class="btn btn-primary">수정</a>
    				&nbsp; <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?postID=<%= postID %>" class="btn btn-primary">삭제</a>
    		<%
    			}
    		
    		 %>
    		 &nbsp; <a onclick="return confirm('추천하시겠습니까?')" href="recommendAction.jsp?postID=<%= postID %>" class="btn btn-primary">추천</a>
    		
    	</div>
    </div>
   </div>
</body>
</html>