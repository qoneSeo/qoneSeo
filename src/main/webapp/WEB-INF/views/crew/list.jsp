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
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

</script>
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='title_line'>회원 목록(관리자 전용)</DIV>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
   
  <div class='menu_line'></div>
    
   
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
      <col style='width: 15%;'/>
      <col style='width: 30%;'/>
      <col style='width: 15%;'/>
      <col style='width: 10%;'/>
    </colgroup>
    <TR>
      <TH class='th_bs'> </TH>
      <TH class='th_bs'>ID</TH>
      <TH class='th_bs'>성명</TH>
      <TH class='th_bs'>전화번호</TH>
      <TH class='th_bs'>주소</TH>
      <TH class='th_bs'>등록일</TH>
      <TH class='th_bs'> </TH>
    </TR>
   
    <c:forEach var="crewVO" items="${list }">
      <c:set var="crewno" value ="${crewVO.crewno}" />
      <c:set var="grade" value ="${crewVO.grade}" />
      <c:set var="id" value ="${crewVO.id}" />
      <c:set var="mname" value ="${crewVO.mname}" />
      <c:set var="tel" value ="${crewVO.tel}" />
      <c:set var="address1" value ="${crewVO.address1}" />
      <c:set var="mdate" value ="${crewVO.mdate}" />
       
    <TR>
      <TD class='td_basic'>
        <c:choose>
          <c:when test="${grade >= 1 and grade <= 10}"><img src='/crew/images/manage.png' title="관리자" class="icon"></c:when>    
          <c:when test="${grade >= 11 and grade <= 20}"><img src='/crew/images/user.png' title="회원" class="icon"></c:when>
          <c:when test="${grade >= 30 and grade <= 39}"><img src='/crew/images/pause.png' title="정지 회원" class="icon"></c:when>
          <c:when test="${grade >= 40 and grade <= 49}"><img src='/crew/images/x.png' title="탈퇴 회원" class="icon"></c:when>
        </c:choose>  
      </TD>
      <TD class='td_left'><A href="./read.do?crewno=${crewno}">${id}</A></TD>
      <TD class='td_left'><A href="./read.do?crewno=${crewno}">${mname}</A></TD>
      <TD class='td_basic'>${tel}</TD>
      <TD class='td_left'>
        <c:choose>
          <c:when test="${address1.length() > 15 }"> <%-- 긴 주소 처리 --%>
            ${address1.substring(0, 15) }...
          </c:when>
          <c:otherwise>
            ${address1}
          </c:otherwise>
        </c:choose>
      </TD>
      <TD class='td_basic'>${mdate.substring(0, 10)}</TD> <%-- 년월일 --%>
      <TD class='td_basic'>
        <A href="./read.do?crewno=${crewno}"><IMG src='/crew/images/update.png' title='수정' class="icon"></A>
        <A href="./delete.do?crewno=${crewno}"><IMG src='/crew/images/delete.png' title='삭제' class="icon"></A>
      </TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-sm">등록</button>
    <button type='button' onclick="location.reload();" class="btn btn-primary btn-sm">새로 고침</button>
  </DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

