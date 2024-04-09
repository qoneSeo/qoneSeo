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

   <div class='title_line'>
    ${foodVO.name }
    <c:if test="${param.word.length() > 0 }">
      > 「${param.word }」 검색 ${search_count } 건
    </c:if> 
  </div>
  
  <aside class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manage_id != null }">
      <a href="./create.do?cfoodno=${foodVO.cfoodno }">등록</a>
      <span class='menu_divide' >│</span>
    </c:if>
    <a href="javascript:location.reload();">새로고침</a>
    <span class='menu_divide' >│</span>    
    <a href="./list_by_cfoodno.do?cfoodno=${param.cfoodno }&now_page=${param.now_page}&word=${param.word }">목록형</a>    
    <span class='menu_divide' >│</span>
    <a href="./list_by_cfoodno_grid.do?cfoodno=${param.cfoodno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>    
  </aside>
  
  <div style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cfoodno.do'>
      <input type='hidden' name='cfoodno' value='${param.cfoodno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우는 검색어를 출력 --%>
          <input type='text' name='word' id='word' value='${param.word }' >
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value=''>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
      <c:if test="${param.word.length() > 0 }"> <%-- 검색 상태하면 '검색 취소' 버튼을 출력 --%>
        <button type='button' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
                    onclick="location.href='./list_by_cfoodno.do?cfoodno=${param.cfoodno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </div>

  <div class="menu_line"></div> 
  
  <table class="table table-hover">
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    </thead>
    <tbody>
        <c:forEach var="createsVO" items="${list }" varStatus="info">
          <c:set var="createsno" value="${createsVO.createsno }" />
          <c:set var="thumb1" value="${createsVO.thumb1 }" />
    
           <tr onclick="location.href='./read.do?createsno=${createsno}&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" style="cursor: pointer;">
            <td>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                  <%-- registry.addResourceHandler("/creates/storage/**").addResourceLocations("file:///" +  Creates.getUploadDir()); --%>
                  <img src="/creates/storage/${thumb1 }" style="width: 120px; height: 90px;">
                </c:when>
                <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/creates/images/none1.png -->
                  <img src="/creates/images/none1.png" style="width: 120px; height: 90px;">
                </c:otherwise>
              </c:choose>
            </td>
            <td class="td_bs_left">
              <span style="font-weight: bold;">${createsVO.title }</span><br>
              <c:choose>
                <c:when test="${createsVO.content.length() > 160 }">
                  ${createsVO.content.substring(0, 160) }...
                </c:when>
                <c:otherwise>
                  ${createsVO.content }
                </c:otherwise>
              </c:choose>
              (${createsVO.rdate.substring(0, 16) })
            </td>
            <td class="td_bs">
              <a href="#" title="지도"><img src="/creates/images/map.png" class="icon"></a>
              <a href="#" title="유튜브"><img src="/creates/images/youtube.png" class="icon"></a>
              <a href="#" title="삭제"><img src="/creates/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
    </tbody>
      
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
