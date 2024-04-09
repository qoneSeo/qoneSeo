package dev.mvc.creates;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.creates.CreatesVO;
import dev.mvc.reply.ReplyVO;

  /**
   * Spring Boot가 자동 구현
   * @author seokyuwon
   *
   */
  public interface CreatesDAOInter {
  /**
   * 등록, 추상 메소드
   * @param createsVO
   * @return
   */
  public int create(CreatesVO createsVO);
  
  /**
   * 모든 카테고리의 등록된 글목록
   * @return
   */
  public ArrayList<CreatesVO> list_all();
  
  /**
   * 카테고리별 등록된 글 목록
   * @param cfoodno
   * @return
   */
  public ArrayList<CreatesVO> list_by_cfoodno(int cfoodno);
  
  /**
   * 조회
   * @param createsno
   * @return
   */
  public CreatesVO read(int createsno);
  
  /**
   * map 등록, 수정, 삭제
   * @param map
   * @return 수정된 레코드 갯수
   */
  public int map(HashMap<String, Object> map);

  /**
   * youtube 등록, 수정, 삭제
   * @param youtube
   * @return 수정된 레코드 갯수
   */
  public int youtube(HashMap<String, Object> map);
 
  /**
   * 카테고리별 검색 목록
   * @param map
   * @return
   */
  public ArrayList<CreatesVO> list_by_cfoodno_search(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색된 레코드 갯수
   * @param map
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
   
  /**
   * 카테고리별 검색 목록 + 페이징
   * @param createsVO
   * @return
   */
  public ArrayList<CreatesVO> list_by_cfoodno_search_paging(CreatesVO createsVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int password_check(HashMap<String, Object> hashMap);
  
  /**
   * 글 정보 수정
   * @param createsVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(CreatesVO createsVO);

  /**
   * 파일 정보 수정
   * @param createsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(CreatesVO createsVO);
 
  /**
   * 삭제
   * @param createsno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int createsno);
  
  /**
   * FK cfoodno 값이 같은 레코드 갯수 산출
   * @param cfoodno
   * @return
   */
  public int count_by_cfoodno(int cfoodno);
 
  /**
   * 특정 카테고리에 속한 모든 레코드 삭제
   * @param cfoodno
   * @return 삭제된 레코드 갯수
   */
  public int delete_by_cfoodno(int cfoodno);
  
  /**
   * 글 수 증가
   * @param 
   * @return
   */ 
  public int increaseReplycnt(int createsno);
 
  /**
   * 글 수 감소
   * @param 
   * @return
   */   
  public int decreaseReplycnt(int createsno);
  
  public int count_by_replyno(int replyno);
  public int delete_by_replyno(int replyno);
  public ArrayList<CreatesVO> list_by_replyno(int replyno);
  
}
