<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");        //사용자로부터 받은 요청정보는 UTF-8로 인코딩!!
	String userID = null;
	String userPassword = null;
	
	if(request.getParameter("userID") != null) {
		userID = (String)request.getParameter("userID");     // 사용자로부터 userID를 넣음.  
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String)request.getParameter("userPassword");   // 사용자로부터 userPassword를 받음.
	}
	if(userID == null || userPassword == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 항목이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	
	int result = userDAO.login(userID, userPassword);
	
	if(result == 1)           // 로그인이 정상적으로 되었을때
	{
		session.setAttribute("userID", userID);           // 세션값을 설정해줌.	
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else if(result == 0)             // 비밀번호가 틀렸을경우
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if(result == -1)                // 아이디가 없는경우
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if(result == -2)                 // 데이터베이스 오류발생
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>