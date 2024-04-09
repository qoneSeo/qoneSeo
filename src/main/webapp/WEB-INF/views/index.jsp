<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<style>
  body {
    margin: 0; /* body의 기본 마진을 없애기 */
  }
   .container {
    max-width: 1200px; /* 콘텐츠의 최대 너비를 지정 */
    margin: 20px auto; /* 상하 여백을 주고 좌우는 자동으로 가운데 정렬 */
    margin-left: 100px; /* 오른쪽으로 10px 이동 */
  }
  .resized-image {
    width: 50%; /* 부모 요소(container)의 너비에 맞게 이미지의 너비 조절 */
    height: auto; /* 비율을 유지하며 자동으로 높이 조절 */
  }
</style>

</head>
<body>
<c:import url="/menu/top.do" />
  
<div class="container">
  <img src="/images/main01.jpg" style="width: 80%;">
</div>

<jsp:include page="./menu/bottom.jsp" flush='false' /> 
</body>
</html>
