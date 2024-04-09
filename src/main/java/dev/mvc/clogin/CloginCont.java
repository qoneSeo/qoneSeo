package dev.mvc.clogin;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import dev.mvc.crew.CrewProcInter;
import dev.mvc.manage.ManageProcInter;


@Controller
public class CloginCont {
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;

  @Autowired
  @Qualifier("dev.mvc.crew.CrewProc")
  private CrewProcInter CrewProc;
  
  @Autowired
  @Qualifier("dev.mvc.clogin.CloginProc")
  private CloginProcInter cloginProc;
  
  public CloginCont(){
    System.out.println("-> CloginCont created.");
  }
 
  /**
   * 로그인 내역
   * // FORM 데이터 처리 http://localhost:9092/clogin/list_all.do
   * @return
   */
  @RequestMapping(value="/clogin/list_all.do",method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.manageProc.isManage(session)) {
      mav.setViewName("/clogin/list_all");// /WEB-INF/views/clogin/list_all.jsp
      
      ArrayList<CloginVO> list = this.cloginProc.list_all();
      mav.addObject("list",list);
    }
    else {
      mav.setViewName("/crew/login_need");// /webapp/WEB-INF/views/crew/login_need.jsp
    }
    return mav;
  }
  
  //http://localhost:9092/clogin/list_by_clogin.do
  /**
   * 회원별 로그인 내역 조회 목록
   */
  @RequestMapping(value="/clogin/list_by_clogin.do", method=RequestMethod.GET)
  public ModelAndView list_clogin(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      int crewno = 0;

      if(this.CrewProc.isCrew(session) == true) {
          mav.setViewName("/clogin/list_by_clogin"); // /WEB-INF/views/clogin/list_by_clogin.jsp
          
          // "crewno" 속성 가져오기 전에 null 체크 추가
          Object crewnoAttribute = session.getAttribute("crewno");
          if (crewnoAttribute != null) {
              crewno = (int) crewnoAttribute;

              ArrayList<CloginVO> list = this.cloginProc.list_clogin(crewno);
              mav.addObject("list", list);
          } else {
              // "crewno" 속성이 null인 경우의 처리
              mav.addObject("error", "crewno 속성이 세션에 존재하지 않습니다.");
          }
      } else {
          mav.setViewName("crew/login_need");
      }

      return mav; // forward
  }
  /**
   * 삭제폼
   * http://localhost:9092/clogin/delete.do
   * @return
   */
 @RequestMapping(value="/clogin/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int cloginno) { 
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session)) {//관리자로 로그인할 경우
      mav.setViewName("/clogin/list_all_delete");
      
     /** CloginVO cloginVO = this.cloginProc.read(cloginno);
      mav.addObject("cloginVO", cloginVO);*/
     
      int cnt = this.cloginProc.delete(cloginno); // 카테고리 삭제
      
      ArrayList<CloginVO> list = this.cloginProc.list_all();
      mav.addObject("list", list);
      
      
      
   // 특정 카테고리에 속한 레코드 갯수를 리턴
    /**  int count_by_cloginno = this.cloginProc.count_by_cloginno(cloginno);
      mav.addObject("count_by_cfoodno", count_by_cloginno); */
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
   
    }
    
    return mav;
  }
  
  //삭제 처리
  /**
   * 카테고리 삭제
   * @param session
   * @param cloginno 삭제할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/clogin/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(HttpSession session, int cloginno) { // <form> 태그의 값이 자동으로 저장됨
    
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {   
      ArrayList<CloginVO> list = this.cloginProc.list_clogin(cloginno); // 자식 레코드 목록 읽기
      
      for(CloginVO cloginVO : list) { // 자식 레코드 관련 파일 삭제

      }
      int cnt = this.cloginProc.delete(cloginno); // 카테고리 삭제
      
      if (cnt == 1) {
        mav.setViewName("redirect:/clogin/list_all.do");       // 자동 주소 이동, Spring 재호출
        
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