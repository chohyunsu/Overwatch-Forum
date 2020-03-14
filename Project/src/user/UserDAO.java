package user;

import java.sql.*;

public class UserDAO {

	private Connection conn; // �����ͺ��̽��� �����Ҽ� �ְ����ִ� ��ü
	private ResultSet rs; // Ư���� sql������ ������ ���Ŀ� ������� ���ؼ� ó���� �Ҷ� ���

	public UserDAO() { // ������
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

	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";           //������� ���̵� ������ �����ϸ� ��й�ȣ�� �˻���.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);             // ?�� �ش��ϴ� �κп� userID�� �־���.
			rs = pstmt.executeQuery();               // �����͸� ��ȸ�ϴ� �κ��̹Ƿ� executeQuery() ���
			if (rs.next()) {                   // ����� �����Ѵٸ�, �� ���̵� �����Ѵٸ� 
				if (rs.getString(1).equals(userPassword))          //����� ���� userPassword�� �޾Ƽ�(�ش� ���̵��� ��й�ȣ) ������ �õ��� userPassword�� �����ϴٸ� 
					return 1; // �α��� ����
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����.
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -2; // �����ͺ��̽� ����
	} 
	
	public int join(UserDTO user) {        // ȸ������ �Լ�
		
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, false)";         // ó�� �̸��������� �ȵȻ����̹Ƿ� false���� �־���.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserEmailHash());
			return pstmt.executeUpdate();           // insert, update, delete�� ��쿡 �ش�ǹǷ� executeUpdate()�� ���
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -1;           // �����ͺ��̽� ���� (ȸ������ ����)
	}
	
	public String getUserEmail(String userID) {          // ������� ���̵� �̿��� �̸��� �ּҸ� ��ȯ�ϴ� �Լ�
		
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		try {	
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);     // db���� �̸��� �ּ� ��ȯ
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;           // �����ͺ��̽� ���� 
	}
	
	public boolean getUserEmailChecked(String userID) {         // ����ڰ� ���� �̸��� ������ �Ǿ����� Ȯ���ϴ� �Լ� (�̸��������� �ȵǸ� �� �Խ� ����)
		
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1);     // ù��° �Ӽ�, �� userEmailChecked���� ��ȯ, �̸��� ��Ͽ��� ��ȯ 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return false;           // �����ͺ��̽� ���� 
	}
	
	public boolean setUserEmailChecked(String userID) {           // Ư���� ������� �̸��� ������ ���� 
		
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;          // �ѹ� ������ �� ����ڶ� �߰������� ���� �����ϰ� return�� true�� ��. (�̸��� ��� ���� ����)
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;           // �̸��� ��� ���� ����
	}
}
