<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
    <title>간단한 1인 요리 블로그</title>
    <link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
    <link href="/css/style.css" rel="Stylesheet" type="text/css"> <%-- /static/css/style.css --%>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 <c:import url="/menu/top.do" />

    <div class='title_line'>공지사항 > 알림</div>
    <div class='message'>
        <fieldset class='fieldset_basic'>
            <ul>
                <c:choose>
                    <c:when test="${code eq 'create_success'}">
                        <li class="li_none">
                            <span class="span_success">공지사항를 등록했습니다.</span><br>
                        </li>
                    </c:when>
                    <c:when test="${code eq 'create_fail'}">
                        <li class="li_none">
                            <span class="span_fail">공지사항 등록에 실패했습니다.</span><br>
                        </li>
                    </c:when>
                    <c:when test="${code eq 'update_success'}">
                        <li class="li_none">
                            <span class="span_success">공지사항 수정을 성공했습니다.</span><br>
                        </li>
                    </c:when>
                    <c:when test="${code eq 'update_fail'}">
                        <li class="li_none">
                            <span class="span_fail">공지사항 수정에 실패했습니다.</span><br>
                        </li>
                    </c:when>
                    <c:when test="${code eq 'delete_success'}">
                        <li class="li_none">
                            <span class="span_success">공지사항 삭제를 성공했습니다.</span><br>
                        </li>
                    </c:when>
                    <c:when test="${code eq 'delete_fail'}">
                        <li class="li_none">
                            <span class="span_fail">공지사항 삭제에 실패했습니다.</span><br>
                        </li>
                    </c:when>
                </c:choose>
                 </ul>
                <button type='button' onclick="location.href='./list_all.do'" class="btn btn-secondary btn-sm">목록</button>          
        </fieldset>
    </div>

    <jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
