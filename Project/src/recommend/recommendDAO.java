package recommend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class recommendDAO {
	
	private Connection conn; // 데이터베이스에 접근할수 있게해주는 객체
	private ResultSet rs; // 특정한 sql문장을 실행한 이후에 결과값에 대해서 처리를 할때 사용

	public recommendDAO() { // 생성자
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

	public int recommend(String userID, String postID, String userIP) {
		
		String SQL = "INSERT INTO recommend VALUES (?, ?, ?)";         
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, postID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();           // insert, update, delete인 경우에 해당되므로 executeUpdate()를 사용
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return -1;           // 추천 중복 오류
	}
	
}
