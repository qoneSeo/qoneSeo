package dev.mvc.cfood;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manage.ManageProcInter;
import dev.mvc.creates.Creates;
import dev.mvc.creates.CreatesProcInter;
import dev.mvc.creates.CreatesVO;
import dev.mvc.tool.Tool;

@Controller
public class FoodCont {
  @Autowired // FoodProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.cfood.FoodProc")
  private FoodProcInter FoodProc;

  @Autowired
  @Qualifier("dev.mvc.creates.CreatesProc") // "dev.mvc.creates.CreatesProc"라고 명명된 클래스
  private CreatesProcInter createsProc; // CreatesProcInter를 구현한 createsProc 클래스의 객체를 자동으로 생성하여 할당
  
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // "dev.mvc.manage.ManageProc"라고 명명된 클래스
  private ManageProcInter manageProc; // ManageProcInter를 구현한 manageProc 클래스의 객체를 자동으로 생성하여 할당
   
  public FoodCont() {
    System.out.println("-> FoodCont created.");  
  }

//  // FORM 출력, http://localhost:9092/cfood/create.do
//  @RequestMapping(value="/cfood/create.do", method = RequestMethod.GET)
//  @ResponseBody // 단순 문자열로 출력, jsp 파일명 조합이 발생하지 않음.
//  public String create() {
//    return "<h3>GET 방식 FORM 출력</h3>";
//  }

  // FORM 출력, http://localhost:9092/cfood/create.do
  @RequestMapping(value="/cfood/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cfood/create"); // /WEB-INF/views/cfood/create.jsp
    
    return mav;
  }
  
  // FORM 데이터 처리, http://localhost:9092/cfood/create.do
  @RequestMapping(value="/cfood/create.do", method = RequestMethod.POST)
  public ModelAndView create(FoodVO foodVO) { // 자동으로 FoodVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.create(foodVO);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      // mav.addObject("code", "create_success"); // 키, 값
      // mav.addObject("name", FoodVO.getName()); // 카테고리 이름 jsp로 전송
      mav.setViewName("redirect:/cfood/list_all.do"); // 주소 자동 이동
    } else {
      mav.addObject("code", "create_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9092/cfood/list_all.do
   * @return
   */
  @RequestMapping(value="/cfood/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      mav.setViewName("/cfood/list_all"); // /WEB-INF/views/cfood/list_all.jsp
      
      ArrayList<FoodVO> list = this.FoodProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      
    }
    
    return mav;
  }
  
  /**
   * 조회
   * http://localhost:9092/cfood/read.do?cfoodno=1
   * @return
   */
  @RequestMapping(value="/cfood/read.do", method = RequestMethod.GET)
  public ModelAndView read(int cfoodno) { // int cfoodno = (int)request.getParameter("cfoodno");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cfood/read"); // /WEB-INF/views/cfood/read.jsp
    
    FoodVO foodVO = this.FoodProc.read(cfoodno);
    mav.addObject("foodVO", foodVO);
    
    return mav;
  }

  /**
   * 수정폼
   * http://localhost:9092/cfood/update.do?cfoodno=1
   * @return
   */
  @RequestMapping(value="/cfood/update.do", method = RequestMethod.GET)
  public ModelAndView update(HttpSession session, int cfoodno) { // int cfoodno = (int)request.getParameter("cfoodno");
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      // mav.setViewName("/cfood/update"); // /WEB-INF/views/cfood/update.jsp
      mav.setViewName("/cfood/list_all_update"); // /WEB-INF/views/cfood/list_all_update.jsp
      
      FoodVO foodVO = this.FoodProc.read(cfoodno);
      mav.addObject("foodVO", foodVO);
      
      ArrayList<FoodVO> list = this.FoodProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      
    }
        
    return mav;
  }
  
  /**
   * 수정 처리, http://localhost:9092/cfood/update.do
   * @param FoodVO 수정할 내용
   * @return
   */
  @RequestMapping(value="/cfood/update.do", method = RequestMethod.POST)
  public ModelAndView update(FoodVO foodVO) { // 자동으로 FoodVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.update(foodVO); // 수정 처리
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      // mav.addObject("code", "update_success"); // 키, 값
      // mav.addObject("name", FoodVO.getName()); // 카테고리 이름 jsp로 전송
      mav.setViewName("redirect:/cfood/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 삭제폼
   * http://localhost:9092/cfood/delete.do?cfoodno=1
   * @return
   */
  @RequestMapping(value="/cfood/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int cfoodno) { // int cfoodno = (int)request.getParameter("cfoodno");
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      // mav.setViewName("/cfood/delete"); // /WEB-INF/views/cfood/delete.jsp
      mav.setViewName("/cfood/list_all_delete"); // /WEB-INF/views/cfood/list_all_delete.jsp
      
      FoodVO foodVO = this.FoodProc.read(cfoodno);
      mav.addObject("FoodVO", foodVO);
      
      ArrayList<FoodVO> list = this.FoodProc.list_all();
      mav.addObject("list", list);
      
   // 특정 카테고리에 속한 레코드 갯수를 리턴
      int count_by_cfoodno = this.createsProc.count_by_cfoodno(cfoodno);
      mav.addObject("count_by_cfoodno", count_by_cfoodno);
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
   
    }
    
    return mav;
  }
  
  // 삭제 처리, 수정 처리를 복사하여 개발
  // 자식 테이블 레코드 삭제 -> 부모 테이블 레코드 삭제
  /**
   * 카테고리 삭제
   * @param session
   * @param cfoodno 삭제할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/cfood/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(HttpSession session, int cfoodno) { // <form> 태그의 값이 자동으로 저장됨
//    System.out.println("-> cfoodno: " + foodVO.getCfoodno());
//    System.out.println("-> name: " + foodVO.getName());
    
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      ArrayList<CreatesVO> list = this.createsProc.list_by_cfoodno(cfoodno); // 자식 레코드 목록 읽기
      
      for(CreatesVO createsVO : list) { // 자식 레코드 관련 파일 삭제
        // -------------------------------------------------------------------
        // 파일 삭제 시작
        // -------------------------------------------------------------------
        String file1saved = createsVO.getFile1saved();
        String thumb1 = createsVO.getThumb1();
        
        String uploadDir = Creates.getUploadDir();
        Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
        Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
        // -------------------------------------------------------------------
        // 파일 삭제 종료
        // -------------------------------------------------------------------
      }
      
      this.createsProc.delete_by_cfoodno(cfoodno); // 자식 레코드 삭제     
            
      int cnt = this.FoodProc.delete(cfoodno); // 카테고리 삭제
      
      if (cnt == 1) {
        mav.setViewName("redirect:/cfood/list_all.do");       // 자동 주소 이동, Spring 재호출
        
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
  
  /**
   * 우선 순위 높임, 10 등 -> 1 등, http://localhost:9092/cfood/update_seqno_forward.do?cfoodno=1
   * @param FoodVO 수정할 내용
   * @return
   */
  @RequestMapping(value="/cfood/update_seqno_forward.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_forward(int cfoodno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.update_seqno_forward(cfoodno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/cfood/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 우선 순위 낮춤, 1 등 -> 10 등, http://localhost:9092/cfood/update_seqno_backward.do?cfoodno=1
   * @param cfoodno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/cfood/update_seqno_backward.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_backward(int cfoodno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.update_seqno_backward(cfoodno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/cfood/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 카테고리 공개 설정, http://localhost:9092/cfood/update_visible_y.do?cfoodno=1
   * @param cfoodno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/cfood/update_visible_y.do", method = RequestMethod.GET)
  public ModelAndView update_visible_y(int cfoodno) { 
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.update_visible_y(cfoodno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/cfood/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 카테고리 비공개 설정, http://localhost:9092/cfood/update_visible_n.do?cfoodno=1
   * @param cfoodno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/cfood/update_visible_n.do", method = RequestMethod.GET)
  public ModelAndView update_visible_n(int cfoodno) { 
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.FoodProc.update_visible_n(cfoodno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/cfood/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/cfood/msg"); // /WEB-INF/views/cfood/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
}
