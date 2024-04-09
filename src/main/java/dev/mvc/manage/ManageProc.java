package dev.mvc.manage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.manage.ManageProc")
public class ManageProc implements ManageProcInter {
  @Autowired
  private ManageDAOInter ManageDAO;
  
  @Override
  public int login(ManageVO manageVO) {
    int cnt = this.ManageDAO.login(manageVO);
    return cnt;
  }

  @Override
  public ManageVO read_by_id(String id) {
    ManageVO manageVO = this.ManageDAO.read_by_id(id);
    return manageVO;
  }

  @Override
  public boolean isManage(HttpSession session) {
    boolean manage = false;
    
    if (session != null) {
      String manage_id = (String)session.getAttribute("manage_id");
      
      if (manage_id != null) {
        manage = true;
      }
    }
    
    return manage;
    
  }

  @Override
  public ManageVO read(int manageno) {
    ManageVO manageVO = this.ManageDAO.read(manageno);
    return manageVO;
  }
  
  
}


