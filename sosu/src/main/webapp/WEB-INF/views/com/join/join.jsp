<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script defer type="text/javascript" src="/resources/js/join.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/join.css" rel="stylesheet">
</head>

<body>
<div class="container" style="text-align:center">
<h1 style=" margin-top: 50px; margin-bottom: 40px;">JOIN</h1>

   <form action="/members/join.sosu" method="post">
   <input type="hidden" id="doubleCheck" value='0'>
   <input type="hidden" id="pwSameCheck" value='0'>
   
   <input type="hidden" id="nickCheck" value='0'>
      
      <table class="input-form" >
   <colgroup>
   <col style="width:150px;">
   <col style="width:auto;">
   </colgroup>
      
      <tbody>
         <tr>
            <th class="header"><label for="m_name" >이름</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="M_NAME" id="m_name"></td>
         </tr>   
         
         <tr>
            <th class="header"><label for="m_nickname" >닉네임</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="M_NICKNAME" id="m_nickname">
            <button type="button" id="check" value='중복확인' class="dbtn">중복확인</button></td>
         </tr>
         
         <tr>
         <td></td>
            <td>
            <div class="double_check_result" id="nickname_check_result"></div>
            </td>
         </tr>
            
         <tr>
            <th class="header"><label for="m_email" >아이디</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="M_EMAIL" id="m_email" placeholder="이메일 형식으로 입력해주세요.">
            <button type="button" id="double" value='중복확인' class="dbtn">중복확인</button> <!-- 팝업창 --></td>
         </tr>   
         
         <tr>
         <td></td>
            <td>
            <div class="double_check_result" id="double_check_result"></div>
            </td>
         </tr>
         
         <tr>
            <th class="header"><label for="m_pw" >비밀번호</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="password" name="M_PW" id="m_pw"></td>
         </tr>   
            
         <tr>
            <th class="header"><label for="m_pw2" >비밀번호 확인</label></th>
            <td class="contents"><input type="password" name="M_PW2" id="m_pw2"></td>
         </tr>   
         <tr>
            <td></td>
            <td>
               <div class="pwCheck" id="pwCheck"></div>
            </td>
         </tr>   
         
         <tr>
            <th class="header"><label for="m_phone" >휴대전화</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="M_PHONE" id="m_phone"></td>
         </tr>   
         
         <tr>
            <th class="header"><label for="m_jumin" >주민등록번호</label><span style="color:#fd8731;">*</span></th>
            <td class="contents">
               <input type="text" name="M_JUMIN" id="m_jumin" maxlength="6" style="width:200px;"> -
               <input type="text" name="M_GENDER" id="m_gender" maxlength="1" style="width:19px;"> <span class="c">●●●●●●</span>
            </td>
         </tr>   
            
         <tr>
            <th class="header"><label for="m_que" >질문</label><span style="color:#fd8731;">*</span></th>
            <td class="contents">
               <select name="M_QUE" id="m_que">
                  <option value="">질문을 선택해 주세요.</option>
                  <option value="1">기억에 남는 추억의 장소는?</option>
                  <option value="2">자신이 세번째로 존경하는 인물은?</option>
                  <option value="3">내가 좋아하는 캐릭터는?</option>
                  <option value="4">다시 태어나면 되고 싶은 것은?</option>
                  <option value="5">초등학교 때 기억에 남는 짝꿍 이름은?</option>
                  <option value="6">인상깊게 읽은 책 이름은?</option>
               </select>
            <input type="text" name="M_ANS" id="m_ans" placeholder="입력" style="width:200px;">
            </td>
         </tr>   
         </tbody>
         </table>
         
         <div style="margin-top: 40px;">
         <input type="reset" value="다시작성" class="btn" style="background-color: #000; margin: 4px;">
         <input type="submit" value="회원가입" id="join" class="btn">
         </div>
      </form>
   </div>


</body>
</html>