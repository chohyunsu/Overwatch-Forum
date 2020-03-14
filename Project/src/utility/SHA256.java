package utility;

import java.security.MessageDigest;

public class SHA256 {                    //회원가입 이후에 이메일 인증을 할때 기존에 존재하던 이메일값에 해쉬값을 적용해서 사용자가 그것을 
	                                    // 인증코드로 링크를 타고 들어와서 인증을 할수 있게하는것.

	public static String getSHA256(String input) {        // 특정한 값(이메일)을 넣었을때 그 값을 SHA256으로 해쉬값을 구하는 함수
		
		StringBuffer result = new StringBuffer();
		try {
			
			MessageDigest digest = MessageDigest.getInstance("SHA-256");    //실제로 사용자가 입력한 값을 SHA256으로 알고리즘을 적용
			byte[] salt = "protect for Hackers".getBytes();   // SHA256만 적용하면 해킹을 당할 위험성이 높아지므로 솔트값을 적용시켜줌. 원래의 데이터를 파악하기 더욱 어렵게 만들어줌.
			digest.reset();
			digest.update(salt);         //솔트값을 적용
			byte[] chars = digest.digest(input.getBytes("UTF-8"));    //실제로 해쉬를 적용한값을 배열에 담아둠.
			for(int i=0; i<chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);   //hex값과 현재 이 해쉬값을 적용한 chars의 해당 index를 앤드연산
				if(hex.length() == 1) 
					result.append('0');               // 1자리수일경우 0을 붙여서 총 2자리 값을 가지는 16진수형태로 출력할려고함.
				result.append(hex);      //hex값을 뒤에 담.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
