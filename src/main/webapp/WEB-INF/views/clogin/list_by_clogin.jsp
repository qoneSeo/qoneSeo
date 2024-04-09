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

    <div class='title_line'>회원별 로그인 내역</div>
    
    <table class="table table-hover">
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 50%;'/>
      <col style='width: 20%;'/>    
      <col style='width: 20%;'/>
      <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">순서</th>
          <th class="th_bs">회원 번호</th>
          <th class="th_bs">접속 IP</th>
          <th class="th_bs">접속 시간</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="cloginVO" items="${list }" varStatus="info">
          <c:set var="cloginno" value="${cloginVO.cloginno }" />
          <c:set var="crewno" value="${cloginVO.crewno }" />
          <c:set var="ip" value="${cloginVO.ip }" />
          <c:set var="logindate" value="${cloginVO.logindate }" />
    
          <tr>
            <td class="td_bs">${cloginno }</td>
            <td class="td_bs">${crewno }</td>
          <td class="td_bs">${ip }</td>
          <td class="td_bs">${logindate }</td>
          </tr>
        </c:forEach>
      </tbody>
      
  </table>
  
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>