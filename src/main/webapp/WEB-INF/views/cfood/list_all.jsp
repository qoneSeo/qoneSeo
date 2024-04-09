<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<c:import url="/menu/top.do" />

  <div class='title_line'>카테고리</div>

  <aside class="aside_right">
    <a href="./create.do?cfoodno=${foodVO.cfoodno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div> 

  <form name='frm' method='post' action='/cfood/create.do'>
    <div style="text-align: center;">
      <label>카테고리 이름</label>
      <input type="text" name="name" value="" required="required" autofocus="autofocus" 
                 class="" style="width: 50%">
      <button type="submit" class="btn btn-secondary btn-sm" style="height: 28px; margin-bottom: 5px;">등록</button>
      <button type="button" onclick="location.href='./list_all.do'" class="btn btn-secondary btn-sm" 
                  style="height: 28px; margin-bottom: 5px;">목록</button> 
    </div>
  </form>
  
<table class="table table-hover">
  <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
      <col style='width: 20%;'/>
    </colgroup>
    <thead>
      <tr>
        <th class="th_bs">순서</th>
        <th class="th_bs">카테고리 이름</th>
        <th class="th_bs">자료수</th>
        <th class="th_bs">등록일</th>
        <th class="th_bs">기타</th>
      </tr>
    </thead>
    <tbody>
        <c:forEach var="foodVO" items="${list }" varStatus="info">
          <c:set var="cfoodno" value="${foodVO.cfoodno }" />
          <c:set var="seqno" value="${foodVO.seqno }" />
    
          <tr>
            <td class="td_bs">${seqno }</td>
            <td><a href="../creates/list_by_cfoodno.do?cfoodno=${cfoodno }" style="display: block;">${foodVO.name }</a></td>
            <td class="td_bs">${foodVO.cnt }</td>
            <td class="td_bs">${foodVO.rdate.substring(0, 10) }</td>
            <td class="td_bs">
            <a href="../creates/create.do?cfoodno=${cfoodno }" title="등록"><img src="/cfood/images/create.png" class="icon"></a>
              <c:choose>
                <c:when test="${foodVO.visible == 'Y'}">
                  <a href="./update_visible_n.do?cfoodno=${cfoodno }" title="카테고리 공개 설정"><img src="/cfood/images/show.png" class="icon"></a>
                </c:when>
                <c:otherwise>
                  <a href="./update_visible_y.do?cfoodno=${cfoodno }" title="카테고리 비공개 설정"><img src="/cfood/images/hide.png" class="icon"></a>
                </c:otherwise>
              </c:choose>    
              
              <a href="./update_seqno_forward.do?cfoodno=${cfoodno }" title="우선 순위 높임"><img src="/cfood/images/decrease.png" class="icon"></a>
              <a href="./update_seqno_backward.do?cfoodno=${cfoodno }" title="우선 순위 낮춤"><img src="/cfood/images/increase.png" class="icon"></a>
              <a href="./update.do?cfoodno=${cfoodno }" title="수정"><img src="/cfood/images/update.png" class="icon"></a>
              <a href="./delete.do?cfoodno=${cfoodno }" title="삭제"><img src="/cfood/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
