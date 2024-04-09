package dev.mvc.reply;

public class ReplyVO {
  /** 댓글 번호 */
  private int replyno;
  /** 관련 글 번호 */
  private int createsno;
  /** 회원 번호 */
  private int crewno;
  /** 내용 */
  private String content = "";
  /** 등록일 */
  private String rdate = "";
  /** 아이디(이메일) */
  private String id;
  
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
  
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  @Override
  public String toString() {
    return "ReplyVO [replyno=" + replyno + ", createsno=" + createsno + ", crewno=" + crewno + ", content=" + content
        + ", rdate=" + rdate + ", id=" + id + "]";
  }
  
  
}
