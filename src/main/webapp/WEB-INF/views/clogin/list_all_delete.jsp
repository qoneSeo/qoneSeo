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

 <div id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <form name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
        <input type="hidden" name="cloginno" value="${param.cloginno }"> <%-- 삭제할 카테고리 번호 --%>

        <c:choose>
            <c:when test="${count_by_cloginno >= 1 }"> <%-- 자식 레코드가 있는 상황 --%>
                <div class="msg_warning">
                    관련 자료 ${count_by_cloginno } 건이 발견되었습니다.<br>
                    관련 자료를 모두 삭제하시겠습니까?
                </div>
                <label>관련 카테고리 이름</label>:  ${cloginVO.name } 
                <button type="submit" id='submit' class='btn btn-danger btn-sm' style='height: 28px; margin-bottom: 5px;'>관련 자료와 함게 카테고리 삭제</button>
            </c:when>
        </c:choose>      
    </form>
</div>

<table class="table table-hover">
  <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 50%;'/>
      <col style='width: 50%;'/>    
      <col style='width: 20%;'/>
      <col style='width: 20%;'/>
    </colgroup>
  <thead>
    <tr>
     <th class="th_bs">순서</th>
     <th class="th_bs">접속 IP</th>
     <th class="th_bs">접속 시간</th>
      </tr>
  </thead>
  <tbody>
    <c:forEach var="CloginVO" items="${list }" varStatus="info">
      <c:set var="cloginno" value="${CloginVO.cloginno }"/>
        <tr>
          <td class="td_bs">${info.count }</td>
          <td class="td_bs">${CloginVO.ip }</td>
          <td class="td_bs">${CloginVO.logindate }</td>
          <td class="td_bs">
         <a href="./delete.do?cloginno=${cloginno}" title="삭제"><img src="/creates/images/delete.png" class="icon"></a>

        </tr>
    </c:forEach>

  </tbody>
</table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>