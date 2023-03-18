<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/css/qna.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){

   $('#qnaRegister').on('click',function(e){
         var title = $('#title').val();
         var content = $('#content').val();
         var q_private = $('#q_private').val();
         
         if(title==null || title==''){
            alert("제목을 입력해주세요");
            $('#title').focus();
            return false;
         }
         
         if(content==null || content==''){
            alert("내용을 입력해주세요");
            $('#content').focus();
            return false;
         }
      
   });      

});

</script>

<meta charset="UTF-8">
</head>
<body>

<div class="container" style="text-align:center;">
<h3 class="a-tag-h3"><a href="/notice/noticeList.sosu" class="a-tag" style="color:gray">NOTICE</a>&nbsp;&nbsp;&nbsp;<a href="/qna/qnalist.sosu" class="a-tag">QNA</a></h3>
<hr style="width:50%">
<h1 style="margin-bottom:40px">QNA 작성</h1>

   <form action="/qna/insertqna.sosu" method="post">
   
    <table class="input-form" >
      <colgroup>
      <col style="width:150px;">
      <col style="width:auto;">
         </colgroup>
         
         <tbody>
            <tr>
               <th class="header"><label for="title" >제목</label><span style="color:#fd8731;">*</span></th>
               <td class="contnets"><input type="text" name="Q_TITLE" id="title"></td>
            </tr>
            
            <tr>
               <th class="header"><label for="content" >내용</label><span style="color:#fd8731;">*</span></th>
               <td class="contnets"><textarea name="Q_CONTENT" id="content" style="height:200px;"></textarea></td>
            </tr>
            
            <tr>
               <th class="header"><label for="content" >공개 여부 선택</label><span style="color:#fd8731;">*</span></th>
               <td class="contnets">
                        <input type="radio" id="huey" name="Q_PRIVATE" value="0" checked style="width:50px; ">
                        <label for="huey" style="vertical-align:super">공개</label>
               
                        <input type="radio" id="dewey" name="Q_PRIVATE" value="1" style="width:50px">
                        <label for="dewey" style="vertical-align:super">비공개</label>
               </td>
            </tr>
         </tbody>
   
</table>


<div style="margin-top:40px">
<input type="button" value="취소" onclick="location.href='/qna/qnalist.sosu'" class="brtn" style="background-color: #000; margin: 4px;">
<input type="submit" value="등록" id="qnaRegister" class="brtn">
</div>

</form>

</div>







</body>
</html>