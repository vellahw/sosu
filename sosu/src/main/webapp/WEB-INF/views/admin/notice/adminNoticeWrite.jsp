<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<!-- <script type="text/javascript">

$(document).ready(function(){
   
   $('#write').on('click',function(e){
      var title = $('#title').val();
      var content = $('#content').val();
      
      if(title == null || title == ''){
         alert("제목을 입력해주세요");
         $('#title').focus();
         return false;
      }
      
      if(content = null || content ==''){
         alert("내용을 입력해주세요");
         $('#content').focus();
         return false;
      }
   })
   
})

function fnChkByte(obj, maxByte)
{
    var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
            rbyte += 3;                                         //한글2Byte
        }else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }
     if(rbyte > maxByte)
     {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
     }
     else
     {
        document.getElementById('byteInfo').innerText = rbyte;
     }
}

</script> -->
<script type="text/javascript">

$(document).ready(function(){
   
   $('#write').on('click',function(e){
      var title = $('#title').val();
      var content = $('#content').val();
      
      if(title == null || title == ''){
         alert("제목을 입력해주세요");
         $('#title').focus();
         return false;
      }
      
      if(content = null || content ==''){
         alert("내용을 입력해주세요");
         $('#content').focus();
         return false;
      }
      
      
      
      var maxByte=2000;
      
         var txt = $('#content').val();
         
         txt = txt.replace(/(?:\r\n|\r|\n)/g, '<br>');
         
         var rbyte = txt.length;
         
         if(rbyte > maxByte)
           {
              alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
              return false;
           }
         if(rbyte < maxByte){
              $('#content').val(txt);
           }
         
      
      
      
      
   })
   
})



function fnChkByte(obj, maxByte){
         //obj.value.replace(/(?:\r\n|\r|\n)/g, '<br>');
   var str = obj.value;
    var str_len = str.length; 


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
    
    
   console.log(str);

    for(var i=0; i<str_len; i++) {   
       one_char = str.charAt(i);
      
        if(escape(one_char).length > 4) {
           rbyte+=3;
        }
        else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        
       if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
         
     }
    /* if(one_char!='<br>'){
      document.getElementById("content").innerHTML = str;
           
   } */
     if(rbyte > maxByte)
     {
       
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
     } 

     
}

</script>

<script>

$(document).ready(function(){
   
   $('#write').on('click',function(e){
      
   }
})
</script>


<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/qna.css" rel="stylesheet">
<link href="/resources/css/join.css" rel="stylesheet">

</head>
<body>


<div class="container" style="text-align:center;">
<h1 style="margin-top:50px; margin-bottom:40px">공지사항 작성</h1>
<form action="/admin/noticeWrite.sosu" method="post">


<table class="input-form" >
   <colgroup>
   <col style="width:150px;">
   <col style="width:auto;">
   </colgroup>
      
      <tbody>
         <tr>
            <th class="header"><label for="m_name" >제목</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="N_TITLE" id="title"></td>
         </tr>   
         
         <tr>
            <th class="header"><label for="m_name" >내용</label><span style="color:#fd8731;">*</span></th>
            <td class="contents">
            
            <textarea name="N_CONTENT" onkeyUp="javascript:fnChkByte(this,'2000')" class="noticeupdatecontent" id="content" style="color:black"></textarea>
           
            </td>
         </tr>
   </tbody>
   </table>
<b id="aa"></b>

<input type="submit" value="작성" class="btn" id="write">

</form>
</div>


</body>
</html>