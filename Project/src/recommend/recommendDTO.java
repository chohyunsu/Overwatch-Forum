package recommend;

public class recommendDTO {

	String userID;
	int postID;
	String userIP;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public recommendDTO() {
		
	}
	
	public recommendDTO(String userID, int postID, String userIP) {
		super();
		this.userID = userID;
		this.postID = postID;
		this.userIP = userIP;
	}
	
	
}
