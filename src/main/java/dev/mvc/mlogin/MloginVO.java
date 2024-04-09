package dev.mvc.mlogin;
/*
mloginno                          NUMBER(10)     NULL      PRIMARY KEY,
manageno                          NUMBER(10)     NOT NULL,
ip                                VARCHAR2(15)     NULL ,
logindate                         TIMESTAMP(5)     NULL ,
*/

public class MloginVO {
  
  /**로그인 번호*/
  private int mloginno;
  /**관리자 번호*/
  private int manageno;
  /**ip주소*/
  private String ip;
  /**로그인 날짜*/
  private String logindate;
  
  
  public int getMloginno() {
    return mloginno;
  }
  public void setMloginno(int mloginno) {
    this.mloginno = mloginno;
  }
  public int getManageno() {
    return manageno;
  }
  public void setManageno(int manageno) {
    this.manageno = manageno;
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
    return "MloginVO [mloginno=" + mloginno + ", manageno=" + manageno + ", ip=" + ip + ", logindate=" + logindate
        + "]";
  }
  
  
  
}