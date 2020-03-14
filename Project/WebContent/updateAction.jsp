<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.postDAO" %>
<%@ page import="post.postDTO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
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
		} else {                                    // 로그인이 되어있다면
			if(request.getParameter("title") == null || request.getParameter("content") == null
			    || request.getParameter("title").equals("") || request.getParameter("content").equals("")) {        //입력이 안된 항목이 있는경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 항목이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");
			} else {                                         // 정상적으로 입력이 다된경우
				postDAO dao = new postDAO();
				int result = dao.update(postID, request.getParameter("title"), request.getParameter("content"));
						              
				if(result == -1) {                          // 글수정 실패
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				} else {                                   // 글수정 성공
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