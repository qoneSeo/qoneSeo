package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ReplyProcInter {
  
  /**
   * 등록
   * @param replyVO
   * @return
   */
  public int create(ReplyVO replyVO);
  
  public ArrayList<ReplyVO> list();
  
  public ArrayList<ReplyVO> list_by_createsno(int createsno);
  
  public int delete(int replyno);

  public ReplyVO read(int replyno);
  

}