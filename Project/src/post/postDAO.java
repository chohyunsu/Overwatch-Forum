package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class postDAO {

	private Connection conn; // �����ͺ��̽��� �����Ҽ� �ְ����ִ� ��ü
	private ResultSet rs; // Ư���� sql������ ������ ���Ŀ� ������� ���ؼ� ó���� �Ҷ� ���
   
	
	
	public postDAO() { // ������
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
	
	public String getDate() {                  // ������ �ð��� �������� �Լ� (�Խ����� ���� �ۼ��Ҷ� ���� ������ �ð��� �־��ٶ� ����Ұ���)
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);         // ������ ��¥�� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";        //������ ���̽� ����
	}
	
	public int getNext() {                  
		String SQL = "SELECT postID FROM post ORDER BY postID DESC";       // ���� �������� ���� �۹�ȣ�� ������.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;         
			}
			return 1;             // ù��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;        //������ ���̽� ����
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
			pstmt.setInt(6, 1);                      // ó���� ���� �ۼ������� ���� �������������̰�, ������ �ȵȰ��̹Ƿ� �ʱⰪ 1��. 
			pstmt.setString(7, nickName);
			pstmt.setString(8, mainRole);
			pstmt.setInt(9, 0);         // ���� �����Ҷ� ��ȸ���� �ʱⰪ�� 0
			pstmt.setInt(10, 0);        // ���� �����Ҷ� ��õ���� �ʱⰪ�� 0
			return pstmt.executeUpdate();        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // ������ ���̽� ����
	}
	
	public int count(int postID) {                     // ��ȸ�� �����Լ� 
		String SQL="UPDATE post SET Count = Count + 1 " + " WHERE postID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // ������ ���̽� ����
	}
	
	public int totalCount() {                     // �Խù� ��ü ����
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
		return -1;       // ������ ���̽� ����
	}
	
	//static int flag = 0;
//	public ArrayList<postDTO> getList(int pageNumber) {
////		String SQL = "SELECT * FROM post WHERE postID < ? AND postAvailable = 1 ORDER BY postID DESC LIMIT 10";  //�� �������� 10������ �������.
//		String SQL = "SELECT * FROM post WHERE postID < ? ORDER BY postID DESC LIMIT 10";
//		//String SQL = "SELECT * FROM post ORDER BY postID DESC LIMIT 10";  
//		ArrayList<postDTO> list = new ArrayList<postDTO>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);        //�������� �ۼ��� �۹�ȣ���� ���� �������ѹ� - 1 ���ش��� ���ϱ� 10�Ѱ��� ���ָ� �װź��� �����͸� 10���� ������Եȴ�.
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
		
		if(mainRole.equals("��ü")) {
			mainRole = "";
		}
		
		String SQL = "";
		ArrayList<postDTO> list = new ArrayList<postDTO>();
		try {
			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //Ư���� ���ڿ��� �����ϴ��� ����� LIKE�� ���
						" AND postID < ? ORDER BY postID DESC LIMIT 10 ";
			} else if(searchType.equals("��õ��")) {
				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //Ư���� ���ڿ��� �����ϴ��� ����� LIKE�� ���
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
	public boolean nextPage(int pageNumber) {                       // Ư���� �������� �����ϴ��� ����� �Լ�(���������� 10���� �����ϹǷ� �Խù��� 10���� page�� 1, 11���� page�� 2)  
		String SQL = "SELECT * FROM post WHERE postID < ? Order BY postID DESC LIMIT 10";  
		//String SQL = "SELECT * FROM post WHERE postID < ? AND postAvailable = 1 ORDER BY postID DESC LIMIT 10";  //�� �������� 10������ �������.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);        //�������� �ۼ��� �۹�ȣ���� ���� �������ѹ� - 1 ���ش��� ���ϱ� 10�Ѱ��� ���ָ� �װź��� �����͸� 10���� ������Եȴ�.
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
	
	public postDTO getPostDto(int postID) {                 // �ϳ��� �۳����� �ҷ����� �Լ�
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
		return null;           // �ش� ���� �������� �ʴ°�� null�� ��ȯ
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
		return -1;       // ������ ���̽� ����
	}
	
	public int delete(int postID) {
		//String SQL = "UPDATE post SET postAvailable = 0 WHERE postID = ?";  // postAvailable�� 0���� �ٲ����ν� ���� �����ϴ��� �ۿ����� ������ DB�� ��������.
		String SQL = "DELETE FROM post WHERE postID = ?";       
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);    
			return pstmt.executeUpdate();    // ���������� �����ߴٸ� 0�̻��� ���� ��ȯ��    
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;       // ������ ���̽� ����
	}
	
	public int recommend(String postID) {              // ��õ�Ҷ� ���� �Լ�
		String SQL = "UPDATE post SET recommendCount = recommendCount + 1 WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;           // �����ͺ��̽� ����  
	}
	
	public String getUserID(String postID) {               // �Խñ��� �ۼ��� ����� ���̵��� ��ȯ�ϴ� �Լ�
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
		return null;           // ���������ʴ� ���̵��ϰ��
	}
	
//	public ArrayList<postDTO> getSearchList (String mainRole, String searchType, String search, int pageNumber) {             //����ڰ� �˻��� ���뿡 ���� ����� ��ȯ
//		if(mainRole.equals("��ü")) {
//			mainRole = "";
//		}
//		ArrayList<postDTO> postList = null;             // ���� ���� ����Ʈ
//		String SQL = "";          
//		try {
//			if(searchType.equals("�ֽż�")) {
//				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //Ư���� ���ڿ��� �����ϴ��� ����� LIKE�� ���
//						" ORDER BY postID DESC LIMIT " + pageNumber * 10 + ", " + pageNumber * 10 + 11;
//			} else if (searchType.equals("��õ��")) {
//				SQL = "SELECT * FROM post WHERE mainRole LIKE ? AND CONCAT(nickName, postTitle, postContent) LIKE ? " +       //Ư���� ���ڿ��� �����ϴ��� ����� LIKE�� ���
//						" ORDER BY recommendCount DESC LIMIT " + pageNumber * 10 + ", " + pageNumber * 10 + 11;
//			}
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, "%" + mainRole + "%");   // mainRole�� �����ϴ��� ������ߵ�. (������, ��Ŀ��, ������)   
//			pstmt.setString(2, "%" + search + "%");   // ����ڰ� �˻��� ������ search�� �־���
//			rs = pstmt.executeQuery();               // �����͸� ��ȸ�ϴ� �κ��̹Ƿ� executeQuery() ���
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
