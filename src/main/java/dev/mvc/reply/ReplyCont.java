package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cfood.FoodVO;
import dev.mvc.clogin.CloginVO;
import dev.mvc.creates.CreatesVO;
import dev.mvc.crew.CrewProc;
import dev.mvc.manage.ManageProcInter;


@Controller
public class ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") 
  private ReplyProcInter replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.crew.CrewProc") 
  private CrewProc CrewProc;
  
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;
  
  public ReplyCont(){
    System.out.println("-> ReplyCont created.");
  }

  
  @RequestMapping(value="/reply/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    if (this.CrewProc.isCrew(session) == true) {
      mav.setViewName("/reply/create"); // /WEB-INF/views/reply/create.jsp
    } else {
      mav.setViewName("/crew/login_need");
    }
    return mav;
  }
  
  // 등록 처리
  @RequestMapping(value="/reply/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request,HttpSession session, ReplyVO replyVO) { // 자동으로 cateVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/reply/msg"); // /WEB-INF/views/reply/msg.jsp
    
   
    
    if (this.CrewProc.isCrew(session)) {  //로그인 확인    
      
      int crewno = (int)session.getAttribute("crewno");  //회원번호
      replyVO.setCrewno(crewno);

      if (replyVO.getId() == null) {
        String id = (String) session.getAttribute("id");
        replyVO.setId(id);
      }
      int cnt = this.replyProc.create(replyVO);
      
      if(cnt == 1) {
        mav.addObject("code", "create_success");       
      } else {
        mav.addObject("code", "create_fail");
      }
      
      mav.addObject("cnt", cnt);
      mav.addObject("createsno",replyVO.getCreatesno());  
    }  
    
    else {
        mav.setViewName("/crew/login_need"); // /WEB-INF/views/manager/login_need.jsp
        mav.setViewName("redirect:/crew/msg.do");
    }
      
       // request.setAttribute("cnt", cnt);
  //    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  
  // 목록
  @RequestMapping(value="/reply/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    if (this.CrewProc.isCrew(session)) {
      mav.setViewName("/reply/list_all"); // /WEB-INF/views/reply/list_all.jsp
  
      ArrayList<ReplyVO> list = this.replyProc.list();
      mav.addObject("list", list);

      
    } else {
      mav.setViewName("/crew/login_need"); 
    }
    return mav;
  }
  
//컨텐츠별 목록
  @ResponseBody
  @RequestMapping(value = "/reply/list_by_createsno.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_contentsno(int createsno) {
    
    ArrayList<ReplyVO> list = replyProc.list_by_createsno(createsno);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }
  
  /**
   * 삭제 처리
   * http://localhost:9092/reply/delete.do?replyno=1
   * @return
   */
  @RequestMapping(value="/reply/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int createsno, int replyno) { // int replyno = (int)request.getParameter("replyno");
    ModelAndView mav = new ModelAndView();
    
    System.out.println("->deletecall" );
    
    if (this.CrewProc.isCrew(session) == true) {
      this.replyProc.delete(replyno);
      
      mav.setViewName("redirect:/creates/read.do?createsno=" + createsno); // /WEB-INF/views/admin/login_need.jsp
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/admin/login_need.jsp
    }
    
    return mav;
  }


}