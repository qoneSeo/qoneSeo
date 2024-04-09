package dev.mvc.mlogin;

import java.util.ArrayList;


public interface MloginDAOInter {
  
  /**
   * 등록, 추상 메소드
   * @param mloginVO
   * @return
   */
  public int create(MloginVO mloginVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<MloginVO> list_all();
  
  /**
  * 특정 회원번호의 로그인 내역 리스트
  * @return
  */
  public ArrayList<MloginVO> list_mlogin(int manageno);
  
  /**
   * 삭제
   * @param mloginno 삭제할 레코드 PK 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int mloginno);
  
}
