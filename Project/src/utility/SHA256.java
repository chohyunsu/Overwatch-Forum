package utility;

import java.security.MessageDigest;

public class SHA256 {                    //ȸ������ ���Ŀ� �̸��� ������ �Ҷ� ������ �����ϴ� �̸��ϰ��� �ؽ����� �����ؼ� ����ڰ� �װ��� 
	                                    // �����ڵ�� ��ũ�� Ÿ�� ���ͼ� ������ �Ҽ� �ְ��ϴ°�.

	public static String getSHA256(String input) {        // Ư���� ��(�̸���)�� �־����� �� ���� SHA256���� �ؽ����� ���ϴ� �Լ�
		
		StringBuffer result = new StringBuffer();
		try {
			
			MessageDigest digest = MessageDigest.getInstance("SHA-256");    //������ ����ڰ� �Է��� ���� SHA256���� �˰����� ����
			byte[] salt = "protect for Hackers".getBytes();   // SHA256�� �����ϸ� ��ŷ�� ���� ���輺�� �������Ƿ� ��Ʈ���� ���������. ������ �����͸� �ľ��ϱ� ���� ��ư� �������.
			digest.reset();
			digest.update(salt);         //��Ʈ���� ����
			byte[] chars = digest.digest(input.getBytes("UTF-8"));    //������ �ؽ��� �����Ѱ��� �迭�� ��Ƶ�.
			for(int i=0; i<chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);   //hex���� ���� �� �ؽ����� ������ chars�� �ش� index�� �ص忬��
				if(hex.length() == 1) 
					result.append('0');               // 1�ڸ����ϰ�� 0�� �ٿ��� �� 2�ڸ� ���� ������ 16�������·� ����ҷ�����.
				result.append(hex);      //hex���� �ڿ� ��.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
