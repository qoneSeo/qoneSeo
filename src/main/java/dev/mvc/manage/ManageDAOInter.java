package dev.mvc.manage;

public interface ManageDAOInter {
  /**
   * 로그인
   * @param ManageVO
   * @return
   */
  public int login(ManageVO manageVO);
  
  /**
   * 회원 정보
   * @param String
   * @return
   */
  public ManageVO read_by_id(String id);
  
  /**
   * 회원 정보 조회
   * @param Manageno
   * @return
   */
  public ManageVO read(int manageno);
  
}
