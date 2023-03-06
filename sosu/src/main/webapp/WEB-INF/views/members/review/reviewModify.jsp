<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
    
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="/resources/js/review.js"></script>
<link href="/resources/css/form.css" rel="stylesheet">
<link href="/resources/css/detail.css" rel="stylesheet">
<style type="text/css">
input #star { width:100%; }

#insertReview fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    border: 0; /* 필드셋 테두리 제거 */
}
#insertReview input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#insertReview .starp{
    font-size: 3em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
    cursor: pointer; /* 커서 올리면 손가락 표시 */
}

#insertReview label:hover{
    text-shadow: 0 0 0 #ffc83d; /* 마우스 호버 */
}
#insertReview label:hover ~ label{
    text-shadow: 0 0 0 #ffc83d; /* 마우스 호버 뒤에오는 이모지들 */
}
#insertReview fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl; /* 이모지 순서 반전 */
    border: 0; /* 필드셋 테두리 제거 */
}
#insertReview fieldset legend{
    text-align: left;
}
#insertReview input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #ffc83d; /* 마우스 클릭 체크 */
}

</style>

<div class="container" style="text-align:center; margin-bottom: 100px;">
<h2 style=" margin-top: 90px; margin-bottom: 50px;">리뷰 수정하기</h2>

   <form action="/review/reviewModify.sosu" method="post" onsubmit="return check()" name="insertReview" id="insertReview" enctype="multipart/form-data">
      <h1>${map.MO_TITLE}</h1>
      
      <!-- 회원번호 -->
      <input type="hidden" name="M_IDX" value="${map.M_IDX}">
      <!-- 모임번호 --> 
      <input type="hidden" name="MO_IDX" value="${map.MO_IDX}">
      <!-- 리뷰번호 -->
      <input type="hidden" name="RV_IDX" value="${RV_IDX}"> 
      <!-- 선택한 카테고리 -->
      <input type="hidden" id="mo_cate" name="MO_CATEGORY" value="${MO_CATEGORY}">
      
      
      <fieldset>
          <input type="radio" name="RV_STAR" value="5" id="rate1"><label class="starp" for="rate1">⭐</label>
          <input type="radio" name="RV_STAR" value="4" id="rate2"><label class="starp" for="rate2">⭐</label>
          <input type="radio" name="RV_STAR" value="3" id="rate3"><label class="starp" for="rate3">⭐</label>
          <input type="radio" name="RV_STAR" value="2" id="rate4"><label class="starp" for="rate4">⭐</label>
          <input type="radio" name="RV_STAR" value="1" id="rate5"><label class="starp" for="rate5">⭐</label>
      </fieldset>
      <table class="input-form">
      
      <colgroup>
       <col style="width:150px;">
       <col style="width:auto;"> 
       </colgroup>
      
      <tbody>
         <tr>
            <th class="header"><label for="RV_TITLE" >제목</label><span style="color:#fd8731; margin-left:3px;">*</span></th>
            <td class="contents"><input type="text" name="RV_TITLE" id="rv_title" value="${map.RV_TITLE}">
         </tr>
         <tr>
            <th class="header"><label for="textArea_byteLimit" >내용</label>
            <span style="color:#fd8731;margin-left:3px;">*</span></th>
            <td class="contents">
               <textarea style="width: 100%; resize: none; height: 12.25em; border: 1px solid #e6e6e6; resize: none; padding: 3px 3px 3px 5px; outline: none;"
               name="RV_CONTENT" id="rv_content" rows="17" class="form-control" id="textArea_byteLimit"  placeholder="후기 내용 작성">${map.RV_CONTENT}</textarea>
            </td>
         </tr>
      
      </tbody>

      
      
      
      
      
      </table>
      <div id="fileDiv">
         <img class="rv" id="mainImg" src="${pageContext.request.contextPath}/resources/img/upload/${list[0].F_SVNAME}">
         <br>
         메인이미지 변경 <input type="file" id="file" name="mainIamge">
      </div>
      <br/>
      <br/>
      
      <input type="submit" value="수정하기" class="mrgbtn" style = "margin-right: 5px;">
   </form>
</div>