package dev.mvc.crew;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import dev.mvc.clogin.CloginProc;
import dev.mvc.clogin.CloginProcInter;
import dev.mvc.clogin.CloginVO;
import dev.mvc.manage.ManageProcInter;
 
@Controller
public class CrewCont {
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;

  @Autowired
  @Qualifier("dev.mvc.crew.CrewProc")
  private CrewProcInter crewProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.clogin.CloginProc")
  private CloginProcInter cloginProc = null; 
  
  public CrewCont(){
    System.out.println("-> CrewCont created.");
  }
  
  // http://localhost:9092/crew/checkID.do?id=user1@gmail.com
  /**
  * ID 중복 체크, JSON 출력
  * @return {"cnt":0}, {"cnt":1}
  */
  @ResponseBody
  @RequestMapping(value="/crew/checkID.do", 
                              method=RequestMethod.GET ,
                              produces = "text/plain;charset=UTF-8" )
  public String checkID(String id) {
    System.out.println("-> id: " + id);
    
    try {
      Thread.sleep(3000); // 3 초 지연
    }catch(Exception e) {
      
    }
    
    int cnt = this.crewProc.checkID(id);
   
    JSONObject json = new JSONObject();
    json.put("cnt", cnt); // 키와 값 = HashMap
   
    return json.toString(); // {"cnt":1} 
  }

  // http://localhost:9092/crew/create.do
  /**
  * 등록 폼
  * @return
  */
  @RequestMapping(value="/crew/create.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/crew/create"); // /WEB-INF/views/crew/create.jsp
   
    return mav; // forward
  }

  /**
   * 등록 처리
   * @param crewVO
   * @return
   */
  @RequestMapping(value="/crew/create.do", method=RequestMethod.POST)
  public ModelAndView create(CrewVO crewVO){
    ModelAndView mav = new ModelAndView();
    
    // 중복 ID 검사
    int checkID_cnt = this.crewProc.checkID(crewVO.getId());
    if (checkID_cnt == 0) {
      // System.out.println("id: " + crewVO.getId());
      
      crewVO.setGrade(15); // 기본 회원 가입 등록 15 지정
      
      int cnt= crewProc.create(crewVO); // SQL insert
      
      if (cnt == 1) { // insert 레코드 개수, 회원 가입 성공
        mav.addObject("code", "create_success");
        mav.addObject("mname", crewVO.getMname());  // 홍길동님(user4) 회원 가입을 축하합니다.
        mav.addObject("id", crewVO.getId());
      } else { // 회원 가입 실패
        mav.addObject("code", "create_fail");
        // mav.addObject("cnt", 0);  // 추가된 레코드 없음.  
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.addObject("code", "duplicate_fail"); // 이미 사용중인 id임으로 가입 실패
      mav.addObject("cnt", 0);                       // 추가된 레코드 없음.      
    }

    mav.addObject("url", "/crew/msg");  // /crew/msg -> /crew/msg.jsp
    
    mav.setViewName("redirect:/crew/msg.do"); // POST -> GET -> /crew/msg.jsp
    
    return mav;
  }
  
  /**
   * 새로고침 방지, EL에서 param으로 접근, POST -> GET -> /crew/msg.jsp
   * @return
   */
  @RequestMapping(value="/crew/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
  * 목록 출력 가능
  * @param session
  * @return
  */
  @RequestMapping(value="/crew/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      ArrayList<CrewVO> list = this.crewProc.list();
      mav.addObject("list", list);

      mav.setViewName("/crew/list"); // /webapp/WEB-INF/views/crew/list.jsp

    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
    }
        
    return mav;
  } 
  
  /**
   * 회원 조회
   * http://localhost:9092/crew/read.do?crewno=1
   * 관리자, 회원 본인만 가능
   * @param crewno
   * @return
   */
  @RequestMapping(value="/crew/read.do", method=RequestMethod.GET)
  public ModelAndView read(HttpSession session, HttpServletRequest request){
    ModelAndView mav = new ModelAndView();
    
    int crewno = 0;
    if (this.crewProc.isCrew(session) || this.manageProc.isManage(session)) { 
      // 로그인한 경우

      if (this.crewProc.isCrew(session)) { // 회원으로 로그인
        // session을 사용하여 현재 로그인한 사용자의 crewno 값만 읽음으로 다른 사용자의 
        // 정보를 조회 할 수 없음.
        crewno = (int)session.getAttribute("crewno");
        
      } else if (this.manageProc.isManage(session)) { // 관리자로 로그인
        // 관리자는 모든 회원의 정보를 조회 할 수 있어야함으로 parameter로 회원번호를 이용하여 조회
        crewno = Integer.parseInt(request.getParameter("crewno"));
        
      }

      CrewVO crewVO = this.crewProc.read(crewno);
      mav.addObject("crewVO", crewVO);
      mav.setViewName("/crew/read"); // /crew/read.jsp
      
    } else {
      // 로그인을 하지 않은 경우
      mav.setViewName("/crew/login_need"); // /webapp/WEB-INF/views/crew/login_need.jsp
    }
    
    return mav; // forward
  }
  
  /**
   * 회원 정보 수정 처리
   * @param crewVO
   * @return
   */
  @RequestMapping(value="/crew/update.do", method=RequestMethod.POST)
  public ModelAndView update(CrewVO crewVO){
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("id: " + crewVO.getId());
    
    int cnt= this.crewProc.update(crewVO);
    
    if (cnt == 1) {
      mav.addObject("code", "update_success");
      mav.addObject("mname", crewVO.getMname());  // 홍길동님(user4) 회원 정보를 변경했습니다.
      mav.addObject("id", crewVO.getId());
    } else {
      mav.addObject("code", "update_fail");
    }

    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
    mav.addObject("url", "/crew/msg");  // /crew/msg -> /crew/msg.jsp
    
    mav.setViewName("redirect:/crew/msg.do");
    
    return mav;
  }
  
  /**
   * 회원 삭제
   * @param crewno
   * @return
   */
  @RequestMapping(value="/crew/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int crewno){
    ModelAndView mav = new ModelAndView();
    
    CrewVO crewVO = this.crewProc.read(crewno); // 삭제할 레코드를 사용자에게 출력하기위해 읽음.
    mav.addObject("crewVO", crewVO);
    
    mav.setViewName("/crew/delete"); // /crew/delete.jsp
    
    return mav; // forward
  }
 
  /**
   * 회원 삭제 처리
   * @param crewVO
   * @return
   */
  @RequestMapping(value="/crew/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(int crewno){
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("id: " + crewVO.getId());
    // 삭제된 정보를 msg.jsp에 출력하기 위해, 삭제전에 회원 정보를 읽음.
    CrewVO crewVO = this.crewProc.read(crewno); 
    
    int cnt= this.crewProc.delete(crewno);

    if (cnt == 1) {
      mav.addObject("code", "delete_success");
      mav.addObject("mname", crewVO.getMname());  // 홍길동님(user4) 회원 정보를 삭제했습니다.
      mav.addObject("id", crewVO.getId());
    } else {
      mav.addObject("code", "delete_fail");
    }

    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
    mav.addObject("url", "/crew/msg");  // /crew/msg -> /crew/msg.jsp
    
    mav.setViewName("redirect:/crew/msg.do");
    
    return mav;
  }

//  /**
//   * 로그인 폼
//   * @return
//   */
//  // http://localhost:9092/crew/login.do 
//  @RequestMapping(value = "/crew/login.do", 
//                             method = RequestMethod.GET)
//  public ModelAndView login() {
//    ModelAndView mav = new ModelAndView();
//  
//    mav.setViewName("/crew/login_form");
//    return mav;
//  }
//
//  /**
//   * 로그인 처리
//   * @return
//   */
//  // http://localhost:9092/crew/login.do 
//  @RequestMapping(value = "/crew/login.do", 
//                             method = RequestMethod.POST)
//  public ModelAndView login_proc(HttpSession session,
//                                                   String id, 
//                                                   String passwd) {
//    ModelAndView mav = new ModelAndView();
//    HashMap<String, Object> map = new HashMap<String, Object>();
//    map.put("id", id);
//    map.put("passwd", passwd);
//    
//    int count = this.crewProc.login(map); // id, passwd 일치 여부 확인
//    if (count == 1) { // 로그인 성공
//      // System.out.println(id + " 로그인 성공");
//      crewVO crewVO = crewProc.readById(id); // 로그인한 회원의 정보 조회
//      session.setAttribute("crewno", crewVO.getCrewrno());
//      session.setAttribute("id", id);
//      session.setAttribute("mname", crewVO.getMname());
//      session.setAttribute("grade", crewVO.getGrade());
//      
//      mav.setViewName("redirect:/index.do"); // 시작 페이지로 이동  
//    } else {
//      mav.addObject("url", "/crew/login_fail_msg"); // login_fail_msg.jsp, redirect parameter 적용
//     
//      mav.setViewName("redirect:/crew/msg.do"); // 새로고침 방지
//    }
//        
//    return mav;
//  }

  /**
   * 로그아웃 처리
   * @param session
   * @return
   */
  @RequestMapping(value="/crew/logout.do", 
                             method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // 모든 session 변수 삭제
    
    mav.setViewName("redirect:/index.do"); 
    
    return mav;
  }

  /**
   * 로그인 폼
   * @return
   */
  // http://localhost:9092/crew/login.do 
  @RequestMapping(value = "/crew/login.do", 
                             method = RequestMethod.GET)
  public ModelAndView login_cookie(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;
  
    String ck_id = ""; // id 저장
    String ck_id_save = ""; // id 저장 여부를 체크
    String ck_passwd = ""; // passwd 저장
    String ck_passwd_save = ""; // passwd 저장 여부를 체크
  
    
    if (cookies != null) { // 쿠키가 존재한다면
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 쿠키 객체 추출
      
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue(); 
        }else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();  // Y, N
        }else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();         // 1234
        }else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();  // Y, N
        }
      }
    }
  
    //    <input type='text' class="form-control" name='id' id='id' 
    //            value='${ck_id }' required="required" 
    //            style='width: 30%;' placeholder="아이디" autofocus="autofocus">
    mav.addObject("ck_id", ck_id);
  
    //    <input type='checkbox' name='id_save' value='Y' 
    //            ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
    mav.addObject("ck_id_save", ck_id_save);
  
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);
  
    mav.setViewName("/crew/login_form_ck"); // /crew/login_form_ck.jsp
    return mav;
  }
  
  
  /**
  * Cookie 기반 로그인 처리
  * @param request Cookie를 읽기위해 필요
  * @param response Cookie를 쓰기위해 필요
  * @param session 로그인 정보를 메모리에 기록
  * @param id  회원 아이디
  * @param passwd 회원 패스워드
  * @param id_save 회원 아이디 Cookie에 저장 여부
  * @param passwd_save 패스워드 Cookie에 저장 여부
  * @return
  */
  // http://localhost:9092/crew/login.do 
  @RequestMapping(value = "/crew/login.do", 
                            method = RequestMethod.POST)
  public ModelAndView login_cookie_proc(
                            HttpServletRequest request,
                            HttpServletResponse response,
                            HttpSession session,
                            String id,
                            String passwd,
                            @RequestParam(value="id_save", defaultValue="") String id_save,
                            @RequestParam(value="passwd_save", defaultValue="") String passwd_save) {
    ModelAndView mav = new ModelAndView();
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
   


    
    int cnt = crewProc.login(map);
    if (cnt == 1) { // 로그인 성공
      // System.out.println(id + " 로그인 성공");
      CrewVO crewVO = crewProc.readById(id);
      session.setAttribute("crewno", crewVO.getcrewno()); // 서버의 메모리에 기록
      session.setAttribute("id", id);
      session.setAttribute("mname", crewVO.getMname());
      session.setAttribute("grade", crewVO.getGrade());

      //ip
      String ip=request.getRemoteAddr();
      
      //로그인 내역 호출
      CloginVO cloginVO = new CloginVO();
      cloginVO.setCrewno(crewVO.getcrewno());
      cloginVO.setIp(ip);
      
      cloginProc.create(cloginVO);
      
      // -------------------------------------------------------------------
      // id 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (id_save.equals("Y")) { // id를 저장할 경우, Checkbox를 체크한 경우
        Cookie ck_id = new Cookie("ck_id", id);
        ck_id.setPath("/");  // root 폴더에 쿠키를 기록함으로 모든 경로에서 쿠기 접근 가능
        ck_id.setMaxAge(60 * 60 * 24 * 30); // 30 day, 초단위
        response.addCookie(ck_id); // id 저장
      } else { // N, id를 저장하지 않는 경우, Checkbox를 체크 해제한 경우
        Cookie ck_id = new Cookie("ck_id", "");
        ck_id.setPath("/");
        ck_id.setMaxAge(0);
        response.addCookie(ck_id); // id 저장
      }
      
      // id를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_id_save = new Cookie("ck_id_save", id_save);
      ck_id_save.setPath("/");
      ck_id_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_id_save);
      // -------------------------------------------------------------------
  
      // -------------------------------------------------------------------
      // Password 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
        Cookie ck_passwd = new Cookie("ck_passwd", passwd);
        ck_passwd.setPath("/");
        ck_passwd.setMaxAge(60 * 60 * 24 * 30); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, 패스워드를 저장하지 않을 경우
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setPath("/");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setPath("/");
      ck_passwd_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------
   
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.addObject("url", "/crew/login_fail_msg");
      mav.setViewName("redirect:/crew/msg.do"); 
    }
       
    return mav;
  }
      
  /**
   * 패스워드를 변경합니다.
   * http://localhost:9092/crew/passwd_update.do
   * @param crewno
   * @return
   */
  @RequestMapping(value="/crew/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/crew/passwd_update"); // passwd_update.jsp
    
    return mav;
  }
  
  /**
   * 패스워드 검사 
   * 로그인 실행 -> http://localhost:9092/crew/passwd_check.do?current_passwd=1234
   * @param session
   * @param current_passwd 현재 패스워드
   * @return 1: 일치, 0: 불일치
   */
  @ResponseBody
  @RequestMapping(value="/crew/passwd_check.do", method=RequestMethod.GET)
  public String passwd_check(HttpSession session, String current_passwd) {
    try {
      Thread.sleep(3000); // 3초
    } catch(Exception e) {

    }
    
    int crewno = (int)session.getAttribute("crewno");
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("crewno", crewno);
    map.put("passwd", current_passwd);
    int cnt = this.crewProc.passwd_check(map);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  
  /**
   * 패스워드 변경 처리
   * @param crewno 회원 번호
   * @param current_passwd 현재 패스워드
   * @param new_passwd 새로운 패스워드
   * @return
   */
  @RequestMapping(value="/crew/passwd_update.do", method=RequestMethod.POST)
  public ModelAndView passwd_update(HttpSession session, String current_passwd, String new_passwd){
    ModelAndView mav = new ModelAndView();
    
 // int crewno = 3; // 테스트
    int crewno = (int)session.getAttribute("crewno"); // 현재 로그인한 회원의 정보만 패스워드 변경 가능

    CrewVO crewVO = this.crewProc.read(crewno); // 패스워드를 변경하려는 회원 정보를 읽음
    mav.addObject("mname", crewVO.getMname());  
    mav.addObject("id", crewVO.getId());
    
    // 현재 패스워드 검사용 데이터
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("crewno", crewno);
    map.put("passwd", current_passwd);
    
    int cnt = crewProc.passwd_check(map); // 현재 패스워드 검사
    int update_cnt = 0; // 변경된 패스워드 수
    
    if (cnt == 1) { // 현재 패스워드가 일치하는 경우
      map.put("passwd", new_passwd); // 새로운 패스워드를 저장
      update_cnt = this.crewProc.passwd_update(map); // 패스워드 변경 처리
      
      if (update_cnt == 1) {
        mav.addObject("code", "passwd_update_success"); // 패스워드 변경 성공
      } else {
        cnt = 0;  // 패스워드는 일치했으나 변경하지는 못함.
        mav.addObject("code", "passwd_update_fail");       // 패스워드 변경 실패
      }
      
      mav.addObject("update_cnt", update_cnt);  // 변경된 패스워드의 갯수    
    } else {
      mav.addObject("code", "passwd_fail"); // 패스워드가 일치하지 않는 경우
    }

    mav.addObject("cnt", cnt); // 패스워드 일치 여부
    mav.addObject("url", "/crew/msg");  // /crew/msg -> /crew/msg.jsp
    
    mav.setViewName("redirect:/crew/msg.do");
    
    return mav;
  }
  
  
}

