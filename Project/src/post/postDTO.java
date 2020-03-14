package post;

public class postDTO {

	private int postID;
	private String postTitle;
	private String userID;
	private String postDate;
	private String postContent;
	private int postAvailable;
	private String nickName;
	private String mainRole;
	private int Count;
	private int recommendCount;
	
	
	public int getCount() {
		return Count;
	}
	public void setCount(int count) {
		Count = count;
	}
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public int getPostAvailable() {
		return postAvailable;
	}
	public void setPostAvailable(int postAvailable) {
		this.postAvailable = postAvailable;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getMainRole() {
		return mainRole;
	}
	public void setMainRole(String mainRole) {
		this.mainRole = mainRole;
	}
	public int getRecommendCount() {
		return recommendCount;
	}
	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}
	
}
