<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <%-- /static/css/style.css --%>
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />


<div class='title_line'>댓글 작성 완료</div>
 <%
String code = (String)request.getAttribute("code");
String cntString = request.getAttribute("cnt").toString();
String title = (String)request.getAttribute("title");
%>
 
  <div class='menu_line'></div>
  <fieldset class='fieldset_basic'>
    <ul>
        <%
        if (code.equals("create_success")) {
        %>
          <li class="li_none">
            <span class="span_success">댓글을 등록했습니다.</span><br>
           
          </li>
        <%  
        } else if (code.equals("create_fail")) {
        %>
          <li class="li_none">
            <span class="span_fail">댓글 등록에 실패했습니다.</span><br>
            
          </li>

        <%  
        } else if (code.equals("delete_success")) {
        %>
          <li class="li_none">
            <span class="span_success">댓글 삭제를 성공했습니다.</span><br>
            
          </li>
        <%  
        } else if (code.equals("delete_fail")) {
        %>
          <li class="li_none">
            <span class="span_fail">댓글 삭제에 실패했습니다.</span><br>
            
          </li>
        <%  
        } 
        %>
                
        <li class="li_none">
          <br>
          <%
          if (cntString.equals("0")) {
            %>
              <button type="button" onclick="history.back()" class="btn btn-secondary btn-sm">다시 시도</button>
            <%  
            }
            %>                         
            <button type = "button" onclick="location.href='/creates/read.do?createsno=${createsno}&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }&cfoodno=${param.cfoodno }'" 
            class="btn btn-sm" style="background-color: #323232; color: white;">확인</button>
          </li>
          
      </ul>
    </fieldset>

  

  <jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
