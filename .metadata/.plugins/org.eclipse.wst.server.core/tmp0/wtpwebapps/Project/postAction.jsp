<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.postDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="posted" class="post.postDTO" scope="page"/>
<jsp:setProperty name="posted" property="postTitle" param="Title" />
<jsp:setProperty name="posted" property="postContent" param="Content" /> 
<jsp:setProperty name="posted" property="nickName" param="nickName" /> 
<jsp:setProperty name="posted" property="mainRole" param="mainRole" /> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Overwatch Forums</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {                           // 로그인이 안되어있다면 로그인페이지로 이동 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'userLogin.jsp'");
			script.println("</script>");
		} else {                                    // 로그인이 되어있다면
			if(posted.getPostTitle() == null || posted.getPostContent() == null || 
			   posted.getNickName() == null) {        //입력이 안된 항목이 있는경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 항목이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");
			} else {                                         // 입력이 다된경우
				postDAO postDao = new postDAO();
				int result = postDao.post(posted.getPostTitle(), userID, posted.getPostContent()
						                  , posted.getNickName(), posted.getMainRole());
				
				if(result == -1) {                          // 글쓰기 실패
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('새 주제 쓰기에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				} else {                                   // 글쓰기 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'index.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>