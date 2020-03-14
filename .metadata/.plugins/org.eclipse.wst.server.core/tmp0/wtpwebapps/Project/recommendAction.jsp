<%@page import="post.postDTO"%>
<%@page import="recommend.recommendDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.postDAO" %>
<%@ page import="recommend.recommendDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%!                              // 전역으로 돌릴것이므로 <%!를 씀.
	public static String getClientIP(HttpServletRequest request) {        //현재 접속한 사용자의 ip주소를 가저옴.
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
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
	
	request.setCharacterEncoding("UTF-8");
	String postID = null;
	if(request.getParameter("postID") != null) {
		postID = request.getParameter("postID");
	}
	
	postDAO postdao = new postDAO();
	recommendDAO recommenddao = new recommendDAO();
	
	int result = recommenddao.recommend(userID, postID,  getClientIP(request));   // 해당 아이디의 ip값을 저장해둠. 
	if(result == 1){            // 해당 사용자 아이디로 처음 추천을 눌렀을때만 
		result = postdao.recommend(postID);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.')");
			script.println("location.href= 'index.jsp'");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천을 누른 글입니다.')");
		script.println("history.back();");
		script.println("</script>");
	}
	%>