package dev.mvc.notice;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.notice.NoticeVO;
import dev.mvc.tool.Tool;
import dev.mvc.creates.CreatesVO;
import dev.mvc.manage.ManageProcInter;

@Controller
public class NoticeCont {

  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProc noticeProc;
  
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;
  
  @RequestMapping(value="/notice/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/create"); 
    
    return mav;
  }

  /**
   * 등록 처리 http://localhost:9092/notice/create.do
   * POST 요청 처리
   */
  @RequestMapping(value="/notice/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, NoticeVO noticeVO) { 
    ModelAndView mav = new ModelAndView();
    
    
    if (manageProc.isManage(session)) { 
      int manageno = (int)session.getAttribute("manageno");
      noticeVO.setManageno(manageno);
      
      int cnt = this.noticeProc.create(noticeVO);
    
    if (cnt == 1) {
      mav.addObject("code", "create_success");
      mav.addObject("title", noticeVO.getTitle());
      
    } else {
      mav.addObject("code", "create_fail");
    }
    mav.addObject("cnt", cnt);
    } else {
      mav.addObject("code", "create_fail");
    }
    
    mav.setViewName("/notice/msg");
    return mav;
    
    }
  

  /**
   * 전체 목록
   * http://localhost:9092/notice/list_all.do
   * @return
   */
  @RequestMapping(value="/notice/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/list_all");
    

      ArrayList<NoticeVO> list = this.noticeProc.list_all();
      mav.addObject("list", list);
      
    return mav;
  }
 
  /**
   * 조회
   * http://localhost:9092/notice/read.do
   * @return
   */
  @RequestMapping(value="/notice/read.do", method = RequestMethod.GET)
  public ModelAndView read(int noticeno) { 
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/read");
    
    NoticeVO noticeVO = this.noticeProc.read(noticeno);
    mav.addObject("noticeVO", noticeVO);
    
    String title = noticeVO.getTitle();
    String content = noticeVO.getContent();
    
    title = Tool.convertChar(title);  // 특수 문자 처리
    content = Tool.convertChar(content); 
    
    noticeVO.setTitle(title);
    noticeVO.setContent(content);  
    
    return mav;
  }
  /**
   * 수정 폼
   * http://localhost:9092/notice/update_text.do?noticeno=3
   * @return
   */
  @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(HttpSession session, @RequestParam(name = "noticeno", defaultValue = "0") int noticeno) {
    ModelAndView mav = new ModelAndView();
   
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우      
      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);
     
      mav.setViewName("/notice/update_text");       
      
    } else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }

    return mav; // forward
  }
  
  /**
   * 수정 처리
   * http://localhost:9092/notice/update_text.do
   * 
   * @return
   */
  @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(HttpSession session, NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();

      if (this.manageProc.isManage(session)) { // 관리자 로그인 확인
          // 공지사항 업데이트
          this.noticeProc.update_text(noticeVO); // 글 수정
          mav.addObject("noticeno", noticeVO.getNoticeno());
          mav.setViewName("redirect:/notice/read.do"); // 페이지 이동
      } else {
          mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
          mav.setViewName("redirect:/creates/msg.do");
      }

      return mav; // forward or redirect
  }

  /**
   * 삭제 폼
   * http://localhost:9092/notice/delete.do?noticeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/notice/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session,@RequestParam(name = "noticeno", defaultValue = "0")  int noticeno) {
    ModelAndView mav = new ModelAndView();
    
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우
      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);
      
      
      mav.setViewName("/notice/delete"); // /WEB-INF/views/creates/delete.jsp
      
    } else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }


    return mav; // forward
  }
  /**
   * 삭제 처리 http://localhost:9092/notice/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();
    
 
    this.noticeProc.delete(noticeVO.getNoticeno()); // DBMS 삭제
        

    mav.setViewName("redirect:/notice/list_all.do");
    
    return mav;
  }   
}