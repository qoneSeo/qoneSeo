package dev.mvc.notice;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import dev.mvc.tool.Tool;

@Component("dev.mvc.notice.NoticeProc")
public class NoticeProc implements NoticeProcInter {
  
  @Autowired // ContentsDAOInter interface를 구현한 클래스의 객체를 만들어 자동으로 할당해라.
  private NoticeDAOInter noticeDAO; 
  
  @Override
  public int create(NoticeVO noticeVO) {
    int cnt = this.noticeDAO.create(noticeVO);
    return cnt;
  }

  @Override
  public ArrayList<NoticeVO> list_all() {
    ArrayList<NoticeVO> list = this.noticeDAO.list_all();
    
    return list;
  }
  /**
   * 조회
   */
  @Override
    public NoticeVO read(int noticeno) {
      NoticeVO  noticeVO  = this.noticeDAO.read(noticeno);
      return noticeVO;
    }  
  
  @Override
  public int update_text(NoticeVO noticeVO) {
    int cnt = this.noticeDAO.update_text(noticeVO);
    return cnt;
  }

  @Override
  public int delete(int noticeno) {
    int cnt = this.noticeDAO.delete(noticeno);
    return cnt;
  }
  

 

   
}