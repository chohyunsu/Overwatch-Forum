package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class postDAO {

	private Connection conn; // 데이터베이스에 접근할수 있게해주는 객체
	private ResultSet rs; // 특정한 sql문장을 실행한 이후에 결과값에 대해서 처리를 할때 사용
   
	
	
	public postDAO() { // 생성자
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
	
	public String getDate() {                  // 현재의 시간을 가져오는 함수 (게시판의 글을 작성할때 현재 서버의 시간을 넣어줄때 사용할것임)
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);         // 현재의 날짜를 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";        //데이터 베이스 오류
	}
	
	public int getNext() {                  
		String SQL = "SELECT postID FROM post ORDER BY postID DESC";       // 제일 마지막에 쓰인 글번호를 가져옴.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;         
			}
			return 1;             // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;        //데이터 베이스 오류
	}
	
	public int post(String postTitle, String userID, String postContent, String nickName, String mainRole) {
		String SQL = "INSERT INTO post VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";      
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 
			/* pstmt.setInt(1, totalCount() + 1); */
			pstmt.setString(2, postTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, postContent);
			pstmt.setInt(6, 1);                      // 처음에 글을 작성했을때 글이 보여지는형태이고, 삭제가 안된것이므로 초기값 1임. 
			pstmt.setString(7, nickName);
			pstmt.setString(8, mainRole);
			pstmt.setInt(9, 0);         // 글을 생성할때 조회수의 초기값은 0
			pstmt.setInt(10, 0);        // 글을 생성할때 추천수의 초기값은 0
			return pstmt.executeUpdate();        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // 데이터 베이스 오류
	}
	
	public int count(int postID) {                     // 조회수 증가함수 
		String SQL="UPDATE post SET Count = Count + 1 " + " WHERE postID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // 데이터 베이스 오류
	}
	
	public int totalCount() {                     // 게시물 전체 갯수
		String SQL="SELECT count(*) FROM post";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();  
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // 데이터 베이스 오류
	}
	
	//static int flag = 0;
//	public ArrayList<postDTO> getList(int pageNumber) {
////		String SQL = "SELECT * FROM post WHERE postID < ? AND postAvailable = 1 ORDER BY postID DESC LIMIT 10";  //한 페이지에 10개씩만 가지고옴.
//		String SQL = "SELECT * FROM post WHERE postID < ? ORDER BY postID DESC LIMIT 10";
//		//String SQL = "SELECT * FROM post ORDER BY postID DESC LIMIT 10";  
//		ArrayList<postDTO> list = new ArrayList<postDTO>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);        //다음으로 작성될 글번호에서 현재 페이지넘버 - 1 해준다음 곱하기 10한것을 빼주면 그거보다 작은것만 10개씩 갖고오게된다.
//			//flag++;
//			//System.out.println("flag : " + flag);
//			
//			/*
//			 * if (flag == 1) pstmt.setInt(1, (totalCount() + 2) - 10 * (pageNumber - 1) );
//			 * else pstmt.setInt(1, (totalCount()+2) - 10 * (pageNumber - 1) );
//			 */
////			 pstmt.setInt(1, (totalCount()+2) - 10 * (pageNumber - 1) );
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				postDTO postdto = new postDTO();
//				postdto.setPostID(rs.getInt(1));
//				postdto.setPostTitle(rs.getString(2));
//				postdto.setUserID(rs.getString(3));
//				postdto.setPostDate(rs.getString(4));
//				postdto.setPostContent(rs.getString(5));
//				postdto.setPostAvailable(rs.getInt(6));
//				postdto.setNickName(rs.getString(7));
//				postdto.setMainRole(rs.getString(8));
//				postdto.setCount(rs.getInt(9));
//				postdto.setRecommendCount(rs.getInt(10));
//				list.add(postdto);      
//			}           
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;       
//	}
//	
	
	public ArrayList<postDTO> getList(String mainRole, String searchType, String search, int pageNumber) {
		
		if(mainRole.equals("전체")) {
			mainRole = "";
		}
		
		String SQL = "";
		ArrayList<postDTO> list = new ArrayList<postDTO>();
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //특정한 문자열을 포함하는지 물어보는 LIKE를 사용
						" AND postID < ? ORDER BY postID DESC LIMIT 10 ";
			} else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //특정한 문자열을 포함하는지 물어보는 LIKE를 사용
						" AND postID < ? ORDER BY recommendCount DESC LIMIT 10 ";
			}
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + mainRole + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setInt(3, getNext() - (pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				postDTO postdto = new postDTO();
				postdto.setPostID(rs.getInt(1));
				postdto.setPostTitle(rs.getString(2));
				postdto.setUserID(rs.getString(3));
				postdto.setPostDate(rs.getString(4));
				postdto.setPostContent(rs.getString(5));
				postdto.setPostAvailable(rs.getInt(6));
				postdto.setNickName(rs.getString(7));
				postdto.setMainRole(rs.getString(8));
				postdto.setCount(rs.getInt(9));
				postdto.setRecommendCount(rs.getInt(10));
				list.add(postdto);      
			}           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;       
	}
	
	
	//static int flag2 = 0;
	public boolean nextPage(int pageNumber) {                       // 특정한 페이지가 존재하는지 물어보는 함수(한페이지에 10개씩 존재하므로 게시물이 10개면 page는 1, 11개면 page는 2)  
		String SQL = "SELECT * FROM post WHERE postID < ? Order BY postID DESC LIMIT 10";  
		//String SQL = "SELECT * FROM post WHERE postID < ? AND postAvailable = 1 ORDER BY postID DESC LIMIT 10";  //한 페이지에 10개씩만 가지고옴.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);        //다음으로 작성될 글번호에서 현재 페이지넘버 - 1 해준다음 곱하기 10한것을 빼주면 그거보다 작은것만 10개씩 갖고오게된다.
//			flag2++;
//			System.out.println("flag2 : " + flag2);
//			if (flag2 == 1)
//				pstmt.setInt(1, (totalCount() + 1) - 10 * (pageNumber - 1) );
//			else 
//				pstmt.setInt(1, (totalCount() + 1) - 10 * (pageNumber - 1) );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true; 
			}           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;       
	}
	
	public postDTO getPostDto(int postID) {                 // 하나의 글내용을 불러오는 함수
		String SQL = "SELECT * FROM post WHERE postID = ?";  
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);     
			rs = pstmt.executeQuery();
			if(rs.next()) {
				postDTO postdto = new postDTO();
				postdto.setPostID(rs.getInt(1));
				postdto.setPostTitle(rs.getString(2));
				postdto.setUserID(rs.getString(3));
				postdto.setPostDate(rs.getString(4));
				postdto.setPostContent(rs.getString(5));
				postdto.setPostAvailable(rs.getInt(6));
				postdto.setNickName(rs.getString(7));
				postdto.setMainRole(rs.getString(8));
				return postdto;  
			}           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;           // 해당 글이 존재하지 않는경우 null을 반환
	}
	
	public int update(int postID, String postTitle, String postContent) {
		String SQL = "UPDATE post SET postTitle = ?, postContent = ? WHERE postID = ?";      
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postTitle);
			pstmt.setString(2, postContent);
			pstmt.setInt(3, postID);
			return pstmt.executeUpdate();              
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // 데이터 베이스 오류
	}
	
	public int delete(int postID) {
		//String SQL = "UPDATE post SET postAvailable = 0 WHERE postID = ?";  // postAvailable을 0으로 바꿈으로써 글을 삭제하더라도 글에대한 정보가 DB에 남아있음.
		String SQL = "DELETE FROM post WHERE postID = ?";       
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);    
			return pstmt.executeUpdate();    // 성공적으로 수행했다면 0이상의 값이 반환됨    
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // 데이터 베이스 오류
	}
	
	public int recommend(String postID) {              // 추천할때 쓰는 함수
		String SQL = "UPDATE post SET recommendCount = recommendCount + 1 WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;           // 데이터베이스 오류  
	}
	
	public String getUserID(String postID) {               // 게시글을 작성한 사용자 아이디값을 반환하는 함수
		String SQL = "SELECT userID FROM post where postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;           // 존재하지않는 아이디일경우
	}
	
//	public ArrayList<postDTO> getSearchList (String mainRole, String searchType, String search, int pageNumber) {             //사용자가 검색할 내용에 대한 결과를 반환
//		if(mainRole.equals("전체")) {
//			mainRole = "";
//		}
//		ArrayList<postDTO> postList = null;             // 글이 담기는 리스트
//		String SQL = "";          
//		try {
//			if(searchType.equals("최신순")) {
//				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //특정한 문자열을 포함하는지 물어보는 LIKE를 사용
//						" ORDER BY postID DESC LIMIT " + pageNumber * 10 + ", " + pageNumber * 10 + 11;
//			} else if (searchType.equals("추천순")) {
//				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //특정한 문자열을 포함하는지 물어보는 LIKE를 사용
//						" ORDER BY recommendCount DESC LIMIT " + pageNumber * 10 + ", " + pageNumber * 10 + 11;
//			}
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, "%" + mainRole + "%");   // mainRole을 포함하는지 물어봐야됨. (딜러냐, 탱커냐, 힐러냐)   
//			pstmt.setString(2, "%" + search + "%");   // 사용자가 검색한 내용인 search을 넣어줌
//			rs = pstmt.executeQuery();               // 데이터를 조회하는 부분이므로 executeQuery() 사용
//			postList = new ArrayList<postDTO>();
//			while (rs.next()) {                   
//				postDTO  post = new postDTO(
//						rs.getInt(1), 
//						rs.getString(2), 
//						rs.getString(3),
//						rs.getString(4), 
//						rs.getString(5),
//						rs.getInt(6),
//						rs.getString(7),
//						rs.getString(8),
//						rs.getInt(9),
//						rs.getInt(10)
//						);
//				postList.add(post);
//			}  
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} 
//		return postList;   
//	}
}
