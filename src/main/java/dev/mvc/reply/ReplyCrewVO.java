package dev.mvc.reply;

public class ReplyCrewVO {
  /** 아이디 */
  private String id;
  
  /** 댓글 번호 */
  private int replyno;
  /** 관련 글 번호 */
  private int createsno;
  /** 회원 번호 */
  private int crewno;
  /** 내용 */
  private String content;
  /** 등록일 */
  private String rdate;
  
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public int getReplyno() {
    return replyno;
  }
  public void setReplyno(int replyno) {
    this.replyno = replyno;
  }
  public int getCreatesno() {
    return createsno;
  }
  public void setCreatesno(int createsno) {
    this.createsno = createsno;
  }
  public int getCrewno() {
    return crewno;
  }
  public void setCrewno(int crewno) {
    this.crewno = crewno;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }

  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  
}
