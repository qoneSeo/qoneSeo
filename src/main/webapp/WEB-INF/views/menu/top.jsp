<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
  .top_menu_link:link{  /* 방문전 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #FFFFFF;
    font-weight: bold;
  }

  .top_menu_link:visited{  /* 방문후 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #FFFFFF;
    font-weight: bold;
  }

  .top_menu_link:hover{  /* A 태그에 마우스가 올라간 상태 */
    text-decoration: none; /* 밑줄 출력 */
    color: #FFFFFF;
    font-size: 1.05em;
  }
</style> 

<div class='container_main'>
  <div class='top_img'>
    <div class="top_menu_label">1인 요리 추천 version 2023</div>      
  </div> <!-- <div class='top_img'></div> 종료 -->
  

  <nav class="navbar navbar-expand-md navbar-dark bg-warning">
      <a class="navbar-brand" href="/"><img src='/css/images/home.png' title="HOME" style='display: block; padding-left: 5px;'></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle Navigation">
        <span class="navbar-toggler-icon"></span>
      </button>    

      <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav mr-auto">
            <%-- 게시판 목록 출력 --%>
            <c:forEach var="foodVO" items="${list_top}">
              <c:set var="cfoodno" value="${foodVO.cfoodno }" />
              <c:set var="name" value="${foodVO.name }" />
              <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
                <a class="nav-link top_menu_link" href="/creates/list_by_cfoodno_grid.do?cfoodno=${foodVO.cfoodno }&now_page=1">${foodVO.name }</a> 
              </li>
            </c:forEach>
            
            <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
              <a class="nav-link top_menu_link" href="/creates/list_all.do">전체 글 목록</a>
            </li>
              <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
              <a class="nav-link top_menu_link" href="/notice/list_all.do">공지사항</a>
            </li>

            <li class="nav-item dropdown"> <%-- 회원 서브 메뉴 --%>
              <a class="nav-link top_menu_link dropdown-toggle" data-bs-toggle="dropdown" href="#">회원</a>
              <div class="dropdown-menu">
                <c:choose>
                  <c:when test="${sessionScope.id == null }">
                    <a class="dropdown-item" href="/crew/create.do">회원 가입</a>
                    <a class="dropdown-item" href="#">아이디 찾기</a>
                    <a class="dropdown-item" href="#">비밀번호 찾기</a>
                  </c:when>
                  <c:otherwise>
                    <a class="dropdown-item" href="/crew/read.do">가입 정보</a>
                    <a class="dropdown-item" href="/crew/passwd_update.do">비밀번호 변경</a>
                    <a class="dropdown-item" href="/crew/read.do">회원 정보 수정</a>
                    <a class="dropdown-item" href="/clogin/list_by_clogin.do">회원별 로그인 내역</a>
                    <a class="dropdown-item" href="#">회원 탈퇴</a>
                    
                  </c:otherwise>
                </c:choose>
              </div>
            </li>
          
            <c:choose>
              <c:when test="${sessionScope.manage_id == null }">
                <li class="nav-item">
                  <a class="nav-link top_menu_link" href="/manage/login.do">관리자 로그인</a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="nav-item dropdown"> <%-- 관리자 서브 메뉴 --%>
                  <a class="nav-link top_menu_link dropdown-toggle" data-bs-toggle="dropdown" href="#">관리자</a>
                  <div class="dropdown-menu">
                    <a class="dropdown-item" href='/cfood/list_all.do'>카테고리 전체 목록</a>
                    <a class="dropdown-item" href='/crew/list.do'>회원 목록</a>
                    <a class="dropdown-item" href="/mlogin/list_all.do">관리자 로그인 내역</a>
                    <a class="dropdown-item" href="/clogin/list_all.do">회원 로그인 내역</a>
                    <a class="dropdown-item" href="/reply/list_all.do">댓글 전체 목록</a>
                    <a class="dropdown-item" href='/manage/logout.do'>관리자 ${sessionScope.manage_id } 로그아웃</a>
                    
                  </div>
                </li>
              </c:otherwise>
            </c:choose>
            
            <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
              <c:choose>
                  <c:when test="${sessionScope.id == null}">
                      <a class="nav-link top_menu_link" href="/crew/login.do">로그인</a>
                  </c:when>
                  <c:otherwise>
                      <a class="nav-link top_menu_link" href='/crew/logout.do'>${sessionScope.id } 로그아웃</a>
                  </c:otherwise>
              </c:choose>
            </li>     
          </ul>
      </div>    
  </nav>
    
  <div class='content_body'> <!--  내용 시작 -->