<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="/resources/js/common.js"></script>
<script defer type="text/javascript" src="/resources/js/zzim.js"></script>
<head>
<link href="/resources/css/list.css" rel="stylesheet">
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">

<meta charset="UTF-8">
<title>소수 자유게시판</title>
</head>
<main>
   <article>
      <input type="hidden" value="${FR_CATEGORY }" id = "cate">
      <input type="hidden" value="${sessionss}" id = "session" name = "M_IDX">

      <div class="container" style="margin-top:75px;">
      <div class="row gy-5" style="margin-bottom: 90px;">
         <div class="container">
         <div class="row gy-5">
            <div class="col">
               <div style="float: left; font-size: 14.5px;">
                  <select onchange="location.href=(this.value);" >
                     <option value="/freeboard/culture.sosu" <c:if test="${FR_CATEGORY == 'culture' }">selected="selected"</c:if>>문화/예술</option>
                     <option value="/freeboard/sports.sosu" <c:if test="${FR_CATEGORY == 'sports' }">selected="selected"</c:if>>운동/스포츠</option>
                     <option value="/freeboard/game.sosu" <c:if test="${FR_CATEGORY == 'game' }">selected="selected"</c:if>>게임/오락</option>
                     <option value="/freeboard/outdoor.sosu" <c:if test="${FR_CATEGORY == 'outdoor' }">selected="selected"</c:if>>아웃도어/여행</option>
                     <option value="/freeboard/food.sosu" <c:if test="${FR_CATEGORY == 'food' }">selected="selected"</c:if>>음식</option>
                     <option value="/freeboard/etc.sosu" <c:if test="${FR_CATEGORY == 'etc' }">selected="selected"</c:if>>기타</option>
                  </select>
               </div>
            </div>
         </div>
      
      <%if(session.getAttribute("M_IDX")!=null){ %>
      <div style="text-align: right; margin-top: 20px">
         <button type="button" onclick="location.href='/freeboard/insertForm/${FR_CATEGORY }.sosu'" class="mrgbtn">글쓰기</button>
      </div>
      <% } %>
      
      <div class="row gy-5">
         <div class="col" style="margin-top: 5px; margin-bottom: 20px;">
            <hr>
         </div>
      </div>
      </div>
      
         <c:choose>
            <c:when test="${fn:length(list) > 0 }">
               <c:forEach items="${list }" var = "f">
            <div class="col-lg-3 menu-item"
                         style="cu">
                        <div class="row gy-5" style="padding-left: 11px;" onclick="location.href='/freeboard/${f.FR_CATEGORY}/${f.FR_IDX}.sosu'">
                           <c:if test="${f.FF_SVNAME ne '0' }">
                              <img class="mimg" style="width: 300px;"
                                 src="${pageContext.request.contextPath}/resources/img/upload/${f.FF_SVNAME}"
                                 alt="${f.FF_SVNAME}">
                           </c:if>
                           <c:if test="${f.FF_SVNAME eq '0' }">
                              <img src="/resources/img/icons/list.png" class="mimg"
                                 style="width: 300px;">
                           </c:if>
                           <br />

                           <p style="margin-top: 10px;">
                              <img class="kingimg" src="/resources/img/upload/${f.PROFILE }"
                                 alt="profile"> <span
                                 style="padding-left: 8px; float: left; padding-top: 8px;">${f.M_NICKNAME}</span>
                           </p>

                           <p class="moim-title"
                              style="margin-top: 2px; width: 100%; padding-left: 2px;">
                              ${f.FR_TITLE}
                           </p>
                           <input type="hidden" value="${f.FR_IDX}">
                           <input type="hidden" value="${f.M_IDX}">
                     </div>
                           <p class="mo-cost" style="transform: translate(0px, -66px);">   
                              <c:if
                                 test="${sessionss eq null or sessionss ne null and f.FZ_CHECK eq '0'}">
                                 <input type="hidden" name="FR_IDX" value="${f.FR_IDX}">
                                 <button type="button" class="hhhbtn"
                                    style="margin-right: 17px;"
                                    onclick="return FrinsertHeart(${f.FR_IDX})">
                                    <img alt="heart" src="/resources/img/icons/like.png"
                                       width="32px;">
                                 </button>
                                 <span class="mzcount"
                                    style="transform: translate(43%, -25px);">${f.FRZ_COUNT}</span>
                              </c:if>
                              <c:if test="${sessionss ne null and f.FZ_CHECK ne '0'}">
                                 <input type="hidden" name="MO_IDX" value="${f.FR_IDX}">
                                 <button type="button" class="hhhbtn"
                                    style="margin-right: 17px;"
                                    onclick="return FrdeleteHeart(${f.FR_IDX})">
                                    <img alt="heart" src="/resources/img/icons/heart.png"
                                       width="32px;">
                                 </button>
                                 <span class="mzcount"
                                    style="transform: translate(43%, -25px);">${f.FRZ_COUNT}</span>
                              </c:if>
                           </p>
                           </div>
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
      <c:if test="${!empty paginationInfo}">
         <div class="paging">
            <ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="paging" />
         </div>
      </c:if>
      </div>
      </div>
   </article>
</main>