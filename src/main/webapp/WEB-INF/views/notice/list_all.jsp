<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.notice.NoticeVO" %>
 
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

</head>
<body>
<c:import url="/menu/top.do" />
<div class='title_line'>공지사항</div>
  <aside class="aside_right">
  <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manage_id != null }">  
    <a href="./create.do">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
    </c:if>
  </aside>
   <div class="menu_line"></div> 
<table class="table table-hover">
  <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 30%;"></col>
    </colgroup>
    <thead>
      <tr>
        <th class="th_bs">글 번호</th>
        <th class="th_bs">제목</th>
        <th class="th_bs">등록일</th>
      </tr>
    </thead>
    <tbody>
    <%
    ArrayList<NoticeVO> list = (ArrayList<NoticeVO>) request.getAttribute("list");
    for (int i=0; i < list.size(); i++) {
      NoticeVO noticeVO = list.get(i);
      int noticeno = noticeVO.getNoticeno();

    %>
      <tr>
        <td class="td_bs"><%=i+1 %></td>
        <td><a href="./read.do?noticeno=<%=noticeno %>" style="display: block;"><%=noticeVO.getTitle() %></a></td>
        <td class="td_bs"><%=noticeVO.getRdate().substring(0, 10) %></td>

      </tr>
      
    <%   
    }      
    %>

    </tbody>
    
</table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>


