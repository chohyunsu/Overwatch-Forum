package recommend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class recommendDAO {
	
	private Connection conn; // �����ͺ��̽��� �����Ҽ� �ְ����ִ� ��ü
	private ResultSet rs; // Ư���� sql������ ������ ���Ŀ� ������� ���ؼ� ó���� �Ҷ� ���

	public recommendDAO() { // ������
		try {
			String dbURL = "jdbc:mysql://localhost:3306/jspDB1?serverTimezone=UTC";
			String dbId = "jspfinalid1";
			String dbPass = "jsp2019";

			Class.forName("com.mysql.cj.jdbc.Driver"); // mysql Driver�� ã�����ֵ��� �־���.
			// Driver�� mysql�� �����Ҽ��ֵ��� �Ű�ü ��Ȱ�� ���ִ� �ϳ��� ���̺귯�����Ҽ�����.
			conn = DriverManager.getConnection(dbURL, dbId, dbPass); // conn��ü�ȿ� ���ӵ������� ���� ��.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ���� �������ϸ� �����ͺ��̽� ���ӿϷ�

	public int recommend(String userID, String postID, String userIP) {
		
		String SQL = "INSERT INTO recommend VALUES (?, ?, ?)";         
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, postID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();           // insert, update, delete�� ��쿡 �ش�ǹǷ� executeUpdate()�� ���
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -1;           // ��õ �ߺ� ����
	}
	
}
