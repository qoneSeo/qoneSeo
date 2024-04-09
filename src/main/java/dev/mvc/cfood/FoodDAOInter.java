package dev.mvc.cfood;

import java.util.ArrayList;

public interface FoodDAOInter {
  /**
   * 등록, 추상 메소드 -> Spring Boot이 구현함.
   * @param FoodVO 객체
   * @return 등록된 레코드 갯수
   */
  public int create(FoodVO foodVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<FoodVO> list_all();
  
  /**
   * 조회
   * @param cfoodno
   * @return
   */
  public FoodVO read(int cfoodno);
  
  /**
   * 수정   
   * @param FoodVO
   * @return 수정된 레코드 갯수
   */
  public int update(FoodVO foodVO);

  /**
   * 삭제
   * @param cfoodno 삭제할 레코드 PK 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int cfoodno);
  
  /**
   * 우선 순위 높임, 10 등 -> 1 등   
   * @param cfoodno
   * @return 수정된 레코드 갯수
   */
  public int update_seqno_forward(int cfoodno);

  /**
   * 우선 순위 낮춤, 1 등 -> 10 등   
   * @param cfoodno
   * @return 수정된 레코드 갯수
   */
  public int update_seqno_backward(int cfoodno);
  
  /**
   * 카테고리 공개 설정
   * @param cfoodno
   * @return
   */
  public int update_visible_y(int cfoodno);
  
  /**
   * 카테고리 비공개 설정
   * @param cfoodno
   * @return
   */
  public int update_visible_n(int cfoodno);
  
  /**
   * 비회원/회원 SELECT LIST
   * @return
   */
  public ArrayList<FoodVO> list_all_y();
  
}




