<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script defer type="text/javascript" src="/resources/js/zzim.js"></script>
<link href="/resources/css/list.css" rel="stylesheet">

<input type="hidden" value="${sessionss}" id="session">


<div class="col-lg-3 menu-item" style="margin-bottom: 80px;">
   <div class="row gy-5" style="padding-left: 11px;">
      <div class="row gy-5"
         onclick="location.href='/moim/${m.MO_CATEGORY}/${m.MO_IDX}.sosu'"
         style="cursor: pointer;">
         <input type="hidden" name="M_IDX" value="${m.M_IDX}"> <input
            type="hidden" name="MO_IDX" value="${m.MO_IDX}">
         <c:if test="${m.MF_SVNAME ne '0'}">
            <img src="/resources/img/upload/${m.MF_SVNAME}"
               <c:if test="${m.MO_CLOSE_YN eq 'N' }">  class="mimg" </c:if>
               <c:if test="${m.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>>
         </c:if>
         <c:if test="${m.MF_SVNAME eq '0'}">
            <img src="/resources/img/icons/list.png"
               <c:if test="${m.MO_CLOSE_YN eq 'N' }"> c class="mimg" </c:if>
               <c:if test="${m.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>>
         </c:if>
         <br />
         <p class="detail-region">${m.MO_DETAILREGION}
            <!-- 인원수 -->
            <c:if test="${m.MO_MAXPEOPLE != 0}">
               <span class="max">[${m.MOMEM_COUNT}명/${m.MO_MAXPEOPLE}명]</span>
            </c:if>
            <c:if test="${m.MO_MAXPEOPLE == 0}">
               <span class="max">[제한없음]</span>
            </c:if>
         </p>
         <!-- 타이틀이 16자 보다 크거나 같다면  -->
         <c:if test="${fn:length(m.MOTT) >= 16}">
            <p class="moim-title">${m.MOTT}...</p>
         </c:if>
         <!-- 타이틀이 16자 보다 작거나 같다면  -->
         <c:if test="${fn:length(m.MOTT) < 16}">
            <p class="moim-title">${m.MOTT}</p>
         </c:if>
      </div>

      <!-- 디테일 카테고리 -->
      <div class="hashtag">
         <input type="hidden" value="${m.MO_DETAILCATEGORY }">
         <button type="button"
            onclick="location.href='/moim/search.sosu?KEYWORD2=${m.MO_DETAILCATEGORY}'"
            class="mrgbtn33" style="width: 100%;">#${m.MO_DETAILCATEGORY}</button>
      </div>

      <!-- 프로필과 찜 -->
      <div class="mo-cost">
         <img class="kingimg" src="/resources/img/upload/${m.PROFILE}"
            style="margin-right: 9px;">
         <c:if test="${sessionss ne null}">
            <form action="/members/usermypage.sosu">
            <input type="hidden" value="${m.M_NICKNAME}" name="M_NICKNAME">
            <span style="float: left; padding-top: 8px;">
               <button   type="submit" class="champ2" style="cursor: pointer;">
                     ${m.M_NICKNAME}</button>
            </span>
            </form>
         </c:if>
                
          <c:if test="${sessionss eq null}">
            <form action="/members/loginform.sosu">
               <span style="float: left; padding-top: 8px;"><button
                     type="submit" class="champ2" 
                     onclick="alert('로그인이 필요한 서비스입니다. \n로그인창으로 이동합니다')">
                     ${m.M_NICKNAME}</button></span>
            </form>
          </c:if>
               <c:if test="${sessionss eq null or sessionss ne null and m.MZ_CHECK eq '0'}">
                  <input type="hidden" name="MO_IDX" value="${m.MO_IDX}">
                  <button type="button" class="hhhbtn" 
                     onclick="return MoinsertHeart(${m.MO_IDX})">
                     <img alt="heart" src="/resources/img/icons/like.png"
                        width="32px;">
                  </button>
                  <span class="mzcount">${m.MZ_COUNT}</span>
               </c:if>
               <c:if test="${sessionss ne null and m.MZ_CHECK ne '0'}">
                  <input type="hidden" name="MO_IDX" value="${m.MO_IDX}">
                  <button type="button" class="hhhbtn"
                     onclick="return ModeleteHeart(${m.MO_IDX})">
                     <img alt="heart" src="/resources/img/icons/heart.png"
                        width="32px;">
                  </button>
                  <span class="mzcount">${m.MZ_COUNT}</span>
               </c:if>
      </div>

   </div>
</div>