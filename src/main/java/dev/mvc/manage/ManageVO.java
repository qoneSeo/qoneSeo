package dev.mvc.manage;

public class ManageVO {
  private int manageno;
  private String id;
  private String passwd;
  private String mname;
  private String mdate;
  private int grade;
  
  public int getManageno() {
    return manageno;
  }
  public void setManageno(int manageno) {
    this.manageno = manageno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  public String getMdate() {
    return mdate;
  }
  public void setMdate(String mdate) {
    this.mdate = mdate;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  
  @Override
  public String toString() {
    return "ManageVO [manageno=" + manageno + ", id=" + id + ", passwd=" + passwd + ", mname=" + mname + ", mdate=" + mdate
        + ", grade=" + grade + "]";
  }
  
  
}


