<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="utility.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");        //사용자로부터 받은 요청정보는 UTF-8로 인코딩!!
	String code = null;
	if(request.getParameter("code") != null) {
		code = request.getParameter("code");      
	}
	
	UserDAO userDAO = new UserDAO();
	
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");       // session은 object객체를 반환하기때문에 강제형변환해줌.
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();        // 사용자에게 메시지를 출력해주기위해서 PrintWriter를 사용함.
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href= 'userLogin.jsp'"); // 이전페이지로 사용자를 돌려보냄. 즉, 회원가입 페이지로 돌려보내는것.
		script.println("</script>");
		script.close();
		return;
	}
	
	String userEmail = userDAO.getUserEmail(userID);
	
	 //현재 사용자가 보낸 코드가 정확히 해당 사용자의 이메일 주소의 해쉬값을 적용한 그 데이터와 일치하는지 확인
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;  
	
	 if(isRight == true) {
		 userDAO.setUserEmailChecked(userID);
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('인증에 성공하였습니다.');");
		 script.println("location.href = 'index.jsp'"); // 이전페이지로 사용자를 돌려보냄. 즉, 로그인 페이지로 돌려보내는것.
		 script.println("</script>");
		 script.close();
		 return;
	} else {
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('유효하지 않은 코드입니다.');");
		 script.println("location.href = 'index.jsp'"); 
		 script.println("</script>");
		 script.close();
		 return;
	}
%>