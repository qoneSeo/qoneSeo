<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="replyno" value="${replyVO.replyno }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
  <DIV class='title_line'> 댓글 삭제</DIV>
  
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
    <span class='menu_divide' >│</span>    
    <a href="./list_all.do?">목록</a>    
  </aside>
  
  
  <div class='menu_line'></div>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">

        <DIV style='text-align: left; width: 47%; float: left;'>
          <span style='font-size: 1.5em;'>댓글 삭제</span>
          <br>
          <form name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
              <input type="hidden" name="replyno" value="${param.replyno } ">
              
          
              <br><br>
              <div style='text-align: center; margin: 10px auto;'>
                  <span style="color: #FF0000; font-weight: bold;">삭제를 진행 하시겠습니까? 삭제하시면 복구 할 수 없습니다.</span><br><br>
                  <br><br>
                  <button type="submit" class="btn btn-sm" style="background-color: #323232; color: white;">삭제 진행</button>
                  <button type="button" onclick="history.back()" class="btn btn-sm" style="background-color: #323232; color: white;">취소</button>
              </div>
          </FORM>

        </DIV>
      </li>
      
     </ul>
  </fieldset>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>