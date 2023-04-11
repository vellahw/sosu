<%@ page language="java" contentType="text/html; UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="/resources/css/detail.css" rel="stylesheet">
<script defer type="text/javascript" src="/resources/js/moimDetail.js"></script>
<script defer type="text/javascript" src="/resources/js/zzim.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<body>
   <div class="container"
      style="text-align: center; width: 1000px; margin: 80px auto;">

      <input type="hidden" name="MO_IDX" value="${MO_IDX}" id="idx">
      <input type="hidden" name="MO_CATEGORY" value="${MO_CATEGORY}" id="cate"> 
      <input type="hidden" name="sessionss" value="${sessionss}" id="session"> 
      <input type="hidden" name="WII" value="${Detail.WII}" id="latitude"> 
      <input type="hidden" name="KYUNG" value="${Detail.KYUNG}" id="longitude"> 
      <input type="hidden" name="ADDRESS" value="${Detail.ADDRESS}" id="address"> 
      <input type="hidden" name="DEADDRESS" value="${Detail.DEADDRESS}" id="detail-address"> 
      
      <main>
        <div class="detailBody">
            <div class="imgArea">
               <!-- 메인 사진 -->
                  <c:if test="${Detail.MF_SVNAME ne '0'}">
                     <img src="/resources/img/upload/${Detail.MF_SVNAME}" onerror="this.style.display='none'"
                     style="max-height: 561px;max-width: -webkit-fill-available;">
                  </c:if>
            </div>

            <!-- 마감된 모임일 때 -->
            <c:if test="${Detail.MO_CLOSE_YN eq 'Y'}">
               <div style="margin-bottom: 15px;">
                  <p class="magam">마감된 모임입니다.</p>
               </div>
            </c:if>

            <div class="detailArea">
               <!-- 모임 제목 -->
               <p class="dtitle">${Detail.MO_TITLE}<span style="float: right;">
                     <c:if
                        test="${sessionss eq null or sessionss ne null and Detail.MZ_CHECK eq '0'}">
                        <input type="hidden" name="MO_IDX" value="${Detail.MO_IDX}">
                        <button type="button" class="hhhbtn"
                           onclick="return MoinsertHeart(${Detail.MO_IDX})">
                           <img alt="heart" src="/resources/img/icons/like.png"
                              width="32px;">
                        </button>
                        <span class="mzcount">${Detail.MZ_COUNT}</span>
                     </c:if> <c:if test="${sessionss ne null and Detail.MZ_CHECK ne '0'}">
                        <input type="hidden" name="MO_IDX" value="${Detail.MO_IDX}">
                        <button type="button" class="hhhbtn"
                           onclick="return ModeleteHeart(${Detail.MO_IDX})">
                           <img alt="heart" src="/resources/img/icons/heart.png"
                              width="32px;">
                        </button>
                        <span class="mzcount">${Detail.MZ_COUNT}</span>
                     </c:if>

                  </span>
               </p>
               <hr>

               <!-- 세부 정보 -->
               <p id="MO_IDX">
                  ☀︎
                  <c:if test="${Detail.MO_CATEGORY == 'culture' }">문화/예술</c:if>
                  <c:if test="${Detail.MO_CATEGORY == 'sports' }">운동/스포츠</c:if>
                  <c:if test="${Detail.MO_CATEGORY == 'outdoor' }">아웃도어/여행</c:if>
                  <c:if test="${Detail.MO_CATEGORY == 'game' }">게임/오락</c:if>
                  <c:if test="${Detail.MO_CATEGORY == 'food' }">음식</c:if>
                  <c:if test="${Detail.MO_CATEGORY == 'etc' }">기타</c:if>
               </p>
               <p>♫ ${Detail.MO_DETAILCATEGORY}</p>
               <p class="showMap-container" style ="margin-bottom:0px" >
                  ⚑ ${Detail.MO_DETAILREGION}
                  <c:if test = "${Detail.MAP_IDX ne null}">
                  <button type="button" class="showMap-title">지도보기</button>
                  <div class="showMap-answer">
                     <div id="map" style="width:500px;height:400px;margin-top:10px;"></div>
                  </div>
                  </c:if>
               </p>
               <p>
                  ✈
                  <fmt:formatDate value="${Detail.MO_DEADLINE}" pattern="yyyy/MM/dd" />
                  <fmt:parseDate value="${Detail.MO_DEADTIME}" var="deadtime"
                     pattern="HH:mm" />
                  <fmt:formatDate value="${deadtime}" pattern="HH:mm" />
               </p>
               <p>
                  $  &nbsp;참가 비용
                  <!-- 참가 비용이 있다면 -->
                  <c:if test="${Detail.MO_COST ne null and Detail.MO_COST ne '0'}">
                     <fmt:formatNumber value="${Detail.MO_COST}"/>  원</c:if>
                  <c:if test="${Detail.MO_COST eq null or Detail.MO_COST eq '0'}">없음</c:if>
               </p>
               <p>
                  ✸
                  <c:if test="${Detail.MO_MINAGE != '0'}">
                     <input type="hidden" value="${Detail.MO_MINAGE}" name="MO_MINAGE"
                        id="minAge" />
                     <input type="hidden" value="${Detail.MO_MAXAGE}" name="MO_MAXAGE"
                        id="maxAge" />
                      ${Detail.MO_MINAGE}~${Detail.MO_MAXAGE}세  
                   </c:if>

                  <c:if test="${Detail.MO_MINAGE == '0'}">
                      연령 제한 없음
                     </c:if>
               </p>
               <p id="gender">
                  ☺
                  <c:if test="${Detail.MO_GENDER == 'W'}">여자만</c:if>
                  <c:if test="${Detail.MO_GENDER == 'M'}">남자만</c:if>
                  <c:if test="${Detail.MO_GENDER == '0'}">성별 제한 없음</c:if>
                  <input type="hidden" value="${Detail.MO_GENDER}" id="gender2">
               </p>
               <p>
                  ✿
                  <c:if test="${Detail.MO_MAXPEOPLE != '0'}">
                     <input type="hidden" value="${Detail.MO_MAXPEOPLE}"
                        name="MO_MAXPEOPLE" id="maxP" />
                     <input type="hidden" value="${Detail.MOMEM_COUNT}"
                        name="MOMEM_COUNT" id="presentP" />
                      현재 ${Detail.MOMEM_COUNT}명/최대 ${Detail.MO_MAXPEOPLE}명
                   </c:if>
                  <c:if test="${Detail.MO_MAXPEOPLE == '0'}">
                        인원 제한 없음
                   </c:if>
               </p>
            </div>
            <div class="kingArea">
               <hr>

               <!-- 방장 프로필 -->
               <img src="/resources/img/upload/${Detail.KPROFILE}" class="kingimg">

               <!-- 2/14 비회원시 로그인창으로 이동하는 기능 추가 -->
               <div style="display: inline;">
               <c:if test="${sessionss ne null}">
                  <form action="/members/usermypage.sosu"
                     style="display: inline-block; width: 62px; display: contents;">
                     <input type="hidden" value="${Detail.M_NICKNAME}"
                        name="M_NICKNAME">
                     <button type="submit" class="king" style="cursor: pointer;">${Detail.M_NICKNAME}</button>
                  </form>
               </c:if>
               <c:if test="${sessionss eq null}">
                  <form action="/members/loginform.sosu" style="display: inline;">
                     <button type="submit" class="king"
                        onclick="alert('로그인 창으로 이동합니다')" style="cursor: pointer;">${Detail.M_NICKNAME}</button>
                  </form>
               </c:if>
               <span class="ks"><fmt:formatDate
                     value="${Detail.MO_REGDATE}" pattern="yyyy/MM/dd" /> 개설</span>
              </div>
            </div>
            <hr>
            <div class="modetail">
               <p class="dtitle">모임소개</p>

               <p>${Detail.MO_DETAIL}</p>

               <p>
                  <c:if test="${Flist ne null}">
                     <c:forEach items="${Flist}" var="fl">
                        <c:if test="${fl.F_MAIN_YN eq 'N'}">
                           <a href="/resources/img/upload/${fl.F_SVNAME}" class="glightbox">
                           <img src="/resources/img/upload/${fl.F_SVNAME}" class="my_img"  onerror="this.style.display='none'">
                           </a>
                        </c:if>
                     </c:forEach>
                  </c:if>
                  <c:if test="${Flist eq null}"></c:if>
               </p>
            </div>
         </div>
         <br> <br>
         <div style="text-align: left;">
            <table>
               <thead></thead>
               <tbody>
                  <c:choose>
                     <c:when test="${fn:length(list) > 0 }">
                        <tr>
                           <td class="text-left" width="50%">
                              <div class="panel-faq-container">
                                 <p class="panel-faq-title dtitle"
                                    style="width: 116px; padding: 4px 8px 4px 8px;">참여자 리스트
                                 </p>
                                 <!-- 접었다 폈다 -->
                                 <div class="panel-faq-answer"
                                    style="margin-bottom: 10px; margin-right: 50px; word-break: break-all;">
                                    <div>
                                       <c:forEach items="${list}" var="m" varStatus="status">
                                          <input type="hidden" value="${m.M_IDX}" name="M_IDX"
                                             id="pmidx${status.index}">
                                          <img src="/resources/img/upload/${m.PROFILE}"
                                             class="kingimg" style="width: 55px; height: 55px;">
                                          <!-- 2/14 비회원시 로그인창으로 이동하는 기능 추가 -->
                                          <c:if test="${sessionss ne null}">
                                             <form action="/members/usermypage.sosu"
                                                style="display: inline;">
                                                <input type="hidden" value="${m.M_NICKNAME}"
                                                   name="M_NICKNAME" style="cursor: pointer;">
                                                <button type="submit" class="champ">
                                                   ${m.M_NICKNAME}</button>
                                             </form>
                                             &nbsp;&nbsp;&nbsp;
                                          </c:if>
                                          <c:if test="${sessionss eq null}">
                                             <form action="/members/loginform.sosu"
                                                style="display: inline;">
                                                <button class="champ" type="submit"
                                                   onclick="alert('로그인이 필요한 서비스입니다. \n로그인창으로 이동합니다')">
                                                   ${m.M_NICKNAME}</button>
                                             </form>
                                          </c:if>
                                          <c:if test="${sessionss eq Detail.M_IDX and Detail.MO_CLOSE_YN eq 'N'}">
                                             <form action=/moim/moimMemberBan.sosu
                                                style="display: inline;"
                                                onsubmit="return confirm('강퇴 처리 하시겠습니까?')">
                                                <input type = "hidden" name = "P_IDX" value = "${m.P_IDX}">
                                                  <input type = "hidden" name = "MO_IDX" value = "${MO_IDX}">
                                                   <input type = "hidden" name = "MO_CATEGORY" value ="${Detail.MO_CATEGORY}">
                                               <input type="submit" class="gbtn" value="강퇴">
                                             </form>
                                          </c:if>

                                       </c:forEach>
                                       <br />
                                    </div>
                                 </div>
                              </div>
                           </td>
                        </tr>
                     </c:when>
                     <c:otherwise>
                        <tr>
                           <td colspan="4">
                              <div class="panel-faq-container">
                                 <p class="panel-faq-title dtitle"
                                    style="width: 116px; padding: 4px 8px 4px 8px;">참여자 리스트
                                 </p>
                                 <!-- 접었다 폈다 -->
                                 <div class="panel-faq-answer"
                                    style="margin-bottom: 10px; margin-right: 50px; word-break: break-all; padding-left: 8px;">
                                    <div>현재 참여한 인원이 없습니다.</div>
                                 </div>
                              </div>
                           </td>
                        </tr>
                     </c:otherwise>
                  </c:choose>
               </tbody>
            </table>
         </div>

         <c:if test="${sessionss eq Detail.M_IDX and Detail.MO_PERMIT eq 'Y' and Detail.MO_CLOSE_YN eq 'N'}">
            <div style="text-align: left;">
               <table>
                  <thead></thead>
                  <tbody>
                     <c:choose>
                        <c:when test="${fn:length(list2) > 0 }">
                           <div class="panel-faq-container">
                              <p class="panel-faq-title dtitle"
                                 style="width: 123px; padding: 4px 8px 4px 11px;">참여 대기 인원
                              </p>
                              <!-- 접었다 폈다 -->
                              <div class="panel-faq-answer"
                                 style="margin-bottom: 10px; margin-right: 50px; word-break: break-all;">
                                 <div style="width: 1000px;">
                                    <c:forEach items="${list2}" var="w" varStatus="status">
                                       <c:if test="${w.P_FINAL_YN eq 'N'}">
                                          <img src="/resources/img/upload/${w.PROFILE}"
                                             class="kingimg"
                                             style="width: 55px; height: 55px; padding-bottom: 20px; padding-left: 12px;">
                                          <form action="/members/usermypage.sosu"
                                             style="display: inline;">
                                             <input type="hidden" value="${w.M_NICKNAME}"
                                                name="M_NICKNAME">
                                             <button type="submit" class="champ">${w.M_NICKNAME}</button>
                                          </form>
                                          <form action="/moim/moimWaitApprove.sosu"
                                             style="display: inline;"
                                             <c:if test="${Detail.MO_MAXPEOPLE eq '0'or Detail.MO_MAXPEOPLE ne '0' 
                                             and Detail.MO_MAXPEOPLE gt Detail.MOMEM_COUNT}"> onsubmit="return approve();"</c:if>
                                             <c:if test="${Detail.MO_MAXPEOPLE  ne '0' 
                                             and Detail.MO_MAXPEOPLE le Detail.MOMEM_COUNT}">
                                             onsubmit="return confirm('현재 모집중인 인원이 가득 찼습니다. \n모집원을 추가하시겠습니까?')"</c:if>>
                                             <input type="hidden" value="${w.P_IDX}" name="P_IDX">
                                             <input type="hidden" name="MO_IDX" value="${MO_IDX}">
                                             <button class="gbtn"
                                                style="margin-right: 3px; margin-left: 5px; transform: translate(4px, -38px);"
                                                type="submit">승인</button>
                                          </form>
                           
                                          <form action="/moim/moimMemberBan.sosu"
                                             style="display: inline;" onsubmit="return ban();">
                                             <input type="hidden" value="${w.P_IDX}" name="P_IDX">
                                             <input type="hidden" name="MO_IDX" value="${MO_IDX}">

                                             <button class="gbtn" style="margin-right: 65px; transform: translate(4px, -38px);"
                                                type="submit">거부</button>
                                          </form>
                                       </c:if>
                                    </c:forEach>
                                 </div>
                              </div>
                           </div>
                        </c:when>
                        <c:otherwise>
                           <tr>
                              <td colspan="4">
                                 <div class="panel-faq-container">
                                    <p class="panel-faq-title dtitle"
                                       style="width: 123px; padding: 4px 8px 4px 8px;">참여 대기
                                       인원</p>
                                    <!-- 접었다 폈다 -->
                                    <div class="panel-faq-answer"
                                       style="margin-bottom: 10px; margin-right: 50px; word-break: break-all;">
                                       <div style="padding-left: 8px;">현재 참여 대기중인 인원이 없습니다.
                                       </div>
                                    </div>
                                 </div>
                              </td>
                           </tr>
                        </c:otherwise>
                     </c:choose>
                  </tbody>
               </table>

            </div>
         </c:if>

         <div class="myhr">
            <hr>
         </div>

         <!--====== 버튼들.. ======-->
         <div align="center" id="btndiv" style="display: inline-flex;">
            <!-- 참여 승인이 필요하지 않은 모임 -->
            <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_PERMIT eq 'N' and Detail.MO_CLOSE_YN eq 'N'}">
               <form <c:if test = "${Detail.CHAMYN eq '0'}">action="/moim/moimJoin.sosu" onsubmit="return checkJoin();"</c:if>
               <c:if test = "${Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'N' and Detail.P_FINAL_YN eq 'N'}"> action="/moim/moimReJoin.sosu"
               onsubmit = "return confirm('한 번 탈퇴한 모임입니다. \n재참여하시겠습니까?')"</c:if>
               <c:if test = "${Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'Y' and Detail.P_FINAL_YN eq 'Y'}">
               onclick = "return alert('이미 강퇴당한 모임입니다. \n재참여가 불가능합니다.')"</c:if> 
               style="display: inline;">
                  <c:if test = "${Detail.CHAMYN eq '0' or Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'N' and Detail.P_FINAL_YN eq 'N' 
                  or Detail.CHAMYN ne '0'  and Detail.P_BAN_YN eq 'Y' and Detail.P_FINAL_YN eq 'Y'}">
                  <button class="mrgbtn" type="submit" id="cham1"
                     style="margin-right: 9px;">참여하기</button>
                  <input type="hidden" name="MO_IDX" value="${MO_IDX}"> <input
                     type="hidden" name="M_GENDER" value="${sessgender}"
                     id="ssgender1"> <input type="hidden" name="M_IDX"
                     value="${sessionss}" id="sessionss1"> <input
                     type="hidden" value="${sessage}" id="sessage1">
                     </c:if>
               </form>
            </c:if>

               <!-- 탈퇴하기 버튼 -->
             
              <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_CLOSE_YN eq 'N'
                and Detail.CHAMYN  ne '0' and Detail.P_BAN_YN eq 'N' and Detail.P_FINAL_YN eq 'Y'}">
               <form action="/moim/moimExit.sosu" onsubmit="return exit();">
                  <button class="mrgbtn" type="submit" id="tal1"
                     style="margin-right: 9px;">탈퇴하기</button>
                  <input type="hidden" name="MO_IDX" value="${MO_IDX}"> <input
                     type="hidden" name="M_IDX" value="${sessionss}" id="sessionss3">
               </form>
               </c:if>


            <!-- 참여 승인이 필요한 모임 -->
            <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_PERMIT eq 'Y' and Detail.MO_CLOSE_YN eq 'N'}">
               <form <c:if test = "${Detail.CHAMYN eq '0'}">
               action="/moim/moimJoinPermit.sosu" onsubmit="return checkJoin2();" </c:if>
               <c:if test = "${Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'N' and Detail.P_FINAL_YN eq 'N'}"> 
               action="/moim/moimRePermit.sosu"
               onsubmit = "return confirm('한 번 참여를 취소한 모임입니다. \n재참여하시겠습니까?')"</c:if>
               <c:if test = "${Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'Y' and Detail.P_FINAL_YN eq 'Y'}">
               onclick = "return alert('이미 강퇴당하거나 승인거부 당한 모임입니다. \n재참여가 불가능합니다.')"</c:if>
                   style="display: inline;">
                <c:if test = "${Detail.CHAMYN eq 0 or Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'N' and Detail.P_FINAL_YN eq 'N' 
                  or Detail.CHAMYN ne '0'  and Detail.P_BAN_YN eq 'Y' and Detail.P_FINAL_YN eq 'Y'}">
                  <button class="mrgbtn" type="submit" id="cham2"
                     style="display: inline; margin-right: 9px;">참가요청</button>
                  <input type="hidden" name="MO_IDX" value="${MO_IDX}"> <input
                     type="hidden" name="M_GENDER" value="${sessgender}"
                     id="ssgender2"> <input type="hidden" name="M_IDX"
                     value="${sessionss}" id="sessionss2"> <input
                     type="hidden" name="sessage" value="${sessage}" id="sessage2">
                     </c:if>
               </form>
               </c:if>
               <!-- 취소하기 버튼 -->
                 <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_PERMIT eq 'Y' and Detail.MO_CLOSE_YN eq 'N'
                    and Detail.CHAMYN ne '0' and Detail.P_BAN_YN eq 'Y' and Detail.P_FINAL_YN eq 'N'}">
                 <form action="/moim/moimExit.sosu" onsubmit="return exit2();">
                  <button class="mrgbtn" type="submit" id="tal2"
                     style="margin-right: 9px;">참가 취소하기</button>
                  <input type="hidden" name="MO_IDX" value="${MO_IDX}"> <input
                     type="hidden" name="M_IDX" value="${sessionss}" id="sessionss4">
               </form>
               
            </c:if>
            <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_CLOSE_YN eq 'Y' and Detail.RV_YN eq '0'}">
            <form action="/members/reviewForm.sosu">
                  <button class="mrgbtn" type="submit" id="reviewGo"
                     style="margin-right: 9px;">리뷰 작성하기</button>
                  <input type="hidden" name="MO_IDX" value="${MO_IDX}"> 
                  <input type="hidden" name="M_IDX" value="${sessionss}" id="sessionss5">
                    <input type="hidden" name="MO_TITLE" value="${Detail.MO_TITLE }">
              </form>
             
               </c:if>
              <c:if test="${sessionss ne null and sessionss ne Detail.M_IDX and Detail.MO_CLOSE_YN eq 'Y' and Detail.RV_YN ne '0'}">
                     <button class="mrgbtn3" id = "reviewWan"
                     style="margin-right: 9px;" onclick = "location.href='/review/${MO_CATEGORY}/${Detail.RV_IDX}.sosu'">내가 쓴 리뷰보기</button>
              </c:if>

            <!-- 목록으로 버튼 -->
            <button type="button" class="mrgbtn"
               onclick="location.href='/moim/${MO_CATEGORY}.sosu'">목록으로</button>

            <!-- 방장일 때 보이는 -->
            <c:if
               test="${sessionss ne null and sessionss eq Detail.M_IDX and Detail.MO_CLOSE_YN eq 'N'}">
               <a href="/moimModify/${MO_IDX}.sosu" class="mrgbtn"
                  style="margin-left: 9px;">수정하기</a>
               <input type="hidden" value="${MO_IDX}" name="MO_IDX">

               <form action="/moim/moimDelete.sosu" id="moimDelete"
                  onsubmit="return confirm('모임을 삭제하시겠습니까?')"
                  style="display: inline;">
                  <input type="submit" class="mrgbtn" value="삭제하기"
                     style="margin: 0 9px 0 9px;"> <input type="hidden"
                     value="${MO_IDX}" name="MO_IDX">
               </form>

               <form action="/moim/moimSelfClose.sosu" id="selfclose"
                  onsubmit="return confirm('모임을 마감 하시겠습니까? \n마감하시면 더 이상 모임원을 모집할 수 없습니다.');"
                  style="display: inline;">
                  <input type="submit" value="조기마감" class="mrgbtn"> <input
                     type="hidden" value="${MO_IDX}" name="MO_IDX">
               </form>
            </c:if>
         </div>
      </main>
   </div>

<!-- 스크립트 태그 이 위치에 있어야 하는거 맞아요 -->
<script type="text/javascript">
/* 참여자 리스트 접었다 펴기 */
window.onload = () => {
     const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); // NodeList 객체
     const showMapContainer = document.querySelectorAll(".showMap-container"); // NodeList 객체
     
     let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");
     let showMapAnswer = document.querySelectorAll(".showMap-answer");

     // 반복문 순회하면서 해당 참여자 리스트 타이틀 클릭시 콜백 처리
     for( let i=0; i < panelFaqContainer.length; i++ ) {
       panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
         // 참여자 리스트 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
         panelFaqAnswer[i].classList.toggle('active2');
       });
     };
     
     // 지도 보기 클릭시 콜백 처리
     for( let i=0; i < showMapContainer.length; i++ ) {
        showMapContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
         showMapAnswer[i].classList.toggle('active');
       });
     };
   }
</script>
</body>