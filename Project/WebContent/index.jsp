<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="post.postDAO" %>
<%@ page import="post.postDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	request.setCharacterEncoding("UTF-8");
	String mainRole = "전체";
	String searchType = "최신순";
	String search = "";
	if(request.getParameter("mainRole") != null) {
		mainRole = request.getParameter("mainRole");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	
	String userID = null;
	if(session.getAttribute("userID") != null) {            //로그인이 된 상태라면
		userID = (String) session.getAttribute("userID");
	}
	/* if(userID == null) {                          // 로그인을 안했다면 index.jsp에 바로 접근할 수없고, 로그인 페이지로 보냄
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
	} */
	
	int pageNumber = 1;           // 처음에 page번호는 1로 초기화시켜줌.
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	/* boolean emailChecked = new UserDAO().getUserEmailChecked(userID);          // 사용자가 이메일 인증이 되었는지 확인하려고 만듬.
	if(emailChecked == false) {                // 이메일 인증이 안된 사용자면 글 게시를 할수 없으므로
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp'");     // emailSendConfrim은 사용자에게 이메일 인증을 받으시겠습니까라고 물어봐주는 jsp파일임.
		script.println("</script>");
		script.close();
		return;
	} */
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
    
    </header>
  
  	
    <div class="container-fluid mt-5 pt-3" style="background: url(img/mainbackground.png) no-repeat center center;
                      background-size: cover; height: 1000px; ">        <!-- container-fluid로 하면 전체를 쓰지만(그리드 레이아웃을 최대폭 레이아웃으로),
                                        container로 하면 width를 줄여서 사용가능. (고정폭 그리드 레이아웃)  -->
        <div class="container mt-3 pt-3">
    	<form method="get" action="./index.jsp" class="form-inline mt-3">
    		<select name="mainRole" class = "form-control mx-1 mt-2">
    			<option value="전체">전체</option>
    			<option value="딜러" <% if(mainRole.equals("딜러")) out.println("selected"); %>>딜러</option>
    			<option value="탱커" <% if(mainRole.equals("탱커")) out.println("selected"); %>>탱커</option>
    			<option value="힐러" <% if(mainRole.equals("힐러")) out.println("selected"); %>>힐러</option>	
    		</select> 
    		<select name="searchType" class = "form-control mx-1 mt-2">
    			<option value="최신순">최신순</option>
    			<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
    		</select> 
    		<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
    		<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
    		<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">새 주제</a>
        	<a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
    	</form>
    	<%-- <%
    		ArrayList<postDTO> postList = new ArrayList<postDTO>();
    		postList = new postDAO().getSearchList(mainRole, searchType, search, pageNumber);
    		if(postList != null) {
    			for(int i = 0; i < postList.size(); i++) {
    				if (i == 10) break;
    				postDTO post = postList.get(i);
    	%> --%>
    	
    	<div class="row">
    		<table class="table table-striped mt-4" style="text-align: center; border: 1px solid #dddddd; color: #00FFCC">
    			<thead>
    				<tr>
    					<th style="text-align: center;">번호</th> 
    					<th style="text-align: center;">제목</th>
    					<th style="text-align: center;">닉네임</th>
    					<th style="text-align: center;">주역활</th>
    					<th style="text-align: center;">작성일</th>
    					<th style="text-align: center;">조회수</th>
    					<th style="text-align: center;">추천수</th>
    				</tr>
    			</thead>
    			<tbody>
    				<%
    					postDAO postdao = new postDAO();
    					ArrayList<postDTO> list = postdao.getList(mainRole, searchType, search, pageNumber);
    					if(list != null) {
    						for(int j = 0; j < list.size(); j++) {
    						
    				%>
    				<tr>
    					<td><%= list.get(j).getPostID() %></td>
    					<td><a href="postView.jsp?postID=<%= list.get(j).getPostID() %>"><%= list.get(j).getPostTitle() %></a></td>
    					<td><%= list.get(j).getNickName() %></td>
    					<td><%= list.get(j).getMainRole() %></td>
    					<td><%= list.get(j).getPostDate().substring(0,11) + list.get(j).getPostDate().substring(11,13) 
    					        + "시" + list.get(j).getPostDate().substring(14,16) + "분"%></td>
    					<td><%= list.get(j).getCount() %></td> 
    					<td><%= list.get(j).getRecommendCount() %></td>   
    				</tr>
    				<%
    					}
		    		}
    				%>
    			</tbody>
    		</table>
    		 <%
    			if(pageNumber != 1) {                  // 2페이지이상들은 이전페이지로 돌아가야됨.
    		%>
    			<%-- <a href="./index.jsp?mainRole=<%= mainRole %>&searchType=<%= searchType %>
    			&search=<%= search %>&pageNumber=<%= pageNumber - 1 %>" class = "btn btn-success btn-arrow-left">이전</a>  --%>
    			
    			<a href="./index.jsp?pageNumber=<%= pageNumber - 1 %>&mainRole=<%= mainRole %>&searchType=<%= searchType %>&search=<%= search %>" class = "btn btn-success btn-arrow-left">이전</a>
    		<%	
    			} if(postdao.nextPage(pageNumber + 1)) {         // 다음 페이지가 존재하면
    		%>	
    			<a href="./index.jsp?pageNumber=<%= pageNumber + 1 %>&mainRole=<%= mainRole %>&searchType=<%= searchType %>&search=<%= search %>" class = "btn btn-success btn-arrow-left">다음</a> 
    		<%
    			}
    		%> 
    	</div>
    </div>
    	
    </div>
    
  <%--   <ul class="pagination justify-content-center mt-3">
    	<li class="page-item">
    	<%
    		if(pageNumber <= 0) {
    	%>
    		<a class = "page-link disabled">이전</a>
    	<%
    		} else {
    	%>
    		<a class = "page-link href="./index.jsp?mainRole= <%= URLEncoder.encode(mainRole, "UTF-8") %>&searchType= 
    		  <%= URLEncoder.encode(searchType, "UTF-8") %>&search= <%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=
    		  <%= pageNumber - 1 %>">이전</a>
    	<%
    		}
    	%>
    	</li>
    	<li>
    	<%
    		if(postList.size() < 11) {
    	%>
    		<a class = "page-link disabled">다음</a>
    	<%
    	/* 	} else { */
    	%>
    		<a class = "page-link href="./index.jsp?mainRole= <%= URLEncoder.encode(mainRole, "UTF-8") %>&searchType= 
    		  <%= URLEncoder.encode(searchType, "UTF-8") %>&search= <%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=
    		  <%= pageNumber + 1 %>">다음</a>
    	<%
    	/* 	} */
    	%> 
    	
    	</li>
    </ul> --%>

    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">

      <div class="modal-dialog">

        <div class="modal-content text-success">

          <div class="modal-header">

            <h5 class="modal-title" id="modal"> 새 주제 만들기 </h5>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body">

            <form action="./postAction.jsp" method="post">

              <div class="form-row">

                <div class="form-group col-sm-8">

                  <label>닉네임</label>

                  <input type="text" name="nickName" class="form-control" maxlength="20" placeholder="닉네임">

                </div>
				
				 <div class="form-group col-sm-4">

                  <label>주 역활</label>

                  <select name="mainRole" class="form-control">

                    <option selected>딜러</option>

                    <option>탱커</option>

                    <option>힐러</option>

                  </select>

                </div>
				
              </div>
              
              <div class="form-row">
              
              <div class="form-group col-sm-12">

                  <label>제목</label>

                  <input type="text" name="Title" class="form-control" maxlength="20" placeholder="글 제목">

                </div>
              
				</div>
               

              <div class="form-group">

                <label>내용</label>

                <textarea name="Content" class="form-control" placeholder="글 내용" maxlength="2048" style="height: 180px;"></textarea>

              </div>


              <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>

                <button type="submit" class="btn btn-success">새 주제 쓰기</button>

              </div>

            </form>

          </div>

        </div>

      </div>

    </div>

    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">

      <div class="modal-dialog">

        <div class="modal-content text-success">

          <div class="modal-header">

            <h5 class="modal-title" id="modal">신고하기</h5>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body">

            <form method="post" action="./reportAction.jsp">

              <div class="form-group">

                <label>신고 제목</label>

                <input type="text" name="reportTitle" class="form-control" maxlength="20">

              </div>

              <div class="form-group">

                <label>신고 내용</label>

                <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>

              </div>

              <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>

                <button type="submit" class="btn btn-danger">신고하기</button>

              </div>

            </form>

          </div>

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