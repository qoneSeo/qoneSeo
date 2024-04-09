<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />
<c:set var="content" value="${noticeVO.content }" />
<c:set var="rdate" value="${noticeVO.rdate }" />


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> 

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
<div class='title_line'>공지사항 조회</div>
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <aside class="aside_right">
    <c:if test="${sessionScope.manage_id != null }">
      <a href="./create.do">등록</a>
          <span class='menu_divide' >│</span>
      <a href="./update_text.do?noticeno=${noticeno}">수정</a>
          <span class='menu_divide' >│</span>
      <a href="./delete.do?noticeno=${noticeno}">삭제</a>
    </c:if>
    </aside>

  <div class="container mt-3">
    <ul class="list-group list-group-flush">
            <li class="list-group-item">제목: ${noticeVO.title}</li>
            <li class="list-group-item">등록일: ${noticeVO.rdate}</li>
            <li class="li_none"> ${noticeVO.content}
              <br>         
              </li>
    </ul>
  </div>                      

<div class="content_body_bottom">
</div>

<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
