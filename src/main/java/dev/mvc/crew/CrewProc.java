package dev.mvc.crew;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
@Component("dev.mvc.crew.CrewProc")
public class CrewProc implements CrewProcInter {
  @Autowired
  private CrewDAOInter crewDAO;
  
  public CrewProc(){
    // System.out.println("-> crewProc created.");
  }

  @Override
  public int checkID(String id) {
    int cnt = this.crewDAO.checkID(id);
    return cnt;
  }

  @Override
  public int create(CrewVO crewVO) {
    int cnt = this.crewDAO.create(crewVO);
    return cnt;
  }
 
  @Override
  public ArrayList<CrewVO> list() {
    ArrayList<CrewVO> list = this.crewDAO.list();
    return list;
  }
  
  @Override
  public CrewVO read(int crewno) {
    CrewVO crewVO = this.crewDAO.read(crewno);
    return crewVO;
  }

  @Override
  public CrewVO readById(String id) {
    CrewVO crewVO = this.crewDAO.readById(id);
    return crewVO;
  }

@Override
  public boolean isCrew(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 20){ // 관리자 + 회원
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }

  @Override
  public boolean isCrewManage(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 10){ // 관리자 
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }
  
  @Override
  public int update(CrewVO crewVO) {
    int cnt = this.crewDAO.update(crewVO);
    return cnt;
  }
  
  @Override
  public int delete(int crewno) {
    int cnt = this.crewDAO.delete(crewno);
    return cnt;
  }
  
  @Override
  public int passwd_check(HashMap<String, Object> map) {
    int cnt = this.crewDAO.passwd_check(map);
    return cnt;
  }

  @Override
  public int passwd_update(HashMap<String, Object> map) {
    int cnt = this.crewDAO.passwd_update(map);
    return cnt;
  }
  
  @Override
  public int login(HashMap<String, Object> map) {
    int cnt = this.crewDAO.login(map);
    return cnt;
  }
  

}





