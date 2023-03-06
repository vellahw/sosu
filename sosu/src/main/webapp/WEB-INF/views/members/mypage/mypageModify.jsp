<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script defer type="text/javascript" src="/resources/js/mypageModify.js"></script>
<link href="/resources/css/join.css" rel="stylesheet">
<link href="/resources/css/mypagemodify.css" rel="stylesheet">
</head>

<body>


<div class="container" style="text-align:center">
<h1 style="margin-top:50px; margin-bottom:40px">MY PAGE MODIFY</h1>
	
	<form action="/members/mypagemodify.sosu" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${modify.M_IDX }" name="M_IDX" id="M_IDX">
	<input type="hidden" id="delete_result" name="GenderCheck"  value="0"> 
	<input type="hidden" value="${modify.M_GENDER }" id="m_gender">
	<input type="hidden" id="pwSameCheck" value='0'>
   <input type="hidden" id="nickCheck" value='1'>
			
			<table class="input-form">
			<colgroup>
				<col style="width:150px;">
				<col style="width:auto;">
			</colgroup>
				
				<tbody>
					<tr>
						<th class="header"><img src="${pageContext.request.contextPath}/resources/img/upload/${profileGet.F_SVNAME}" id="img1" class="img-promodi" ></th>
						<td class="contents"><input type="file" name="file" id="file" class="file-modi">
						<input type="button" value="삭제" id='delete' class="dbtn"></td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_name">이름</label></th>
						<td class="contents"><input type="text" value="${modify.M_NAME}" name="M_NAME" id="m_name">
						<c:choose>
							<c:when test="${modify.M_GENDER eq 1 or  modify.M_GENDER eq 3}">
								<button id="male" class="btn-gender" disabled="disabled">남</button>
							</c:when>
							<c:otherwise>
								<button id="female" class="btn-gender" disabled="disabled">여</button>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_nickname">닉네임</label></th>
						<td class="contents"><input type="text" value="${modify.M_NICKNAME}" name="M_NICKNAME" id="m_nickname">
						<input type="hidden" id="check" value='중복확인' class="checkbtn">
						</td>
					</tr>
					
					 <tr>
         				<td></td>
            			<td>
            			<div class="double_check_result" id="nickname_check_result"></div>
            			</td>
        			</tr>
					
					<tr>
						<th class="header"><label for="m_email">아이디(EMAIL)</label></th>
						<td class="contents"><input type="text" value="${modify.M_EMAIL}" readonly></td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_pw">비밀번호</label></th>
						<td class="contents"><input type="password" value="${modify.M_PW}" name="M_PW" id="m_pw"></td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_pw2">비밀번호 확인</label><span style="color:#fd8731;">*</span></th>
						<td class="contents"><input type="password" name="M_PW2" id="m_pw2"></td>
					</tr>
					
			         <tr>
			            <td></td>
			            <td>
			               <div class="pwCheck" id="pwCheck"></div>
			            </td>
			         </tr> 					
					
					<tr>
						<th class="header"><label for="m_phone">휴대전화</label></th>
						<td class="contents"><input type="text" value="${modify.M_PHONE }" name="M_PHONE" id="m_phone"></td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_jumin">주민등록번호</label></th>
						<td class="contents">
							<input type="text" value="${modify.M_JUMIN}" name="M_JUMIN" maxlength="6" style="width:200px;"  id="m_jumin"> -
							<input type="text" value="●" style="width:19px;" readonly ><span class="c">●●●●●●</span>
						</td>
					</tr>
					
					<tr>
						<th class="header"><label for="m_que">질문</label></th>
						<td class="contents que-modi">
							 <select name="M_QUE" id="m_que">
						      <option value="${modify.M_QUE}" hidden="hidden">
						         <c:if test="${modify.M_QUE eq '1'}">기억에 남는 추억의 장소는?</c:if>
						         <c:if test="${modify.M_QUE eq '2'}">자신이 세번째로 존경하는 인물은?</c:if>
						         <c:if test="${modify.M_QUE eq '3'}">내가 좋아하는 캐릭터는?</c:if>
						         <c:if test="${modify.M_QUE eq '4'}">다시 태어나면 되고 싶은 것은?</c:if>
						         <c:if test="${modify.M_QUE eq '5'}">초등학교 때 기억에 남는 짝꿍 이름은?</c:if>
						         <c:if test="${modify.M_QUE eq '6'}">인상깊게 읽은 책 이름은?</c:if>
						      </option>
						      <option value="">질문을 선택해 주세요.</option>
						      <option value="1">기억에 남는 추억의 장소는?</option>
						      <option value="2">자신이 세번째로 존경하는 인물은?</option>
						      <option value="3">내가 좋아하는 캐릭터는?</option>
						      <option value="4">다시 태어나면 되고 싶은 것은?</option>
						      <option value="5">초등학교 때 기억에 남는 짝꿍 이름은?</option>
						      <option value="6">인상깊게 읽은 책 이름은?</option>
						   </select>
						<input type="text" name="M_ANS" value="${modify.M_ANS }" style="width:200px;" id="m_ans"></td>
					</tr>
				</tbody>
</table>
<div style="margin-top: 40px;">
<input type="button" value="취소" class="btn-bottom" style="background-color: #000; margin: 4px;" onclick="location.href='/members/mypage.sosu'">
<input type="submit" value="수정" class="btn-bottom" id="modify" style="margin: 4px;">
<input type="button" value="탈퇴" class="btn-bottom" id="deleteMem" style="margin: 4px;" >
</div>


</form>
</div>
</body>
</html>