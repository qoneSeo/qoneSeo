package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dev.mvc.creates.CreatesVO;

public interface ReplyDAOInter {
  
  /**
   * 등록
   * @param 
   * @return
   */
  public int create(ReplyVO replyVO);
  
  public ArrayList<ReplyVO> list();
  
  public int delete(int replyno);
  
  public ReplyVO read(int replyno);

  public ArrayList<ReplyVO> list_by_createsno(int createsno);
  

}