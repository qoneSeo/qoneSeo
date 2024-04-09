<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<div class='container_main'>
  <div class='top_img'>
    <div class="top_menu_label">1인 요리 추천 version 2023</div>      
    <nav class="top_menu">
      <a href="/" class="menu_link">HOME</a><span class="top_menu_sep"> </span>
      
      <c:forEach var="foodVO" items="${list_top }">
        <a href="/creates/list_by_cfoodno.do?cfoodno=${foodVO.cfoodno }&now_page=1" class="menu_link">${foodVO.name }</a><span class="top_menu_sep"> </span> 
      </c:forEach>
      
      <a href="/crew/create.do" class="menu_link">회원 가입</a><span class="top_menu_sep"> </span>
      <a href="/crew/list.do" class="menu_link">회원 목록</a><span class="top_menu_sep"> </span>

      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <a href="/crew/login.do" class="menu_link">로그인</a><span class="top_menu_sep"> </span>
        </c:when>
        <c:otherwise>
          <a href='/crew/logout.do' class="menu_link">${sessionScope.id } 로그아웃</a><span class="top_menu_sep"> </span>
          <a href='/crew/passwd_update.do' class="menu_link">비밀번호 변경</a><span class="top_menu_sep"> </span>
        </c:otherwise>
      </c:choose>

      <c:choose>
        <c:when test="${sessionScope.manage_id == null }">
          <a href="/manage/login.do" class="menu_link">관리자 로그인</a>
        </c:when>
        <c:otherwise>
          <a href="/cfood/list_all.do" class="menu_link">카테고리 전체 목록</a><span class="top_menu_sep"> </span>
          <a href="/creates/list_all.do" class="menu_link">전체 글 목록</a><span class="top_menu_sep"> </span>
          <a href="/creates/list_all_gallery.do" class="menu_link">Gallery</a><span class="top_menu_sep"> </span>
          <a href="/manage/logout.do" class="menu_link">관리자 ${sessionScope.manage_id } 로그아웃</a>
        </c:otherwise>
      </c:choose>
      
    </nav>
  </div>
  <div class='content_body'> <!--  내용 시작 -->  