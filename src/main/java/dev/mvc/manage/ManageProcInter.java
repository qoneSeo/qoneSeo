package dev.mvc.manage;

import javax.servlet.http.HttpSession;

public interface ManageProcInter {
  /**
   * 로그인
   * @param manageVO
   * @return
   */
  public int login(ManageVO manageVO);
  
  /**
   * 관리자 정보
   * @param String
   * @return
   */
  public ManageVO read_by_id(String id);
  
  /**
   * 관리자 로그인 체크
   * @param session
   * @return
   */
  public boolean isManage(HttpSession session);
  
  /**
   * 회원 정보 조회
   * @param manageno
   * @return
   */
  public ManageVO read(int manageno);
  
}


