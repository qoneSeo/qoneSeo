package dev.mvc.creates;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manage.ManageProcInter;
import dev.mvc.reply.ReplyVO;
import dev.mvc.reply.ReplyProcInter;
import dev.mvc.cfood.FoodProcInter;
import dev.mvc.cfood.FoodVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class CreatesCont {
  @Autowired
  @Qualifier("dev.mvc.manage.ManageProc") // @Component("dev.mvc.manage.ManageProc")
  private ManageProcInter manageProc;
  
  @Autowired
  @Qualifier("dev.mvc.cfood.FoodProc")  // @Component("dev.mvc.cfood.FoodProc")
  private FoodProcInter foodProc;
  
  @Autowired
  @Qualifier("dev.mvc.creates.CreatesProc") // @Component("dev.mvc.creates.CreatesProc")
  private CreatesProcInter createsProc;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") // @Component("dev.mvc.creates.CreatesProc")
  private ReplyProcInter replyProc;
  
  public CreatesCont () {
    System.out.println("-> CreatesCont created.");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/creates/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  // 등록 폼, creates 테이블은 FK로 cfoodno를 사용함.
  // http://localhost:9092/creates/create.do  X
  // http://localhost:9092/creates/create.do?cfoodno=1  // cfoodno 변수값을 보내는 목적
  // http://localhost:9092/creates/create.do?cfoodno=2
  // http://localhost:9092/creates/create.do?cfoodno=3
  @RequestMapping(value="/creates/create.do", method = RequestMethod.GET)
  public ModelAndView create(int cfoodno) {
//  public ModelAndView create(HttpServletRequest request,  int cfoodno) {
    ModelAndView mav = new ModelAndView();

    FoodVO foodVO = this.foodProc.read(cfoodno); // create.jsp에 카테고리 정보를 출력하기위한 목적
    mav.addObject("foodVO", foodVO);
//    request.setAttribute("foodVO", foodVO);
    
    mav.setViewName("/creates/create"); // /webapp/WEB-INF/views/creates/create.jsp
    
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9092/creates/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/creates/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, CreatesVO createsVO) {
    ModelAndView mav = new ModelAndView();
    
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      String upDir =  Creates.getUploadDir(); // 파일을 업로드할 폴더 준비
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = createsVO.getFile1MF();
      
      file1 = mf.getOriginalFilename(); // 원본 파일명 산출, 01.jpg
      System.out.println("-> 원본 파일명 산출 file1: " + file1);
      
      if (Tool.checkUploadFile(file1) == true) { // 업로드 가능한 파일인지 검사 
        long size1 = mf.getSize();  // 파일 크기
      
      if (size1 > 0) { // 파일 크기 체크
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
        }
        
      }    
      
      createsVO.setFile1(file1);   // 순수 원본 파일명
      createsVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      createsVO.setThumb1(thumb1);      // 원본이미지 축소판
      createsVO.setSize1(size1);  // 파일 크기
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int manageno = (int)session.getAttribute("manageno"); // manageno FK
      createsVO.setManageno(manageno);
      int cnt = this.createsProc.create(createsVO); 
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> createsno: " + createsVO.getCreatesno());
      // mav.addObject("createsno", createsVO.getCreatesno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------
      
      if (cnt == 1) {
          mav.addObject("code", "create_success");
          // foodProc.increaseCnt(createsVO.getCfoodno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
      // System.out.println("--> cfoodno: " + createsVO.getCfoodno());
      // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
      mav.addObject("cfoodno", createsVO.getCfoodno()); // redirect parameter 적용
      
      mav.addObject("url", "/creates/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/creates/msg.do"); // Post -> Get - param...
    } else {
      mav.addObject("cnt", "0"); // 업로드 할 수 없는 파일
      mav.addObject("code", "check_upload_file_fail"); // 업로드 할 수 없는 파일
      mav.addObject("url", "/creates/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/creates/msg.do"); // Post -> Get - param... 
    }
   }  else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }
    
    return mav; // forward
  }

  /**
   * 전체 목록, 관리자만 사용 가능
   * http://localhost:9092/creates/list_all.do
   * @return
   */
  @RequestMapping(value="/creates/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session) == true) {
      mav.setViewName("/creates/list_all"); // /WEB-INF/views/creates/list_all.jsp
      
      ArrayList<CreatesVO> list = this.createsProc.list_all();
     
      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
      for (CreatesVO createsVO : list) {
        String title = createsVO.getTitle();
        String content = createsVO.getContent();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
        content = Tool.convertChar(content); 
        
        createsVO.setTitle(title);
        createsVO.setContent(content);  

      }
      
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      
    }
    
    return mav;
  }
  
//  /**
//   * 특정 카테고리의 검색 목록
//   * http://localhost:9092/creates/list_by_cfoodno.do?cfoodno=1
//   * @return
//   */
//  @RequestMapping(value="/creates/list_by_cfoodno.do", method = RequestMethod.GET)
//  public ModelAndView list_by_cfoodno(int cfoodno, String word) {
//    ModelAndView mav = new ModelAndView();
//
//    mav.setViewName("/creates/list_by_cfoodno"); // /WEB-INF/views/creates/list_by_cfoodno.jsp
//    
//    FoodVO foodVO = this.foodProc.read(cfoodno); // create.jsp에 카테고리 정보를 출력하기위한 목적
//    mav.addObject("foodVO", foodVO);
//    // request.setAttribute("foodVO", foodVO);
//    
//    // 검색하지 않는 경우
//    // ArrayList<CreatesVO> list = this.createsProc.list_by_cfoodno(cfoodno);
//
//    // 검색하는 경우
//    HashMap<String, Object> hashMap = new HashMap<String, Object>();
//    hashMap.put("cfoodno", cfoodno);
//    hashMap.put("word", word);
//    
//    ArrayList<CreatesVO> list = this.createsProc.list_by_cfoodno_search(hashMap);
//    
//    // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
//    for (CreatesVO createsVO : list) {
//      String title = createsVO.getTitle();
//      String content = createsVO.getContent();
//      
//      title = Tool.convertChar(title);  // 특수 문자 처리
//      content = Tool.convertChar(content); 
//      
//      createsVO.setTitle(title);
//      createsVO.setContent(content);  
//
//    }
//    
//    mav.addObject("list", list);
//    
//    return mav;
//  }  
  
  /**
  * 목록 + 검색 + 페이징 지원
   * 검색하지 않는 경우
   * http://localhost:9092/creates/list_by_cfoodno.do?cfoodno=2&now_page=1
   * 검색하는 경우
   * http://localhost:9092/creates/list_by_cfoodno.do?cfoodno=2&now_page=1
   * 
  * @param cfoodno
  * @param word
  * @param now_page
  * @return
  */
 @RequestMapping(value = "/creates/list_by_cfoodno.do", method = RequestMethod.GET)
 public ModelAndView list_by_cfoodno(CreatesVO createsVO) {
   ModelAndView mav = new ModelAndView();
 
   // 검색 목록
   ArrayList<CreatesVO> list = createsProc.list_by_cfoodno_search_paging(createsVO);
   
   // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
   for (CreatesVO vo : list) {
     String title = vo.getTitle();
     String content = vo.getContent();
     
     title = Tool.convertChar(title);  // 특수 문자 처리
     content = Tool.convertChar(content); 
     
     vo.setTitle(title);
     vo.setContent(content);  
 
   }
   
   mav.addObject("list", list);
 
   FoodVO foodVO = foodProc.read(createsVO.getCfoodno());
   mav.addObject("foodVO", foodVO);

   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   hashMap.put("cfoodno", createsVO.getCfoodno());
   hashMap.put("word", createsVO.getWord());
   
   int search_count = this.createsProc.search_count(hashMap);  // 검색된 레코드 갯수 ->  전체 페이지 규모 파악
   mav.addObject("search_count", search_count);   
  
   /*
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
    * 18 19 20 [다음]
     * @param cfoodno 카테고리번호
     * @param now_page 현재 페이지
     * @param word 검색어
     * @param list_file 목록 파일명
     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
    */
   String paging = createsProc.pagingBox(createsVO.getCfoodno(), createsVO.getNow_page(), createsVO.getWord(), "list_by_cfoodno.do", search_count);
   mav.addObject("paging", paging);
 
   // mav.addObject("now_page", now_page);
   
   mav.setViewName("/creates/list_by_cfoodno");  // /creates/list_by_cfoodno.jsp
   
   return mav;
 } 
 
 /**
 * 목록 + 검색 + 페이징 지원 + Grid
 * 검색하지 않는 경우
 * http://localhost:9092/creates/list_by_cfoodno_grid.do?cfoodno=2&word=&now_page=1
 * 검색하는 경우
 * http://localhost:9092/creates/list_by_cfoodno_grid.do?cfoodno=2&word=탐험&now_page=1
 * 
 * @param cfoodno
 * @param word
 * @param now_page
 * @return
 */
 @RequestMapping(value = "/creates/list_by_cfoodno_grid.do", method = RequestMethod.GET)
 public ModelAndView list_by_cfoodno_grid(CreatesVO createsVO) {
    ModelAndView mav = new ModelAndView();
  
    // 검색 목록
  ArrayList<CreatesVO> list = createsProc.list_by_cfoodno_search_paging(createsVO);
  
  // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
  for (CreatesVO vo : list) {
    String title = vo.getTitle();
    String content = vo.getContent();
    
    title = Tool.convertChar(title);  // 특수 문자 처리
      content = Tool.convertChar(content); 
      
      vo.setTitle(title);
      vo.setContent(content);  
  
    }
  
  mav.addObject("list", list);
  
  FoodVO foodVO = foodProc.read(createsVO.getCfoodno());
  mav.addObject("foodVO", foodVO);
  
  HashMap<String, Object> hashMap = new HashMap<String, Object>();
  hashMap.put("cfoodno", createsVO.getCfoodno());
  hashMap.put("word", createsVO.getWord());
  
  int search_count = this.createsProc.search_count(hashMap);  // 검색된 레코드 갯수 ->  전체 페이지 규모 파악
  mav.addObject("search_count", search_count);

    /*
 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
 * 18 19 20 [다음]
 * @param cfoodno 카테고리번호
 * @param now_page 현재 페이지
 * @param word 검색어
 * @param list_file 목록 파일명
 * @return 페이징용으로 생성된 HTML/CSS tag 문자열
 */
  String paging = createsProc.pagingBox(createsVO.getCfoodno(), createsVO.getNow_page(), createsVO.getWord(), "list_by_cfoodno_grid.do", search_count);
  mav.addObject("paging", paging);
  
    // mav.addObject("now_page", now_page);
  
  mav.setViewName("/creates/list_by_cfoodno_grid");  // /creates/list_by_cfoodno_grid.jsp
  
    return mav;
  }   
 
 
  /**
   * 조회
   * http://localhost:9092/creates/read.do?createsno=17
   * @return
   */
  @RequestMapping(value="/creates/read.do", method = RequestMethod.GET)
  public ModelAndView read_ajax(HttpServletRequest request, int createsno)  { // int cfoodno = (int)request.getParameter("cfoodno");
    // public ModelAndView read(int createsno) {
    ModelAndView mav = new ModelAndView();
    
    CreatesVO createsVO = this.createsProc.read(createsno);
    mav.addObject("createsVO", createsVO);
    
    FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno());
    mav.addObject("foodVO", foodVO); 
    
    // 댓글 기능 추가 
    mav.setViewName("/creates/read"); // /WEB-INF/views/creates/read.jsp
    
    String title = createsVO.getTitle();
    String content = createsVO.getContent();
    
    title = Tool.convertChar(title);  // 특수 문자 처리
    content = Tool.convertChar(content); 
    
    createsVO.setTitle(title);
    createsVO.setContent(content);  
    
    long size1 = createsVO.getSize1();
    String size1_label = Tool.unit(size1);
    createsVO.setSize1_label(size1_label);
    
    mav.addObject("createsVO", createsVO);
    
    ArrayList<ReplyVO> list = this.replyProc.list_by_createsno(createsno);
    mav.addObject("list",  list);
    
    return mav;
  }
  
  /**
   * 맵 등록/수정/삭제 폼
   * http://localhost:9092/creates/map.do?createsno=1
   * @return
   */
  @RequestMapping(value="/creates/map.do", method=RequestMethod.GET )
  public ModelAndView map(int createsno) {
    ModelAndView mav = new ModelAndView();

    CreatesVO createsVO = this.createsProc.read(createsno); // map 정보 읽어 오기
    mav.addObject("createsVO", createsVO); // request.setAttribute("createsVO", createsVO);

    FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno()); // 그룹 정보 읽기
    mav.addObject("foodVO", foodVO); 

    mav.setViewName("/creates/map"); // /WEB-INF/views/creates/map.jsp
        
    return mav;
  }
  
  /**
   * MAP 등록/수정/삭제 처리
   * http://localhost:9092/creates/map.do
   * @param createsVO
   * @return
   */
  @RequestMapping(value="/creates/map.do", method = RequestMethod.POST)
  public ModelAndView map_update(int createsno, String map) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("createsno", createsno);
    hashMap.put("map", map);
    
    this.createsProc.map(hashMap);
    
    mav.setViewName("redirect:/creates/read.do?createsno=" + createsno); 
    // /webapp/WEB-INF/views/creates/read.jsp
    
    return mav;
  }

  /**
   * Youtube 등록/수정/삭제 폼
   * http://localhost:9092/creates/map.do?createsno=1
   * @return
   */
  @RequestMapping(value="/creates/youtube.do", method=RequestMethod.GET )
  public ModelAndView youtube(int createsno) {
    ModelAndView mav = new ModelAndView();

    CreatesVO createsVO = this.createsProc.read(createsno); // map 정보 읽어 오기
    mav.addObject("createsVO", createsVO); // request.setAttribute("createsVO", createsVO);

    FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno()); // 그룹 정보 읽기
    mav.addObject("foodVO", foodVO); 

    mav.setViewName("/creates/youtube"); // /WEB-INF/views/creates/youtube.jsp
        
    return mav;
  }
  
  /**
   * Youtube 등록/수정/삭제 처리
   * http://localhost:9092/creates/map.do
   * @param createsno 글 번호
   * @param youtube Youtube url의 소스 코드
   * @return
   */
  @RequestMapping(value="/creates/youtube.do", method = RequestMethod.POST)
  public ModelAndView youtube_update(int createsno, String youtube) {
    ModelAndView mav = new ModelAndView();
    
    if (youtube.trim().length() > 0) {  // 삭제 중인지 확인, 삭제가 아니면 youtube 크기 변경
      youtube = Tool.youtubeResize(youtube, 640);  // youtube 영상의 크기를 width 기준 640 px로 변경
    }    
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("createsno", createsno);
    hashMap.put("youtube", youtube);
    
    this.createsProc.youtube(hashMap);
    
    mav.setViewName("redirect:/creates/read.do?createsno=" + createsno); 
    // /webapp/WEB-INF/views/creates/read.jsp
    
    return mav;
  }
  
  /**
   * 수정 폼
   * http://localhost:9092/creates/update_text.do?createsno=1
   * 
   * @return
   */
  @RequestMapping(value = "/creates/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(HttpSession session, int createsno) {
    ModelAndView mav = new ModelAndView();
    
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우
      CreatesVO createsVO = this.createsProc.read(createsno);
      mav.addObject("createsVO", createsVO);
      
      FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno());
      mav.addObject("foodVO", foodVO);
      
      mav.setViewName("/creates/update_text"); // /WEB-INF/views/creates/update_text.jsp
      // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
      // mav.addObject("content", content);

    } else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }

    return mav; // forward
  }
  
  /**
   * 수정 처리
   * http://localhost:9092/creates/update_text.do?createsno=1
   * 
   * @return
   */
  @RequestMapping(value = "/creates/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(HttpSession session, CreatesVO createsVO) {
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("-> word: " + createsVO.getWord());
    
    if (this.manageProc.isManage(session)) { // 관리자 로그인 확인
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("createsno", createsVO.getCreatesno());
      hashMap.put("passwd", createsVO.getPasswd());
      
      if (this.createsProc.password_check(hashMap) == 1) { // 패스워드 일치
        this.createsProc.update_text(createsVO); // 글수정  
         
        // mav 객체 이용
        mav.addObject("createsno", createsVO.getCreatesno());
        mav.addObject("cfoodno", createsVO.getCfoodno());
        mav.setViewName("redirect:/creates/read.do"); // 페이지 자동 이동
        
      } else { // 패스워드 불일치
        mav.addObject("code", "passwd_fail");
        mav.addObject("cnt", 0);
        mav.addObject("url", "/creates/msg"); // msg.jsp, redirect parameter 적용
        mav.setViewName("redirect:/creates/msg.do");  // POST -> GET -> JSP 출력
      }
    } else { // 정상적인 로그인이 아닌 경우 로그인 유도
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }
    
    mav.addObject("now_page", createsVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★
    
    // URL에 파라미터의 전송
    // mav.setViewName("redirect:/creates/read.do?createsno=" + createsVO.getCreatesno() + "&cfoodno=" + createsVO.getCfoodno());             
    
    return mav; // forward
  }
  
  /**
   * 파일 수정 폼
   * http://localhost:9092/creates/update_file.do?createsno=1
   * 
   * @return
   */
  @RequestMapping(value = "/creates/update_file.do", method = RequestMethod.GET)
  public ModelAndView update_file(HttpSession session, int createsno) {
    ModelAndView mav = new ModelAndView();
    
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우
      CreatesVO createsVO = this.createsProc.read(createsno);
      mav.addObject("createsVO", createsVO);
      
      FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno());
      mav.addObject("foodVO", foodVO);
      
      mav.setViewName("/creates/update_file"); // /WEB-INF/views/creates/update_file.jsp
      
    } else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }


    return mav; // forward
  }
  
  /**
   * 파일 수정 처리 http://localhost:9092/creates/update_file.do
   * 
   * @return
   */
  @RequestMapping(value = "/creates/update_file.do", method = RequestMethod.POST)
  public ModelAndView update_file(HttpSession session, CreatesVO createsVO) {
    ModelAndView mav = new ModelAndView();
    
    if (this.manageProc.isManage(session)) {
      // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
      CreatesVO createsVO_old = this.createsProc.read(createsVO.getCreatesno());
      
      // -------------------------------------------------------------------
      // 파일 삭제 시작
      // -------------------------------------------------------------------
      String file1saved = createsVO_old.getFile1saved();  // 실제 저장된 파일명
      String thumb1 = createsVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
      long size1 = 0;
         
      String upDir =  Creates.getUploadDir(); // C:/kd/deploy/food_v3sbm3c/creates/storage/
      
      Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
          
      // -------------------------------------------------------------------
      // 파일 전송 시작
      // -------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image

      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = createsVO.getFile1MF();
          
      file1 = mf.getOriginalFilename(); // 원본 파일명
      size1 = mf.getSize();  // 파일 크기
          
      if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
          thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
        }
        
      } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
        file1="";
        file1saved="";
        thumb1="";
        size1=0;
      }
          
      createsVO.setFile1(file1);
      createsVO.setFile1saved(file1saved);
      createsVO.setThumb1(thumb1);
      createsVO.setSize1(size1);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
          
      this.createsProc.update_file(createsVO); // Oracle 처리

      mav.addObject("createsno", createsVO.getCreatesno());
      mav.addObject("cfoodno", createsVO.getCfoodno());
      mav.setViewName("redirect:/creates/read.do"); // request -> param으로 접근 전환
                
    } else {
      mav.addObject("url", "/manage/login_need"); // login_need.jsp, redirect parameter 적용
      mav.setViewName("redirect:/creates/msg.do"); // GET
    }

    // redirect하게되면 전부 데이터가 삭제됨으로 mav 객체에 다시 저장
    mav.addObject("now_page", createsVO.getNow_page());
    
    return mav; // forward
  }   
  
  /**
   * 파일 삭제 폼
   * http://localhost:9092/creates/delete.do?createsno=1
   * 
   * @return
   */
  @RequestMapping(value = "/creates/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int createsno) {
    ModelAndView mav = new ModelAndView();
    
    if (manageProc.isManage(session)) { // 관리자로 로그인한경우
      CreatesVO createsVO = this.createsProc.read(createsno);
      mav.addObject("createsVO", createsVO);
      
      FoodVO foodVO = this.foodProc.read(createsVO.getCfoodno());
      mav.addObject("foodVO", foodVO);
      
      mav.setViewName("/creates/delete"); // /WEB-INF/views/creates/delete.jsp
      
    } else {
      mav.addObject("url", "/manage/login_need"); // /WEB-INF/views/manage/login_need.jsp
      mav.setViewName("redirect:/creates/msg.do"); 
    }


    return mav; // forward
  }
  
  /**
   * 삭제 처리 http://localhost:9092/creates/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/creates/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(CreatesVO createsVO) {
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 삭제 시작
    // -------------------------------------------------------------------
    // 삭제할 파일 정보를 읽어옴.
    CreatesVO createsVO_read = createsProc.read(createsVO.getCreatesno());
    
    String file1saved = createsVO.getFile1saved();
    String thumb1 = createsVO.getThumb1();
    
    String uploadDir = Creates.getUploadDir();
    Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
    Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
    // -------------------------------------------------------------------
    // 파일 삭제 종료
    // -------------------------------------------------------------------
    
    
    this.createsProc.delete(createsVO.getCreatesno()); // DBMS 삭제
        
    // -------------------------------------------------------------------------------------
    // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
    // -------------------------------------------------------------------------------------    
    // 마지막 페이지의 마지막 10번째 레코드를 삭제후
    // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
    // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
    int now_page = createsVO.getNow_page();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("cfoodno", createsVO.getCfoodno());
    hashMap.put("word", createsVO.getWord());
    
    if (createsProc.search_count(hashMap) % Creates.RECORD_PER_PAGE == 0) {
      now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
      if (now_page < 1) {
        now_page = 1; // 시작 페이지
      }
    }
    // -------------------------------------------------------------------------------------

    mav.addObject("cfoodno", createsVO.getCfoodno());
    mav.addObject("now_page", now_page);
    mav.setViewName("redirect:/creates/list_by_cfoodno.do"); 
    
    return mav;
  }   
      
  // http://localhost:9092/creates/delete_by_cfoodno.do?cfoodno=1
  // 파일 삭제 -> 레코드 삭제
  @RequestMapping(value = "/creates/delete_by_cfoodno.do", method = RequestMethod.GET)
  public String delete_by_cfoodno(int cfoodno) {
    ArrayList<CreatesVO> list = this.createsProc.list_by_cfoodno(cfoodno);
    
    for(CreatesVO createsVO : list) {
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
    
    int cnt = this.createsProc.delete_by_cfoodno(cfoodno);
    System.out.println("-> count: " + cnt);
    
    return "";
  
  }
  
  @RequestMapping(value = "/creates/delete_by_replyno.do", method = RequestMethod.GET)
  public String delete_by_replyno(int replyno) {
    ArrayList<CreatesVO> list = this.createsProc.list_by_replyno(replyno);
    
    for(CreatesVO createsVO : list) {
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
    
    int cnt = this.createsProc.delete_by_replyno(replyno);
    
    return "";
  
  }

}


