<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/qna.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script defer type="text/javascript" src='/resources/js/common.js'></script>

<script type="text/javascript">
function collapse(element) {
    var before = document.getElementsByClassName("active")[0]               // 기존에 활성화된 버튼
    if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
        before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
        before.classList.remove("active");                  // 버튼 비활성화
    }
    element.classList.toggle("active");         // 활성화 여부 toggle

    var content = element.nextElementSibling;
    if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
        content.style.maxHeight = null;         // 접기
    } else {
        content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
    }
   
    /* var id = document.getElementById("content").value;
   console.log("span아이디 : "+id); */
}

</script>

<!-- <script>

$(document).ready(function(){
   var id = $('#content').val();
   console.log(id);
})
</script> -->

</head>
<body>

<div class="container" style="text-align:center; width: 1422px; margin: 80px auto;">

<h1 style="margin-top:50px; margin-bottom:40px">NOTICE</h1>
<input type="button" onclick="location.href='/admin/noticeWriteForm.sosu'" value="공지사항 작성" class="notice-btn">

<hr style="width:55%; background:gray; height:1px; border:0;">

<c:if test="${noticeList[0].N_CONTENT ne null }">
<c:forEach begin="0" end="${fn:length(noticeList)}" items="${noticeList }" var="list">

<button type="button" class="collapsible" onclick="collapse(this);">
   <p><span class="noticeicon">공지</span><span style="margin-left:10px;">${list.N_TITLE}</span>
   <span style="float:right"><fmt:formatDate value="${list.N_REGDATE}" pattern="yyyy-MM-dd"/></span></p>
</button>

   <div class="noticecontent">
   <p><span>${list.N_CONTENT}</span>
   
   
   
   
   <form action="/admin/noticeDelete.sosu" method="post" style="width:-10px;float:right;">
   <input type="hidden" name="N_IDX" value="${list.N_IDX}">
   <input type="submit" value="삭제" style="background-color:black; border:none; color:white; cursor: pointer;">
   </form>
   
   <form action="/admin/noticeUpdateForm.sosu" method="get" style="margin-right:4px ;float:right;">
   <input type="hidden" name="N_IDX" value="${list.N_IDX}">
   <input type="hidden" name="N_TITLE" value="${list.N_TITLE }">
   <input type="hidden" name="N_CONTENT" value="${list.N_CONTENT }">
   <input type="submit" value="수정" style="background-color: #fd8731; border:none; color:white; cursor: pointer;">
   </form>
   
   </p>
   </div>
   
   
   
<hr style="width:55%; background:gray; height:1px; border:0;">

</c:forEach>
</c:if>



 <!--  페이징--> 
   <c:if test="${not empty paginationInfo}">
         <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
      </c:if>
      <input type="hidden" id="currentPageNo" name="currentPageNo"/>
   <form id="commonForm" name="commonForm"></form>
   <script type="text/javascript">
      function fn_search(pageNo){
         var comSubmit = new ComSubmit();
         comSubmit.setUrl("<c:url value='/admin/noticeList.sosu' />");
         comSubmit.addParam("currentPageNo", pageNo);
         comSubmit.submit();
      }
   </script>
</div>
</body>
</html>