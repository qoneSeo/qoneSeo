package dev.mvc.notice;

import java.util.ArrayList;


import dev.mvc.notice.NoticeVO;

public interface NoticeProcInter {

  /**
 * 등록
 * @param noticeVO
 * @return
 */
  public int create(NoticeVO noticeVO);
  
  /**
   * 목록
   * @return
   */
  public ArrayList<NoticeVO> list_all();
 
  /**
   * 읽기
   * @param noticeno
   * @return
   */
  public NoticeVO read(int noticeno);
  
  /**
   * 글 정보 수정
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(NoticeVO noticeVO);
  
  /**
   * 삭제
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int noticeno);
  
  
}