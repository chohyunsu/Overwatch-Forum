
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
	UserDAO userDAO = new UserDAO();
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
		return;
	} 
	
	boolean emailChecked = userDAO.getUserEmailChecked(userID);  // 특정한 사용자가 이메일 인증이 되었는지 확인
	
	if(emailChecked == true) {               // 이메일 인증을 완료환 사용자일때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이메일 인증이 완료된 회원입니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;                // 종료
	}
	
	//  이메일 인증이 안된 사용자라면 사용자에게 이메일 인증 메시지를 보내줄것임. (구글 SMTP가 기본적으로 제공하는 양식을 사용)
	//String host = "http://localhost:8088/Project/";      // 웹사이트 주소를 넣어줌.
	String host = "http://172.18.7.181:8088/Project/";      // 웹사이트 주소를 넣어줌.
	String from = "chohyunsu1996@gmail.com";           // 보내는 사람 (나의 구글 이메일 계정)
	String to = userDAO.getUserEmail(userID);      // 받는 사람
	String subject = "Email verification email for the Overwatch forum";       // 보낼 이메일의 제목
    String content = "다음 링크에 접속하여 이메일 인증을 진행해주세요." +     // 보낼 이메일의 내용 + 링크를 통해 해쉬값을 적용해서 emailCheckAction으로 code값에 실어서 보냄
    "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";      
			
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
		return;
	}
%> 
<!doctype html>

<html>

  <head>

    <title>Overwatch Forums</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- 커스텀 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/custom.css">
    
    <style>
    	#brand-image
		{
			height:50px;
		}
	 	.navbar
		{
			background-image: url(img/blizarrdbg.jpg);
			background-repeat: no-repeat;
			-webkit-background-size: cover;
    		-moz-background-size: cover;
    		-o-background-size: cover;
			background-size: cover;
	    	background-position:center center;  	
		}  
		body
		{
			background-image: url(img/blizarrdbg.jpg);
			background-repeat: no-repeat;
			-webkit-background-size: cover;                 /* webkit부터 3줄은 웹페이지를 줄엿을때도 이미지를 설정한값으로 유지하게하려고 넣어줌. */
    		-moz-background-size: cover;
    		-o-background-size: cover; 
    		background-size: cover;
		}
    </style>

  </head>

  <body>

    <nav class="navbar navbar-expand-lg navbar-light bg-primary ">
    <div class="container">

      <a class="navbar-brand" href="index.jsp">
      		오버워치 토론장
      		<img id="brand-image" src="img/blizarrd3.jpg" alt="Website Logo" > 
      </a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">메인</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              회원 관리

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">

              <a class="dropdown-item" href="userLogin.jsp">로그인</a>

              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>

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
    
    <div class="container">
    	<div class="alert alert-success mt-4" role="alert">
    		이메일 주소 인증 메일이 전송되었습니다. 회원가입시 등록하셨던 이메일에 들어가셔서 인증해주세요.
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
