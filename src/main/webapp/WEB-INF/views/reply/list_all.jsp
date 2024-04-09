<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dev.mvc.reply.ReplyVO" %>
<%@ page import="dev.mvc.creates.CreatesVO" %>


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

  <div class='title_line'>전체 댓글 목록
   
  </div>
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
      </aside>
 
<div class="menu_line"></div> 
 
  
  <table class="table table-hover">
    <colgroup>
      <col style="width: 50%;"></col>
      <col style="width: 25%;"></col>
    </colgroup>
    <thead>
      <tr>
        <th style='text-align: center;'>댓글</th>
        <th style='text-align: center;'>작성 시간</th>
      </tr>
    </thead>
    <tbody>
        <c:forEach var="createsVO" items="${list }" varStatus="info">
          <c:set var="createsno" value="${createsVO.createsno }" />
          <c:set var="replyno" value="${replyVO.replyno }" />
          <tr>
            <td class="td_bs_left">
             
              <c:choose>
                <c:when test="${createsVO.content.length() > 160 }">
                  ${createsVO.content.substring(0, 160) }...
                </c:when>
                <c:otherwise>       
                  ${createsVO.content }
                  
                </c:otherwise>
              </c:choose>   
             <td class="td_bs">(${createsVO.rdate.substring(0, 16) })</td>   
          </tr>
        </c:forEach>

    </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
