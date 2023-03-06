<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/resources/css/list.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body>
<input type="hidden" value="${MO_CATEGORY }" id="mo_cate">
<input type="hidden" value="${sessionss}" id="session">

<div class="container" style="margin-top:75px;">
   <div class="row gy-5" style="margin-bottom: 55px;">
               <div style="float: left; font-size: 14.5px;">
               <select onchange="location.href=(this.value);">
                  <option value="/moim/culture.sosu" <c:if test="${MO_CATEGORY == 'culture'}">selected="selected"</c:if>>문화/예술</option>
                  <option value="/moim/sports.sosu" <c:if test="${MO_CATEGORY == 'sports'}">selected="selected"</c:if>>운동/스포츠</option>
                  <option value="/moim/game.sosu" <c:if test="${MO_CATEGORY == 'game'}">selected="selected"</c:if>>게임/오락</option>
                  <option value="/moim/outdoor.sosu" <c:if test="${MO_CATEGORY == 'outdoor'}">selected="selected"</c:if>>아웃도어/여행</option>
                  <option value="/moim/food.sosu" <c:if test="${MO_CATEGORY == 'food'}">selected="selected"</c:if>>음식</option>
                  <option value="/moim/etc.sosu" <c:if test="${MO_CATEGORY == 'etc'}">selected="selected"</c:if>>기타</option>
               </select>
               
                <div class="reg">
               <button onclick="location.href='/moim/${MO_CATEGORY}.sosu'" class="mrgbtn22">전체</button>
                <form action="/moim/${MO_CATEGORY}.sosu?MO_REGION=${MO_REGION}" style="display: inline;">
                   <button type="submit" value="중부" name="MO_REGION" class="mrgbtn22">중부</button>
                   <button type="submit" value="동부" name="MO_REGION" class="mrgbtn22">동부</button>
                   <button type="submit" value="서부" name="MO_REGION" class="mrgbtn22">서부</button>
                   <button type="submit" value="남부" name="MO_REGION" class="mrgbtn22">남부</button>
                   <button type="submit" value="북부" name="MO_REGION" class="mrgbtn22">북부</button>
                </form>
                </div>
                
                <span style="padding-left: 14px;">현재 모임<strong style="color:#fd8731;">&nbsp;${count.MO_COUNT}</strong>개</span>

                  <%if(session.getAttribute("M_IDX")!=null){ %>
                  <button type="button" onclick="location.href='/moim/moimRegister.sosu'" class="mrgbtn" style="float: right; margin-right: 19px;">모임 개설하기</button>
             <% } %>
              
               </div>
      
      <div class="row gy-5">
         <div class="col" style="margin-top: 5px; margin-bottom: 20px;">
            <hr>
         </div>
      </div>
   
      <c:choose>
            <c:when test="${fn:length(list) > 0 }">
               <c:forEach items="${list}" var = "m" varStatus = "var">
                 <%@ include file="../moim/include_MSL.jsp" %>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <div class="row gy-5" style="height: 165px; margin-bottom: 12px;">
                <div class="none">
               조회된 결과가 없습니다.
            </div>   
      </div>
            </c:otherwise>
         </c:choose>
         
   <!-- 페이징 -->
   <div class="page_wrap">
   <div class="page_nation">
      <ul>
         <c:if test="${pageMaker.prev}">
            <li class="arrow prev">
               <a href="${pageMaker.startPage - 1 }"></a>
            </li>
         </c:if>
         
         <c:if test="${pageMaker.cri.MO_REGION eq null}">         
         <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li ${pageMaker.cri.pageNum == num ? "active":""}>
               <a href="/moim/${MO_CATEGORY}.sosu?pageNum=${num}" 
                  <c:if test="${pageMaker.cri.pageNum == num}">class="act"</c:if>>${num}</a>
            </li>
         </c:forEach>
         </c:if>
                  
         <c:if test="${pageMaker.cri.MO_REGION eq pageMaker.cri.MO_REGION and pageMaker.cri.MO_REGION ne null}">         
         <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li ${pageMaker.cri.pageNum == num ? "active":""}>
               <a href="/moim/${MO_CATEGORY}.sosu?MO_REGION=${pageMaker.cri.MO_REGION}&pageNum=${num}"
                  <c:if test="${pageMaker.cri.pageNum == num}">class="act"</c:if>>${num}</a>
            </li>
         </c:forEach>
         </c:if>
                           
         <c:if test="${pageMaker.next}">
            <li class="arrow next">
               <a href="${pageMaker.endPage + 1 }"></a>
            </li>
         </c:if>
      </ul>   
   </div>
   </div>
   </div>
   

   </div>
</body>
</html>