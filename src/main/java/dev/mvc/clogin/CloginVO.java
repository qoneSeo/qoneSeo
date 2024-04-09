package dev.mvc.clogin;
/* 
CLOGINNO                          NUMBER(10)     NOT NULL    PRIMARY KEY,
CREWNO                            NUMBER(10)     NULL ,
IP                                VARCHAR2(15)     NULL ,
LOGINDATE                         TIMESTAMP(10)    NULL ,
*/


public class CloginVO {
  
  /**로그인 번호*/
  private int cloginno;
  /**회원 번호*/
  private int crewno;
  /** IP주소*/
  private String ip;
  /**로그인 날짜*/
  private String logindate;
  
  
  public int getCloginno() {
    return cloginno;
  }
  public void setCloginno(int cloginno) {
    this.cloginno = cloginno;
  }
  public int getCrewno() {
    return crewno;
  }
  public void setCrewno(int crewno) {
    this.crewno = crewno;
  }
  public String getIp() {
    return ip;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getLogindate() {
    return logindate;
  }
  public void setLogindate(String logindate) {
    this.logindate = logindate;
  }
  
  
  @Override
  public String toString() {
    return "CloginVO [cloginno=" + cloginno + ", crewno=" + crewno + ", ip=" + ip + ", logindate=" + logindate + "]";
  }
 
  
  
  
  
  
}
