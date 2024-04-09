<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="name" value="${foodVO.name }" />

<c:set var="cfoodno" value="${createsVO.cfoodno }" />
<c:set var="createsno" value="${createsVO.createsno }" />
<c:set var="thumb1" value="${createsVO.thumb1 }" />
<c:set var="file1saved" value="${createsVO.file1saved }" />
<c:set var="title" value="${createsVO.title }" />
<c:set var="content" value="${createsVO.content }" />
<c:set var="rdate" value="${createsVO.rdate }" />
<c:set var="youtube" value="${createsVO.youtube }" />
<c:set var="map" value="${createsVO.map }" />
<c:set var="file1" value="${createsVO.file1 }" />
<c:set var="size1_label" value="${createsVO.size1_label }" />
<c:set var="word" value="${createsVO.word }" />
<c:set var="content" value="${replyVO.content }" />
<c:set var="replyno" value="${replyVO.replyno }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
 <link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
 function delete_reply (createsno,replyno){
    let sw = confirm('삭제하면 복구 할 수 없습니다. 삭제하시겠습니까?');

     if (sw == true){
       location.href='../reply/delete.do?createsno='+createsno+'&replyno='+replyno;
     }else{
      alert('삭제를 취소합니다.');     }
     }
 </script>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'><A href="./list_by_cfoodno.do?cfoodno=${cfoodno }" class='title_link'>${name }</A></DIV>

  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manage_id != null }">
      <%--
      http://localhost:9092/creates/create.do?cfoodno=1
      http://localhost:9092/creates/create.do?cfoodno=2
      http://localhost:9092/creates/create.do?cfoodno=3
      --%>
      <A href="./create.do?cfoodno=${cfoodno }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?createsno=${createsno}&now_page=${param.now_page}&word=${param.word }">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?createsno=${createsno}&now_page=${param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
      <A href="./map.do?cfoodno=${cfoodno }&createsno=${createsno}">지도</A>
      <span class='menu_divide' >│</span>
      <A href="./youtube.do?cfoodno=${cfoodno }&createsno=${createsno}">Youtube</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?createsno=${createsno}&now_page=${param.now_page}&cfoodno=${cfoodno}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_by_cfoodno.do?cfoodno=${cfoodno }&now_page=${param.now_page}&word=${param.word }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_cfoodno_grid.do?cfoodno=${cfoodno }&now_page=${param.now_page}&word=${param.word }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cfoodno.do'>
      <input type='hidden' name='cfoodno' value='${param.cfoodno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우는 검색어를 출력 --%>
          <input type='text' name='word' id='word' value='${param.word }'>
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
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
            <span style="font-size: 1.5em; font-weight: bold;">${title }</span>          
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <%-- /static/creates/storage/ --%>
              <img src="/creates/storage/${file1saved }" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
              <img src="/creates/images/none1.png" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
            </c:otherwise>
          </c:choose>
          <c:set var="content" value="${createsVO.content }" />
          
          <span style="font-size: 1em;"> ${rdate }</span><br>
          ${createsVO.content }
        </DIV>
      </li>
      
      <c:if test="${youtube.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style="text-align: center;">
            ${youtube }
          </DIV>
        </li>
      </c:if>
      
      <c:if test="${map.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style='text-align: center; width:640px; height: 360px; margin: 0px auto;'>
            ${map }
          </DIV>
        </li>
      </c:if>
      
      <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
          <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/creates/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label})  
          <a href='/download?dir=/creates/storage&filename=${file1saved}&downname=${file1}'><img src="/creates/images/download.png"></a>  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>
    <!-- ------------------------------ 댓글 영역 시작 ------------------------------ -->
    
       
      <FORM name='frm_reply' method='post' action='../reply/create.do' id='frm_reply'> <%-- 댓글 등록 폼 --%>
      <div style="text-align: center;">
      <DIV class='reply_line'></DIV>
        <input type='hidden' name='createsno' id='createsno' value='${createsno}'>
        
        <textarea name='content' required="required" id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea><br>        
        </DIV>
        <div style="text-align: right;">      
        <button type='submit' class="btn btn-secondary btn-sm" id='btn_create'>등록</button>
        </div>
        </FORM>
        <DIV class='reply_list_line' style='border-top: 1px dashed #EEEEEE; margin-top: 10px;'></DIV>
        <DIV id='reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
           <c:forEach var="reply" items="${list}" varStatus="info">
             <c:set var="content" value="${reply.content }" />
             <c:set var="replyno" value="${reply.replyno }" />
             ${reply.id } <span style="font-size: 1em;"> ${reply.rdate }</span>
            
             <c:if test="${sessionScope.manage_id != null || sessionScope.crewno == reply.crewno }">     
               <a href="javascript: delete_reply(${createsno }, ${replyno })"><img src="/creates/images/delete.png" class="icon"></a>
             </c:if><br>
             ${reply.content }<br>            
           </c:forEach>
        </DIV>
                ${replyVO.content }<br>
                <span style="font-size: 1em;"> ${replyVO.rdate }</span><br>
          
          
      
      <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 60%; background-color: #EEFFFF;'>

      </DIV>  
      
 

<!-- ------------------------------ 댓글 영역 종료 ------------------------------  -->
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

