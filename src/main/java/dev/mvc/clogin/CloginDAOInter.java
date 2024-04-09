package dev.mvc.clogin;

import java.util.ArrayList;


public interface CloginDAOInter {
  
  /**
   * 등록, 추상 메소드
   * @param cloginVO
   * @return
   */
  public int create(CloginVO cloginVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<CloginVO> list_all();
  
  /**
  * 특정 회원번호의 로그인 내역 리스트
  * @return
  */
  public ArrayList<CloginVO> list_clogin(int crewno);
  
  /**
   * 삭제
   * @param cloginno 삭제할 레코드 PK 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int cloginno);
  
}
