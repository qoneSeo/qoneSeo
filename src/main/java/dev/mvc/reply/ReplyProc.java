package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.creates.CreatesVO;
import dev.mvc.notice.NoticeVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {
  @Autowired
  private ReplyDAOInter replyDAO; 
  
  @Override
  public int create(ReplyVO replyVO) {
    int cnt = replyDAO.create(replyVO);
    return cnt;
  }

  @Override
  public ArrayList<ReplyVO> list() {
    ArrayList<ReplyVO> list = this.replyDAO.list();
    return list;
  }
  
  @Override
  public ReplyVO read(int replyno) {
    ReplyVO  replyVO  = this.replyDAO.read(replyno);
    return replyVO;
  } 
  

 
  @Override
  public ArrayList<ReplyVO> list_by_createsno(int createsno) {
    ArrayList<ReplyVO> list = this.replyDAO.list_by_createsno(createsno);
    String content = "";
    
    // 특수 문자 변경
    for (ReplyVO replyVO:list) {
      content = replyVO.getContent();
      content = Tool.convertChar(content);
      replyVO.setContent(content);
    }
    return list;
  }

  @Override
  public int delete(int replyno) {
    int cnt = this.replyDAO.delete(replyno);
    return cnt;
  }
  

  
  
  
}