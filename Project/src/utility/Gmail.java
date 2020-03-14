package utility;

import javax.mail.PasswordAuthentication;

import javax.mail.Authenticator;

public class Gmail extends Authenticator{                   // Gmail SMTP를 이용하기위해서 계정 정보를 넣는 부분
	                                              // Authenticator을 상속한것은 인증수행을 도와주기 위함임. 
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		
		return new PasswordAuthentication("chohyunsu1996@gmail.com", "dodo7925");    // 관리자(나)의 아이디와 비번을 넣어줌.
		              //이클립스에서 내 구글 계정으로 바로 접근하기위해서 구글계정의 보안수준이 낮은앱 허용 옵션을 허용해줘야함.
		                                       
	}

}
