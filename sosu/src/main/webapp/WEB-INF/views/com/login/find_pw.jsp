<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/login.css" rel="stylesheet">
</head>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
   
   $('#findPw').on('click',function(e){
      
      var name = $('#m_name').val();
      var email = $('#m_email').val();
      var jumin = $('#m_jumin').val();
      
      if(name==null || name==''){
            alert("이름을 입력해주세요");
            $('#m_name').focus();
            return false;   
       }
      if(email==null || email==''){
            alert("이메일을 입력해주세요");
            $('#m_email').focus();
            return false;   
       }
      if(jumin==null || jumin==''){
            alert("주민번호를 입력해주세요");
            $('#m_jumin').focus();
            return false;   
       }
   })
   
})


</script>

<body>
<div class="container" style="text-align:center; padding-bottom:175px">

<h1 style="margin-top:50px; margin-bottom:40px">FIND PW</h1>

<form action="/members/findpw.sosu" method="POST">
   <table class="input-form" >
   <colgroup>
         <col style="width:100px;">
         <col style="width:auto;">
      </colgroup>
      <thead></thead>
      <tbody>   
           <tr>
            <th class="header"><label for="m_name">이름</label></th>
            <td class="find-contents"  colspan="2" >
               <input type="text" name="M_NAME" id="m_name">
            </td>
         </tr>
         
         <tr>
            <th class="header"><label for="m_email">이메일</label></th>
            <td class="find-contents"  colspan="2" >
            <input type="text" name="M_EMAIL" id="m_email">
            </td>
         </tr>
         
         <tr>
            <th class="header"><label for="m_jumin">주민번호</label></th>
            <td class="find-contents" colspan="2" >
            <input type="text" name="M_JUMIN" id="m_jumin" maxlength="6">
            </td>
         </tr>
         
         <tr>
            <td colspan="3" align="center">
            <input type="submit" id="findPw" value="비밀번호 찾기" class="btn-login">
            </td>
         </tr>   
         <tr>
            <td colspan="3" align="center">
            <a href="/members/loginform.sosu"  class="btn-a">취소</a>
            </td>
         </tr>
   
   </tbody>
   </table>
   
</form>

   
</div>
</body>
</html>