package utility;

import javax.mail.PasswordAuthentication;

import javax.mail.Authenticator;

public class Gmail extends Authenticator{                   // Gmail SMTP�� �̿��ϱ����ؼ� ���� ������ �ִ� �κ�
	                                              // Authenticator�� ����Ѱ��� ���������� �����ֱ� ������. 
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		
		return new PasswordAuthentication("chohyunsu1996@gmail.com", "dodo7925");    // ������(��)�� ���̵�� ����� �־���.
		              //��Ŭ�������� �� ���� �������� �ٷ� �����ϱ����ؼ� ���۰����� ���ȼ����� ������ ��� �ɼ��� ����������.
		                                       
	}

}
