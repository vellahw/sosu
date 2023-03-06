<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script defer type="text/javascript" src="/resources/js/login.js"></script>
<link href="/resources/css/login.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){

    $('#loginform').on('click',function(e){
       var email = $('#m_email').val();
       var password = $('#m_pw').val();
          
       
       if(email==null || email==''){
          alert("이메일을 입력해주세요");
          $('#m_email').focus();
          return false;   
       }
       if(password==null || password==''){
         alert("비밀번호를 입력해주세요");
          $('#m_pw').focus();
          return false;
       }
       
       if((email != null || email !='')&&(password != null || password !='')){
          $.ajax({
             url : "/members/checklogin.sosu",
             type : "post",
             contentType : "application/json",
             data : JSON.stringify(
                {M_EMAIL : email, M_PW : password}
             ),
             dataType : 'json',
             success : function(result){
                if(result==0){
                   alert("아이디가 존재하지 않습니다.");
                   return false;
                }else if(result==1){
                   alert("비밀번호가 틀렸습니다.");
                   return false;
                }else{
                   this.form.submit();
                }
             }
            });
       }   
    });  
 });
 </script>
</head>
<body>

<div class="container" style="text-align:center; padding-bottom:182px;">

<h1 style="margin-top:50px; margin-bottom:40px">LOGIN</h1>

<form action="/members/login.sosu" method="post">
   
   <table class="input-form" >
   <colgroup>
         <col style="width:20%;">
         <col style="width:80%;">
      </colgroup>
   <thead></thead>
   <tbody>
      <tr>
         <th class="header"><label for="m_email" >이메일</label></th>
         <td class="contents"><input type="text" name="M_EMAIL" id="m_email"></td>
      </tr>
      
      <tr>
      <th class="header" style="font-size:15px"><label for="m_pw">비밀번호</label></th>
      <td class="contents"><input type="password" name="M_PW" id="m_pw"></td>
      </tr>
      
      <tr>
         <td colspan="2" align="center" height="25"></td>
      </tr>
      
      <tr>
         <td colspan="2" align="center">
         <input type="submit" value="로그인" id="loginform" class="btn-login">
         </td>
      </tr>
      
      <tr>   
         <td colspan="2" align="center">
         <a href="/members/joinform.sosu" class="btn-a">회원가입</a>
         <a href="/members/findidform.sosu"  class="btn-a">아이디찾기</a>
         <a href="/members/findpwform.sosu"  class="btn-a">비밀번호 찾기</a></td>
      
		</tbody>
   </table>
</form>

</div>

</body>
</html> 