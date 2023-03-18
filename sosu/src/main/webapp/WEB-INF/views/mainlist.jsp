<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/css/list.css" rel="stylesheet">
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css"
   rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<meta charset="UTF-8">
</head>
<body>
   <input type="hidden" value="${sessionss}" id="session">
   <div class="container" style="margin-top: 75px;">

      <!--============== 모임 ==============-->
      <div class="row gy-5" style="margin-bottom: 90px;">
         <div class="container">
            <div class="row gy-5">
               <div class="col">
                  <div style="float: left; font-size: 14.5px;">
                     <select onchange="location.href=(this.value);">
                        <option value="/culture.sosu"
                           <c:if test="${MO_CATEGORY == 'culture'}">selected="selected"</c:if>>문화/예술</option>
                        <option value="/sports.sosu"
                           <c:if test="${MO_CATEGORY == 'sports'}">selected="selected"</c:if>>운동/스포츠</option>
                        <option value="/game.sosu"
                           <c:if test="${MO_CATEGORY == 'game'}">selected="selected"</c:if>>게임/오락</option>
                        <option value="/outdoor.sosu"
                           <c:if test="${MO_CATEGORY == 'outdoor'}">selected="selected"</c:if>>아웃도어/여행</option>
                        <option value="/food.sosu"
                           <c:if test="${MO_CATEGORY == 'food'}">selected="selected"</c:if>>음식</option>
                        <option value="/etc.sosu"
                           <c:if test="${MO_CATEGORY == 'etc'}">selected="selected"</c:if>>기타</option>
                     </select>
                  </div>
                  <%
                  if (session.getAttribute("M_IDX") != null) {
                  %>
                  <div style="text-align: right;">
                     <button type="button"
                        onclick="location.href='/moim/moimRegister.sosu'" class="mrgbtn"
                        style="margin-top: 30px; margin-right: 11px;">모임 개설하기</button>
                  </div>
                  <%
                  }
                  %>
               </div>
            </div>
            <div class="row gy-5">
               <div class="col" style="margin-bottom: 20px;">
                  <hr>
               </div>
            </div>
         </div>


         <!--============== 모임 리스트 4개 ==============-->
         <c:choose>
            <c:when test="${fn:length(molist) > 0 }">
               <p class="ct">
                  모임
               <c:if test="${fn:length(molist) > 4}">
                  <span><a href="/moim/${MO_CATEGORY}.sosu" class="allb">전체보기</a></span>
               </c:if>
               </p>
               <c:forEach items="${molist}" var="m" end="3">
                  <%@ include file="./moim/include_MSL.jsp"%>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <p class="ct">모임</p>
               <div class="row gy-5" style="height: 165px; margin-bottom: 12px;">
                  <br>
                  <div class="none">조회된 결과가 없습니다.</div>
               </div>
            </c:otherwise>
         </c:choose>
      </div>
      <hr>

      <!--============== 리뷰 리스트 4개 ==============-->
      <div class="row gy-5" style="margin-bottom: 90px;">
         <c:choose>
            <c:when test="${fn:length(relist) > 0 }">
               <p class="ct">리뷰
               <c:if test="${fn:length(relist) > 4}">
                   <span><a href="/review/${MO_CATEGORY}.sosu" class="allb">전체보기</a></span>
               </c:if>
               </p>
               <c:forEach items="${relist}" var="r" end="3">
                  <div class="col-lg-3 menu-item">
                     <div class="row gy-5" style="padding-left: 11px;">
                        <div class="row gy-5"
                           onclick="location.href='/review/${r.MO_CATEGORY}/${r.RV_IDX}.sosu'"
                           style="cursor: pointer;">
                           <input type="hidden" name="M_IDX" value="${r.RV_IDX}">
                           <input type="hidden" name="MO_IDX" value="${r.M_IDX}">

                           <!-- 사용자가 올린 메인 사진 -->
                           <c:if test="${r.F_SVNAME ne '0'}">
                              <img
                                 src="${pageContext.request.contextPath}/resources/img/upload/${r.F_SVNAME}"
                                 alt=""
                                 style='width: 300px; height: 300px; border-radius: 10px;'>
                           </c:if>
                           <!-- 사용자가 올린 메인 사진이 없을 경우 -->
                           <c:if test="${r.F_SVNAME eq '0'}">
                              <img src="/resources/img/icons/list.png"
                                 style='width: 300px; height: 300px; border-radius: 10px;'>
                           </c:if>
                           <br />
                           <p class="moim-title"
                              style="margin-top: 15px; margin-bottom: 28px;">
                              <span style="padding-left: 4px;">${r.RV_TITLE}</span> <span
                                 class="review-star"
                                 style="color: #ffc81e; font-size: 18px; float: right; padding-right: 22px;">
                                 <c:if test="${r.RV_STAR eq 1}">
                                    <c:out value="★☆☆☆☆" />
                                 </c:if> <c:if test="${r.RV_STAR eq 2}">
                                    <c:out value="★★☆☆☆" />
                                 </c:if> <c:if test="${r.RV_STAR eq 3}">
                                    <c:out value="★★★☆☆" />
                                 </c:if> <c:if test="${r.RV_STAR eq 4}">
                                    <c:out value="★★★★☆" />
                                 </c:if> <c:if test="${r.RV_STAR eq 5}">
                                    <c:out value="★★★★★" />
                                 </c:if>
                              </span>
                           </p>
                        </div>

                        <!-- 디테일 카테고리 -->
                        <div class="hashtag">
                           <input type="hidden" value="${r.MO_IDX}">
                           <button type="button"
                              onclick="location.href='/moim/${r.MO_CATEGORY}/${r.MO_IDX}.sosu'"
                              class="mrgbtn33" style="width: 100%;">#${r.MO_TITLE}</button>
                        </div>

                        <!-- 프로필과 찜 -->
                        <p class="mo-cost">
                           <img class="kingimg" src="/resources/img/upload/${r.PROFILE}"
                              style="margin-right: 9px;"> <span
                              style="float: left; padding-top: 8px;">${r.M_NICKNAME}</span>
                           <!-- 찜 insert-->
                           <c:if
                              test="${sessionss eq null or sessionss ne null and r.RZ_CHECK eq '0'}">
                              <input type="hidden" name="RV_IDX" value="${r.RV_IDX}">
                              <button type="button" class="hhhbtn"
                                 style="margin-right: 17px;"
                                 onclick="return RvinsertHeart(${r.RV_IDX})">
                                 <img alt="heart" src="/resources/img/icons/like.png"
                                    width="32px;">
                              </button>
                              <span class="mzcount"
                                 style="transform: translate(43%, -25px);">${r.RZ_COUNT}</span>
                           </c:if>
                           <!-- 찜 delete  -->
                           <c:if test="${sessionss ne null and r.RZ_CHECK ne '0'}">
                              <input type="hidden" name="MO_IDX" value="${r.RV_IDX}">
                              <button type="button" class="hhhbtn"
                                 style="margin-right: 17px;"
                                 onclick="return RvdeleteHeart(${r.RV_IDX})">
                                 <img alt="heart" src="/resources/img/icons/heart.png"
                                    width="32px;">
                              </button>
                              <span class="mzcount"
                                 style="transform: translate(43%, -25px);">${r.RZ_COUNT}</span>
                           </c:if>
                        </p>
                     </div>
                  </div>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <div class="row gy-5" style="height: 165px; margin-bottom: 12px;">
                  <p class="ct">리뷰</p>
                  <div class="none">조회된 결과가 없습니다.</div>
               </div>
            </c:otherwise>
         </c:choose>
      </div>

      <div class="row gy-5">
         <div class="col" style="margin-top: 10px;">

            <!-- 게시판 글쓰기 버튼 -->
            <%
            if (session.getAttribute("M_IDX") != null) {
            %>
            <div style="text-align: right;">
               <button type="button"
                  onclick="location.href='/freeboard/insertForm/{FR_CATEGORY}.sosu'"
                  class="mrgbtn">글쓰기</button>
            </div>
            <%
            }
            %>

         </div>
         <!--============== 자유게시판 4개 ==============-->
         <div class="row gy-5" style="padding-bottom: 80px;">
            <div class="myhr">
               <hr>
            </div>
           <c:choose>
               <c:when test="${fn:length(frlist) > 0 }">
                  <p class="ct">
                     자유게시판
                     <c:if test="${fn:length(frlist) > 4 }">
                        <span><a href="/freeboard/${MO_CATEGORY}.sosu"
                           class="allb">전체보기</a></span>
                     </c:if>
                  </p>
                  <c:forEach items="${frlist}" var="f" end="3">
                     <div class="col-lg-3 menu-item"
                         style="cu">
                        <div class="row gy-5" style="padding-left: 11px;" onclick="location.href='/freeboard/${f.FR_CATEGORY}/${f.FR_IDX}.sosu'">
                           <c:if test="${f.FF_SVNAME != null and f.FF_SVNAME != '0'}">
                              <img class="mimg" style="width: 300px;"
                                 src="${pageContext.request.contextPath}/resources/img/upload/${f.FF_SVNAME}"
                                 alt="${f.FF_SVNAME}">
                           </c:if>
                           <c:if test="${f.FF_SVNAME == '0' }">
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
                  <div class="row gy-5" style="height: 166px; margin-bottom: 143px;">
                     <p class="ct">자유게시판</p>
                     <div class="none">조회된 결과가 없습니다.</div>
                  </div>
               </c:otherwise>
            </c:choose>
         </div>
      </div>
   </div>
</body>
</html>