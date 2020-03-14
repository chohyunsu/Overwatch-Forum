
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="javax.mail.*" %>
<%@page import="utility.SHA256" %>
<%@page import="utility.Gmail" %>
<%@page import="java.util.Properties" %>   <!-- 속성을 정의할때 쓰는 라이브러리  -->
    
<% 
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");    // 회원가입 userRegisterAction에서 session값으로 해당 ID로 설정해줌
	}                                                       // 로그인을 햇을때는 session값으로 ID가 설정되어잇음.
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
	}
	
	request.setCharacterEncoding("UTF-8");       //사용자에게 요청을 받을때 한글이 포함될 수 있게 UTF-8로 설정
	String reportTitle = null;
	String reportContent = null;
	if(request.getParameter("reportTitle") != null) {           // 사용자로부터 신고제목부분을 성공적으로 입력받았을때
		reportTitle = (String)request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent") != null) {           // 사용자로부터 신고내용부분을 성공적으로 입력받았을때
		reportContent = (String)request.getParameter("reportContent");
	}
	if(reportTitle == null || reportContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 항목이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	//  이메일 인증이 안된 사용자라면 사용자에게 이메일 인증 메시지를 보내줄것임. (구글 SMTP가 기본적으로 제공하는 양식을 사용)
	String host = "http://localhost:8088/Project/";      // 웹사이트 주소를 넣어줌.
	String from = "chohyunsu1996@gmail.com";           // 보내는 사람 (나의 구글 이메일 계정)
	String to = "guswo1996@naver.com";      // 받는 사람 (신고내용을 받을 관리자의 아이디(나))
	String subject = "오버워치 토론장에서 접수된 신고메일입니다.";       // 보낼 이메일의 제목
    String content = "신고자: " + userID + "<br>제목: " + reportTitle + "<br>내용: " + reportContent;
    
	// SMTP에 접속하기위한 정보를 넣어줌.
	Properties p = new Properties();
	p.put("mail.smtp.user", from);              // user를 나의 구글 아이디로 넣어줌.
	p.put("mail.smtp.host", "smtp.googlemail.com");      // 구글에서 제공하는 smtp server (구글 smtp주소)
	p.put("mail.smtp.port", "465");           // port는 465번을 사용. (구글에서 제공해주는 것임.(정해져 있는것.)) 
	p.put("mail.smtp.starttls.enable", "true");        //starttls를 사용가능하게 true로 줌.  (starttls는 웹 브라우저에서 실행되는 전자메일 클라이언트를 포함한 전자메일 클라이언트를
			                                           //포함한 전자메일 클라이언트가 기존의 안전하지 않은 연결을 안전한 연결로 전환하려고한다는 것을 전자메일 서버에 알려주는
			                                           // 전자메일 프로토콜 명령이다.) 
	p.put("mail.smtp.auth", "true");          //smtp 권한을 true로 줌.
	p.put("mail.smtp.debug", "true");          //debug를 true로 줌으로써 SMTP 서버를 통해서 이메일을 보내거나 연결하는데에 있어서 문제가생기면 문제에대해서 많은 정보를 제공해준다.
	p.put("mail.smtp.socketFactory.port", "465");      //지정된 소켓팩토리를 사용할때 연결할 포트설정 
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");         // SMTP 소켓을 만듬.
	p.put("mail.smtp.socketFactory.fallback", "false");     // 이것이 true면 내가 지정한 소켓팩토리 클래스를 사용하여 소켓을 작성하지 못하면 특정한 클래스를 사용하여 소켓이 작성됨.
	
	// 이메일을 전송하는 부분
	try {                              // 구글 Gmail의 인증을 수행해서 사용자에게 관리자의 이메일주소로 이메일 인증주소를 전송하는 부분.
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);      // 첫번째 인자값으로 받는사람의 이메일주소를 따옴.
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
		
	} catch(Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('정상적으로 신고내용이 접수되었습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
%>
