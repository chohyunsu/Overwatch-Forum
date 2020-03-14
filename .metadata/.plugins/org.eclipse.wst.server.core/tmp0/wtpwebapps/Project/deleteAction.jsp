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
			script.println("alert('삭제할 권한이 없습니다.');");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			script.close();
		} else {                                    // 로그인이 되어있다면                                     
				postDAO dao = new postDAO();
				int result = dao.delete(postID);
						              
				if(result == -1) {                          // 글삭제 실패
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				} else {                                   // 글삭제 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'index.jsp'");
					script.println("</script>");
				}
			}
	%>
</body>
</html>