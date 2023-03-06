<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html>
<head>
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
}
$(document).ready(function(){
      $('#loginGo').on('click',function(){
         alert("로그인 창으로 이동합니다.");
      })
   });

</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container" style="text-align:center; width: 1422px; margin: 80px auto;">
<h3 class="a-tag-h3"><a href="/notice/noticeList.sosu" class="a-tag" style="color:gray">NOTICE</a>&nbsp;&nbsp;&nbsp;<a href="/qna/qnalist.sosu" class="a-tag">QNA</a></h3>
<h1 style="margin-bottom:40px">QNA</h1>
<c:if test="${myMIDX eq null}">
      <input type="button" id="loginGo" onclick="location.href='/members/loginform.sosu'" value="QNA 작성" class="qna-btn">
   </c:if>
   <c:if test="${myMIDX ne null}">
      <input type="button" onclick="location.href='/qna/qnaform.sosu'" value="QNA 작성" class="qna-btn">
   </c:if>
<hr style="width:55%; background:gray; height:1px; border:0;">
   

<c:if test="${qnaList[0].Q_CONTENT ne null }">
<!-- 닫혀 있을 때 보이는 부분 -->
<c:forEach begin="0" end="${fn:length(qnaList)}" items="${qnaList}" var="qnaList">
   <c:if test="${qnaList.Q_PRIVATE eq '1' and myMIDX ne qnaList.M_IDX and ADMIN eq NULL}">
       <button type="button" class="collapsible" onclick="collapse(this);" disabled>
             <p>
               <c:if test="${qnaList.C_CONTENT ne null}">
                     <span class="done-reply">답변완료</span>
               </c:if>
               <c:if test="${qnaList.C_CONTENT eq null}">
                     <span class="wait-reply">답변대기</span>
               </c:if>
               <span><img class="img-size" src="/resources/img/icons/lock.png"><span style="margin-left:10px">비밀글입니다.</span></span>
            </p>
       </button>
      </c:if>

      <c:if test="${qnaList.Q_PRIVATE eq '0' or (qnaList.Q_PRIVATE eq '1' and ADMIN ne NULL) or (qnaList.Q_PRIVATE eq '1' and qnaList.M_IDX eq myMIDX)}">
       <button type="button" class="collapsible" onclick="collapse(this);">
             <div>
                <p>
                   <c:if test="${qnaList.C_CONTENT ne null}">
                        <span class="done-reply">답변완료</span>
                  </c:if>
                  <c:if test="${qnaList.C_CONTENT eq null}">
                        <span class="wait-reply">답변대기</span>
                  </c:if>
                   <span>${qnaList.Q_TITLE}</span>
                      
                   <span style="float: right;"><fmt:formatDate value="${qnaList.Q_REGDATE}" pattern="yyyy-MM-dd"/></span>
                </p>
             
         </div>
   
   </button>
   
   </c:if>

    <div class="content">
    
       <p class="nickname">${qnaList.M_NICKNAME}</p>
        <p class="q-content">${qnaList.Q_CONTENT}</p>          
      
      <div class="admin-reply">
   <c:if test="${qnaList.C_CONTENT ne NULL}">
        <p class="nickname">관리자 </p>
        <p class="q-content"> ${qnaList.C_CONTENT}</p>
        <p class="q-content" style="font-size:11px;"><fmt:formatDate value="${qnaList.C_REGDATE}" pattern="yyyy-MM-dd"/>작성 </p>
    </c:if>
    </div>
           
                    <c:if test="${qnaList.M_IDX eq myMIDX or ADMIN ne NULL}">
                     <form action="/qna/deleteqna.sosu" method="post" style="float:right; width:20px;">
                        <input type="submit" value="삭제" class="deleteqna">
                        <input type="hidden" name="Q_IDX" value="${qnaList.Q_IDX}" >
                     </form>
                  </c:if>
    
    
    </div>
    
        <hr style="width:55%">
    
    </c:forEach>
</c:if>   
    
    
    
    
    <!-- 페이징 -->
<c:if test="${not empty paginationInfo}">
      <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
   </c:if>
   <input type="hidden" id="currentPageNo" name="currentPageNo"/>
<form id="commonForm" name="commonForm"></form>
<script type="text/javascript">
   function fn_search(pageNo){
      var comSubmit = new ComSubmit();
      comSubmit.setUrl("<c:url value='/qna/qnalist.sosu' />");
      comSubmit.addParam("currentPageNo", pageNo);
      comSubmit.submit();
   }
</script>
    
    
    
    
  
   
</div>
</body>
</html>