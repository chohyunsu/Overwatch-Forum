package user;

import java.sql.*;

public class UserDAO {

	private Connection conn; // 데이터베이스에 접근할수 있게해주는 객체
	private ResultSet rs; // 특정한 sql문장을 실행한 이후에 결과값에 대해서 처리를 할때 사용

	public UserDAO() { // 생성자
		try {
			String dbURL = "jdbc:mysql://localhost:3306/jspDB1?serverTimezone=UTC";
			String dbId = "jspfinalid1";
			String dbPass = "jsp2019";

			Class.forName("com.mysql.cj.jdbc.Driver"); // mysql Driver를 찾을수있도록 넣어줌.
			// Driver는 mysql에 접속할수있도록 매개체 역활을 해주는 하나의 라이브러리라할수잇음.
			conn = DriverManager.getConnection(dbURL, dbId, dbPass); // conn객체안에 접속된정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 여기 위까지하면 데이터베이스 접속완료

	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";           //사용자의 아이디가 실제로 존재하면 비밀번호를 검색함.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);             // ?에 해당하는 부분에 userID를 넣어줌.
			rs = pstmt.executeQuery();               // 데이터를 조회하는 부분이므로 executeQuery() 사용
			if (rs.next()) {                   // 결과가 존재한다면, 즉 아이디가 존재한다면 
				if (rs.getString(1).equals(userPassword))          //결과로 나온 userPassword를 받아서(해당 아이디의 비밀번호) 접속을 시도한 userPassword와 동일하다면 
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음.
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -2; // 데이터베이스 오류
	} 
	
	public int join(UserDTO user) {        // 회원가입 함수
		
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, false)";         // 처음 이메일인증은 안된상태이므로 false값을 넣어줌.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserEmailHash());
			return pstmt.executeUpdate();           // insert, update, delete인 경우에 해당되므로 executeUpdate()를 사용
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -1;           // 데이터베이스 오류 (회원가입 실패)
	}
	
	public String getUserEmail(String userID) {          // 사용자의 아이디를 이용해 이메일 주소를 반환하는 함수
		
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		try {	
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);     // db안의 이메일 주소 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;           // 데이터베이스 오류 
	}
	
	public boolean getUserEmailChecked(String userID) {         // 사용자가 현재 이메일 인증이 되었는지 확인하는 함수 (이메일인증이 안되면 글 게시 못함)
		
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1);     // 첫번째 속성, 즉 userEmailChecked값을 반환, 이메일 등록여부 반환 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return false;           // 데이터베이스 오류 
	}
	
	public boolean setUserEmailChecked(String userID) {           // 특정한 사용자의 이메일 인증을 수행 
		
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;          // 한번 인증이 된 사용자라도 추가적으로 인증 가능하게 return을 true로 함. (이메일 등록 설정 성공)
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;           // 이메일 등록 설정 실패
	}
}
