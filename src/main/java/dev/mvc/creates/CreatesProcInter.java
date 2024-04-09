package dev.mvc.creates;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.reply.ReplyVO;

/**
 * 개발자가 구현합니다.
 * @author seokyuwon
 *
 */
public interface CreatesProcInter {
  /**
   * 등록
   * @param CreatesVO
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
   *  특정 카테고리의 검색 + 페이징된 글목록
   *  spring framework이 JDBC 관련 코드를 모두 생성해줌
   * @return
   */
  public ArrayList<CreatesVO> list_by_cfoodno_search_paging(CreatesVO createsVO);
 
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cfoodno          카테고리번호 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @param list_file 목록 파일명 
   * @param search_count 검색 레코드수   
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int cfoodno, int now_page, String word, String list_file, int search_count);

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