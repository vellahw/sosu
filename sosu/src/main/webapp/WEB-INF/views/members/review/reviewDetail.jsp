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

<style>
.profile {
    width: 48px;
    height: 48px;
    border-radius: 24px;
    overflow: hidden;
}

.pror{
    display: flex;
    justify-content: flex-start;
    margin-top: 15px;
}

.rv{
   width:300px;
   height:300px;
}
</style>

<div class="container" style="text-align: center;width: 1000px;margin: 80px auto;">
   
   

   <p style="font-size: 20px;font-weight: bold;">
    ${map.MO_TITLE}
    </p>
     <hr>
    
   <div class="pror">
   <img src="${pageContext.request.contextPath}/resources/img/upload/${map.KPROFILE}" class="profile" >
      <div style="margin-left: 20px;">
      ${map.M_NICKNAME}

      <p style="color: #ffc81e; margin-top:0px">
            <c:if test="${map.RV_STAR eq 1}"><c:out value="★☆☆☆☆"/></c:if> 
            <c:if test="${map.RV_STAR eq 2}"><c:out value="★★☆☆☆" /></c:if> 
            <c:if test="${map.RV_STAR eq 3}"><c:out value="★★★☆☆" /></c:if> 
            <c:if test="${map.RV_STAR eq 4}"><c:out value="★★★★☆" /></c:if>
            <c:if test="${map.RV_STAR eq 5}"><c:out value="★★★★★" /></c:if>
         </p>
         
         </div>
      </div>
      <hr>
     
          
            <div>
            <p style="    font-weight: bold;font-size: 17px;padding: 10px;">제목 <span style="margin-left: 35px;">${map.RV_TITLE }</span>
                  <p style="    font-weight: bold;font-size: 17px;padding: 10px;">내용 <span style="margin-left:35px;">${map.RV_CONTENT}</span></p>
               </div>
               <br><br>
               <img class="rv" src="${pageContext.request.contextPath}/resources/img/upload/${list[0].F_SVNAME}">
               <br><br><br>
               
               
               <div style="width:100%;">
               <a href="/review/${map.MO_CATEGORY}.sosu" class="mrgbtn" style = "margin-right: 5px; padding: 0px 6px 3px 7px;">목록으로</a>
               <c:if test="${sessionss eq map.M_IDX}">
               <a href="/reviewModify/${map.MO_CATEGORY}/${RV_IDX}.sosu" class="mrgbtn" style = "margin-right: 5px; padding: 0px 6px 3px 7px;">수정하기</a>
               <form action="/review/delete.sosu" method="post" onsubmit="return confirm('삭제하시겠습니까?');" style="width: 56px;display: contents;">
               <input type="hidden" name="RV_IDX" value="${map.RV_IDX}">
               <input type="submit" value="삭제" class="mrgbtn" ></form>
               </c:if>
               </div>
</div>
     
            
         