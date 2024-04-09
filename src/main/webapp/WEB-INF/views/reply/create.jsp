<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>간단한 1인 요리 블로그</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
  <div class='title_line'>댓글</div>
  
  <div class='content_body'>
    <aside class="aside_right">
      <a href="./create.do">등록</a>
      <span class='menu_divide' >│</span>
      <a href="javascript:location.reload();">새로고침</a>
    </aside> 
    
    <div class='menu_line'></div>
    
    <form name='frm' method='post' action='./create.do'>
              <input type='hidden' name='crewno' value='${crewno}'>
      <div>
         <label>댓글</label>
         <input type='text' name='content' value='댓글 작성 부탁합니다' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
      </div>

      <div class="content_body_bottom">
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="button" onclick="location.href='/reply/list_all.do" class="btn btn-primary">목록</button>
      </div>
    
    </form>
</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>