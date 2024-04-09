package dev.mvc.mlogin;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manage.ManageProcInter;

@Controller
public class MloginCont {
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;

  @Autowired
  @Qualifier("dev.mvc.mlogin.MloginProc")
  private MloginProcInter mloginProc;
  
  public MloginCont(){
    System.out.println("-> MloginCont created.");
  }
 
  /**
   * 로그인 내역
   * // FORM 데이터 처리 http://localhost:9092/mlogin/list_all.do
   * @return
   */
  @RequestMapping(value="/mlogin/list_all.do",method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.manageProc.isManage(session) == true) {
      mav.setViewName("/mlogin/list_all");// /WEB-INF/views/mlogin/list_all.jsp
      
      ArrayList<MloginVO> list = this.mloginProc.list_all();
      mav.addObject("list",list);
    }
    else {
      mav.setViewName("/manage/login_need");// /webapp/WEB-INF/views/manage/login_need.jsp
    }
    return mav;
  }
  
  //http://localhost:9092/mlogin/list_by_mlogin.do
  /**
   * 관리자별 로그인 내역 조회 목록
   */
  @RequestMapping(value="/mlogin/list_by_mlogin.do", method=RequestMethod.GET)
  public ModelAndView list_mlogin(HttpSession session) {
      ModelAndView mav = new ModelAndView();
     int manageno = 0;

      if(this.manageProc.isManage(session)) {
          mav.setViewName("/mlogin/list_by_mlogin"); // /WEB-INF/views/mlogin/list_by_mlogin.jsp
          
          // "manageno" 속성 가져오기 전에 null 체크 추가
          Object managenoAttribute = session.getAttribute("manageno");
          if (managenoAttribute != null) {
           manageno = (int) managenoAttribute;

              ArrayList<MloginVO> list = this.mloginProc.list_mlogin(manageno);
              mav.addObject("list", list);
          } else {
              // "manageno" 속성이 null인 경우의 처리
              mav.addObject("error", "manageno 속성이 세션에 존재하지 않습니다.");
          }
      } else {
          mav.setViewName("manage/login_need");
      }

      return mav; // forward
  }
  /**
   * 삭제폼
   * http://localhost:9092/mlogin/delete.do
   * @return
   */
 @RequestMapping(value="/mlogin/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int mloginno) { 
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session)) {//관리자로 로그인할 경우
      mav.setViewName("/mlogin/list_all_delete");
          
      int cnt = this.mloginProc.delete(mloginno); // 카테고리 삭제
      
      ArrayList<MloginVO> list = this.mloginProc.list_all();
      mav.addObject("list", list);
          
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
   
    }
    
    return mav;
  }
  
  //삭제 처리
  /**
   * 카테고리 삭제
   * @param session
   * @param mloginno 삭제할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/mlogin/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(HttpSession session, int mloginno) { // <form> 태그의 값이 자동으로 저장됨
    
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {   
      ArrayList<MloginVO> list = this.mloginProc.list_mlogin(mloginno); // 자식 레코드 목록 읽기
      
      for(MloginVO mloginVO : list) { // 자식 레코드 관련 파일 삭제

      }
      int cnt = this.mloginProc.delete(mloginno); // 카테고리 삭제
      
      if (cnt == 1) {
        mav.setViewName("redirect:/mlogin/list_all.do");       // 자동 주소 이동, Spring 재호출
        
      } else {
        mav.addObject("code", "delete_fail");
        mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
      }
      
      mav.addObject("cnt", cnt);
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
    }
    
    return mav;
  } 
}