package dev.mvc.cfood;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// Controller가 사용하는 이름
@Component("dev.mvc.cfood.FoodProc")
public class FoodProc implements FoodProcInter {
  @Autowired // FoodDAOInter interface 구현한 객체를 만들어 자동으로 할당해라.
  private FoodDAOInter foodDAO;
  
  @Override
  public int create(FoodVO foodVO) {
    int cnt = this.foodDAO.create(foodVO);

    return cnt;
  }

  @Override
  public ArrayList<FoodVO> list_all() {
    ArrayList<FoodVO> list = this.foodDAO.list_all();
    
    return list;
  }

  @Override
  public FoodVO read(int cfoodno) {
    FoodVO  foodVO  = this.foodDAO.read(cfoodno);
    
    return foodVO;
  }

  @Override
  public int update(FoodVO foodVO) {
    int cnt = this.foodDAO.update(foodVO);
    
    return cnt;
  }

  @Override
  public int delete(int cfoodno) {
    int cnt = this.foodDAO.delete(cfoodno);
    
    return cnt;
  }

  @Override
  public int update_seqno_forward(int cfoodno) {
    int cnt = this.foodDAO.update_seqno_forward(cfoodno);
    return cnt;
  }

  @Override
  public int update_seqno_backward(int cfoodno) {
    int cnt = this.foodDAO.update_seqno_backward(cfoodno);
    return cnt;
  }

  @Override
  public int update_visible_y(int cfoodno) {
    int cnt = this.foodDAO.update_visible_y(cfoodno);
    return cnt;
  }

  @Override
  public int update_visible_n(int cfoodno) {
    int cnt = this.foodDAO.update_visible_n(cfoodno);
    return cnt;
  }

  @Override
  public ArrayList<FoodVO> list_all_y() {
    ArrayList<FoodVO> list = this.foodDAO.list_all_y();
    return list;
  }

}





