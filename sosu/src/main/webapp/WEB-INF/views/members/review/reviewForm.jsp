<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>   
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="/resources/js/review.js"></script>
<link href="/resources/css/form.css" rel="stylesheet">
<link href="/resources/css/detail.css" rel="stylesheet">
<script type="text/javascript">
/* 입력된 바이트(글자수) 값 제어 */
function fn_checkByte(obj) {
   const maxByte = 1800; //최대 100바이트
   const text_val = obj.value; //입력한 문자
   const text_len = text_val.length; //입력한 문자수

   let totalByte = 0;
   for (let i = 0; i < text_len; i++) {
      const each_char = text_val.charAt(i);
      const uni_char = escape(each_char); //유니코드 형식으로 변환
      if (uni_char.length > 4) {
         // 한글 : 2Byte
         totalByte += 3;
      } else {
         // 영문,숫자,특수문자 : 1Byte
         totalByte += 1;
      }
   }

   if (totalByte > maxByte) {
      alert('최대 1800Byte까지만 입력가능합니다.');
      document.getElementById("nowByte").innerText = totalByte;
      document.getElementById("nowByte").style.color = "red";
   } else {
      document.getElementById("nowByte").innerText = totalByte;
      document.getElementById("nowByte").style.color = "green";
   }
}
</script>

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
</head>
<body>
<div class="container" style="text-align:center; margin-bottom: 100px;">
<h2 style=" margin-top: 90px; margin-bottom: 50px;">리뷰 작성하기</h2>
      <form action="/members/reviewForm.sosu" method="post" name="insertReview" id="insertReview" enctype="multipart/form-data" onsubmit="return check()" >
      <!-- 회원번호 -->
         <input type="hidden" name="M_IDX" value="${M_IDX}">
         <!-- 모임번호 --> 
         <input type="hidden" name="MO_IDX" value="${MO_IDX}">
         <!-- 모임 제목 -->
         <input type="hidden" name="MO_TITLE" value="${MO_TITLE}">
         <!-- 게시글 테이블 타입 -->
         <input type="hidden" name="F_TABLE" value="${F_TABLE}">
         <%-- <h1>${MO_TITLE}</h1> --%>
         
         <div>
         <fieldset>
             <input type="radio" name="RV_STAR" value="5" id="rate1"><label class="starp" for="rate1">⭐</label>
             <input type="radio" name="RV_STAR" value="4" id="rate2"><label class="starp" for="rate2">⭐</label>
             <input type="radio" name="RV_STAR" value="3" id="rate3"><label class="starp" for="rate3">⭐</label>
             <input type="radio" name="RV_STAR" value="2" id="rate4"><label class="starp" for="rate4">⭐</label>
             <input type="radio" name="RV_STAR" value="1" id="rate5"><label class="starp" for="rate5">⭐</label>
         </fieldset>
         </div>
         
   <table class="input-form" >
      <colgroup>
       <col style="width:150px;">
       <col style="width:auto;"> 
       </colgroup>
            
         <tbody>
               <tr>
                  <th class="header"><label for="RV_TITLE" >제목</label><span style="color:#fd8731; margin-left:3px;">*</span></th>
                     <td class="contents"><input type="text" class="form-control" name="RV_TITLE" id="rv_title"
                           placeholder="제목 입력(4-70)" style="width: 754px;"></td>
                 </tr>
                 
                 <tr>
                  <th class="header"><label for="textArea_byteLimit" >내용</label>
                  <span style="color:#fd8731;margin-left:3px;">*</span></th>
                  <td class="contents">
                     <textarea style="width: 100%; resize: none; height: 12.25em; border: 1px solid #e6e6e6; resize: none; padding: 3px 3px 3px 5px; outline: none;" rows="17" class="form-control"  name="RV_CONTENT" placeholder="후기 내용 작성" id="textArea_byteLimit" name="textArea_byteLimit" onkeyup="fn_checkByte(this)" wrap="hard" cols = ""></textarea>
                       <sup style="color: #c2c2c2; float: right; transform: translate(9px, -1px);">(<span id="nowByte">0</span>/1800bytes)</sup>
                  </td>
              </tr> 
            
            
         <!-- <h3>제목</h3>
         <input type="text" name="RV_TITLE" id="rv_title" >

         
         <h3>내용</h3>
         <textarea name="RV_CONTENT" id="rv_content"  placeholder="후기 내용을 작성해주세요."></textarea> -->
         
         
         <tr>
            <th class="header"><label for="file" >이미지 첨부</label></th>
            <td class="contents">
          <div id = "main" style="margin-bottom: 11px;">메인 이미지 <span>
             <input type="file" name="mainIamge" id="file" style="border: none; width: auto;">
            </span>
         </div>
         </td>
         </tr>
         </tbody>
         </table>
      

         
         <div style = "text-align:center;">
         <button type ="submit" class="mrgbtn" style = "margin-right: 5px;">등록</button>
         <a href="/members/mypage.sosu" class="mrgbtn" style = "margin-right: 5px; padding: 0px 6px 3px 7px;">취소</a>
         </div>
      </form>
         </div>
</body>
</html>