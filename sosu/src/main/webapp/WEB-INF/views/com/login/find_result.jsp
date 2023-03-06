<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/login.css" rel="stylesheet">
</head>
<body>

<div class="container" style="text-align:center; padding: 108px 0 220px 0;">
   <c:choose>
      <c:when test="${M_EMAIL != null and findId eq null }">
         <h1 style="margin-top:50px; margin-bottom:40px">FIND ID</h1>
         <p class="find-p">
         당신의 이메일(아이디)는 "
         <span class="find-result">${M_EMAIL}</span>
         " 입니다. </p>
      </c:when>
         
      <c:when test="${M_EMAIL == null and findId ne null}">
         <h1 style="margin-top:50px; margin-bottom:40px">FIND ID</h1>
         <p class="find-p">
         <p class="find-p">
            아이디를 찾을 수 없습니다
         </p>
      </c:when>
      
      <c:when test="${M_PW != null and findPw eq null}">
         <h1 style="margin-top:50px; margin-bottom:40px">FIND PW</h1>
            <p class="find-p">
            당신의 비밀번호는 "
            <span class="find-result">${M_PW}</span>
            " 입니다. 
      </c:when>
      
      <c:when test="${M_PW == null and findPw ne null}">
         <h1 style="margin-top:50px; margin-bottom:40px">FIND PW</h1>
         <p class="find-p">
         <p class="find-p">
            비밀번호를 찾을 수 없습니다
         </p>
      </c:when>
      
   </c:choose>

   <div>
      <a href="/members/loginform.sosu"  class="btn-a">확인</a>
   </div>
</div>



</body>
</html>