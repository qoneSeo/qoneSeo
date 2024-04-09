<%@ page contentType="text/html; charset=UTF-8" %>
 
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
  
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
<div class='title_line'>공지사항 등록</div>

<form name='frm' method='post' action='/notice/create.do'>
  <div>
    <label>제목</label>
    <input type="text" name="title" value='제목을 적어주세요' required="required" autofocus="autofocus" 
               class="form-control form-control-sm" style="width: 50%">
  </div>
          <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>내용을 적어주세요 </textarea>
    </div>
    
  <div class="content_body_bottom">
    <button type="submit" class="btn btn-secondary btn-sm">등록</button>
    <button type="button" onclick="location.href='./list_all.do'" class="btn btn-secondary btn-sm">목록</button> 
  </div>
</form>

<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>