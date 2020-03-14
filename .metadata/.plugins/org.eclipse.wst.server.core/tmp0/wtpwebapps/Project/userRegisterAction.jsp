<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="utility.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");        //사용자로부터 받은 요청정보는 UTF-8로 인코딩!!
	String userID = null;
	if(session.getAttribute("userID") != null) {           
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {                 //로그인이 된 상태라면 회원가입을 할 수없음.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	String userPassword = null;
	String userEmail = null;
	String userName = null;
	String userGender = null;
	
	if(request.getParameter("userID") != null) {
		userID = (String)request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String)request.getParameter("userPassword");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = (String)request.getParameter("userEmail");
	}
	if(request.getParameter("userName") != null) {
		userName = (String)request.getParameter("userName");
	}
	if(request.getParameter("userGender") != null) {
		userGender = (String)request.getParameter("userGender");
	}
	
	if(userID == null || userPassword == null || userEmail == null || userName == null || userGender == null) {
		PrintWriter script = response.getWriter();        // 사용자에게 메시지를 출력해주기위해서 PrintWriter를 사용함.
		script.println("<script>");
		script.println("alert('입력이 안된 항목이 있습니다.');");
		script.println("history.back();"); // 이전페이지로 사용자를 돌려보냄. 즉, 회원가입 페이지로 돌려보내는것.
		script.println("</script>");
		script.close();
	} else {                       // 회원가입하는 루틴
		
		UserDAO userDAO = new UserDAO();           //userDAO 객체 선언
		int result = userDAO.join(new UserDTO(userID, userPassword, userName, userGender, userEmail, SHA256.getSHA256(userEmail), false)); // 한명의사용자객체를 넣어줌.
		if (result == -1) {               //  데이터베이스 오류 발생 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back();"); // 이전페이지로 사용자를 돌려보냄. 즉, 로그인 페이지로 돌려보내는것.
			script.println("</script>");
			script.close();
		} else {                  // 회원가입 성공이후에 바로 로그인을 시켜주는 루틴
			session.setAttribute("userID", userID);  // 서버에서 세션값으로 관리할수있게 해줌.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'emailSendAction.jsp';");
			script.println("</script>");
			script.close();
		}
	}
%>