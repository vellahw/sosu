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
<script defer type="text/javascript" src="/resources/js/userMypage.js"></script>
<link href="/resources/css/mypage.css" rel="stylesheet">
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">




<title>Insert title here</title>
</head>
<body>

<div class="container" style="text-align:center">
   <h1 style="margin-top:50px; margin-bottom:40px">${mypageInfo[0][0].M_NICKNAME} 'S PAGE</h1>
      <div class="pro_firsttt">
         <!-- 프로필 사진  -->
         <form enctype="multipart/form-data">
            <img class="img-pro" src="${pageContext.request.contextPath}/resources/img/upload/${mypageInfo[9][0].F_SVNAME}"><br/>
         </form>


   <!-- 공통 정보 -->
   <!-- 닉네임 + 수정하기 버튼 -->
    <p class="nickname">${mypageInfo[0][0].M_NICKNAME}
       
       <!-- 관리자가 아닌 경우에 볼 수 있음 (비회원은 안됨) -->
      <%if(!session.getAttribute("M_TYPE").equals("A")){ %>
      
      <!-- 채팅 -->
      <!-- 기존 대화가 없는 경우 새로운 방이 만들어짐 -->
      <form action="/message/createMessageRoom.sosu" method="get"  class="img-modi" style="display: inline-block;">
         <input type="hidden" name="USER_M_IDX" value="${USER_M_IDX}">
         <input  TYPE="IMAGE" src="/resources/img/icons/mail.png" name="Submit" value="Submit"  align="absmiddle" class="img-modi">
      </form>
      
      <!-- 신고 -->
      <span><a href="javascript:void(0);" onclick="reportPopup();">
         <input type='hidden' name="M_IDX" value="${M_IDX}">
         <img class="img-modi" src="/resources/img/icons/report.png">
      </a></span>
   <%} %>
       </p>
       
    <!-- 이메일 -->
    <p style="margin-top:10px;">${mypageInfo[0][0].M_EMAIL}</p>  
   
   <!-- 별점 띄우기 -->
    <p style="color: #ffc81e">
      <c:if test="${mypageInfo[2][0].STARINT eq 1}"><c:out value="★☆☆☆☆"/></c:if> 
      <c:if test="${mypageInfo[2][0].STARINT eq 2}"><c:out value="★★☆☆☆" /></c:if> 
      <c:if test="${mypageInfo[2][0].STARINT eq 3}"><c:out value="★★★☆☆" /></c:if> 
      <c:if test="${mypageInfo[2][0].STARINT eq 4}"><c:out value="★★★★☆" /></c:if>
      <c:if test="${mypageInfo[2][0].STARINT eq 5}"><c:out value="★★★★★" /></c:if>
      <span style="color:#212529">(${mypageInfo[1][0].STARFLOAT})</span>
    </p>
   </div>
      
   
   <form action="/members/usermypage.sosu" method="get">
      <input type="hidden" id="category" name="mypageCategory" value="">
      <input type="hidden" id="review" name="selectReview" value="">
      <input type="hidden" id="zzim" name="selectZzim" value="">
      <input type="hidden" name="M_NICKNAME" value="${M_NICKNAME}">
      <input type="hidden" name="M_IDX" value="${M_IDX}">
      
      <c:set var="reviewA" value="${fn:length(mypageInfo[5])}"/>
      <c:set var="reviewB" value="${fn:length(mypageInfo[6])}"/>
      <c:set var="zzimA" value="${fn:length(mypageInfo[7])}"/>
      <c:set var="zzimB" value="${fn:length(mypageInfo[8])}"/>
      
      <button type="submit" <c:if test="${mypageCategory eq '1'}">class="btn-mypage on"</c:if>
      <c:if test="${mypageCategory ne '1'}">class="btn-mypage"</c:if>
       id="check1">${fn:length(mypageInfo[3])} <br/>내가 개설한 모임</button>
       
       <button type="submit" <c:if test="${mypageCategory eq '2'}">class="btn-mypage on"</c:if>
      <c:if test="${mypageCategory ne '2'}">class="btn-mypage"</c:if>
       id="check2" >${fn:length(mypageInfo[4])} <br/>내가 참여한 모임</button>
      
      <button type="submit" <c:if test="${mypageCategory eq '3'}">class="btn-mypage on"</c:if>
      <c:if test="${mypageCategory ne '3'}">class="btn-mypage"</c:if>
       id="check3">${reviewA + reviewB} <br/>리뷰</button>
      
      <button type="submit" <c:if test="${mypageCategory eq '4'}">class="btn-mypage on"</c:if>
      <c:if test="${mypageCategory ne '4'}">class="btn-mypage"</c:if>
       id="check4">${zzimA + zzimB} <br/> 스크랩</button>
   
   <c:if test="${mypageCategory eq '1' }">
      <section id="1" class="pro_sec">
      <div class="container">
      <div class="row gy-5">
         
          <c:if test="${fn:length(mypageInfo[3]) ne 0 }">
         <c:forEach begin="0" end="${fn:length(mypageInfo[3])}" items="${mypageInfo[3]}" var="mypage">
         <div class="col-lg-3 menu-item">
            <div class="row gy-5">
            <a onclick= "location.href='/moim/${mypage.MO_CATEGORY}/${mypage.MO_IDX}.sosu'">
               <input type="hidden" name="MO_CATEGORY" value="${mypage.MO_CATEGORY}">
               <input type="hidden" name="MO_IDX" value="${mypage.MO_IDX}">
                <c:if test = "${mypage.F_SVNAME ne null}">
                     <img src="${pageContext.request.contextPath}/resources/img/upload/${mypage.F_SVNAME}" style="width: 300px; height: 300px;"
                     <c:if test="${mypage.MO_CLOSE_YN eq 'N' }"> class="moim-img"</c:if> 
                  <c:if test="${mypage.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>><!-- 모임 마감시 이미지 어둡게 처리 -->
               </c:if>
               <c:if test = "${mypage.F_SVNAME eq null}">
                     <img src="${pageContext.request.contextPath}/resources/img/icons/list.png"
                     <c:if test="${mypage.MO_CLOSE_YN eq 'N' }"> class="moim-img"</c:if> 
                  <c:if test="${mypage.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>> <!-- 모임 마감시 이미지 어둡게 처리 -->
               </c:if>
            </a>
               <p class="detail-region">${mypage.MO_DETAILREGION }</p>
                     <c:if test="${fn:length(mypage.MOTT) >= 16}"> 
                        <p class="moim-title">${mypage.MOTT}...</p>
                  </c:if>
                  <!-- 타이틀이 16자 보다 작거나 같다면  -->   
                  <c:if test="${fn:length(mypage.MOTT) < 16}"> 
                        <p class="moim-title">${mypage.MOTT}</p>
                  </c:if>
               <span class="moim-people">[${mypage.MOIMMEMBER}명 / ${mypage.MO_MAXPEOPLE }명]
               <span class="detail-cate"> # ${mypage.MO_DETAILCATEGORY }</span></span>
               <hr class="hrhr">
            </div>
            </div>
            </c:forEach>
            </c:if>
            <c:if test="${fn:length(mypageInfo[3]) eq 0}">
                <div style="height:300px; margin-top:150px;">개설한 모임이 없습니다!!</div>
             </c:if>
      </div>
   </div>
   </section>
   </c:if>
   
   <c:if test="${mypageCategory eq '2' }">
   <section id="2" class="pro_sec">
   <div class="container">
   <div class="row gy-5">
      <!-- 해당 회원이 비공개 처리 했을 경우  -->
      <c:if test="${privateCheck eq '1' || privateCheck eq '2'}"><div class="onlyMyPrivate" style="height:300px; margin-top:150px;">비공개입니다.</div></c:if>
      
      <!-- 비공개 처리하지 않았을 경우 -->
      <c:if test="${privateCheck eq '0' || privateCheck eq '3'}">
            <c:if test="${fn:length(mypageInfo[4]) ne 0}">
         <c:forEach begin="0" end="${fn:length(mypageInfo[4])}" items="${mypageInfo[4]}" var="mypage">
         <div class="col-lg-3 menu-item">
         <div class="row gy-5">
         <a onclick= "location.href='/moim/${mypage.MO_CATEGORY}/${mypage.MO_IDX}.sosu'">
            <input type="hidden" name="MO_CATEGORY" value="${mypage.MO_CATEGORY}">
            <input type="hidden" name="MO_IDX" value="${mypage.MO_IDX}">
          <c:if test = "${mypage.F_SVNAME ne null}">
                  <img src="${pageContext.request.contextPath}/resources/img/upload/${mypage.F_SVNAME}" style="width: 300px; height: 300px;"
                  <c:if test="${mypage.MO_CLOSE_YN eq 'N' }"> class="moim-img"</c:if> 
               <c:if test="${mypage.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>><!-- 모임 마감시 이미지 어둡게 처리 -->
            </c:if>
             <c:if test = "${mypage.F_SVNAME eq null}">
               <img src="${pageContext.request.contextPath}/resources/img/icons/list.png"
            <c:if test="${mypage.MO_CLOSE_YN eq 'N' }"> class="moim-img"</c:if> 
            <c:if test="${mypage.MO_CLOSE_YN eq 'Y' }"> class="moim-endimg"</c:if>> <!-- 모임 마감시 이미지 어둡게 처리 -->
            </c:if> 
      </a>
            <p class="detail-region">${mypage.MO_DETAILREGION }</p> 
            <c:if test="${fn:length(mypage.MOTT) >= 16}"> 
               <p class="moim-title">${mypage.MOTT}...</p>
             </c:if>
            <!-- 타이틀이 16자 보다 작거나 같다면  -->   
             <c:if test="${fn:length(mypage.MOTT) < 16}"> 
               <p class="moim-title">${mypage.MOTT}</p>
             </c:if>
            <span class="moim-people">[${mypage.MOIMMEMBER}명 / ${mypage.MO_MAXPEOPLE }명]
            <span class="detail-cate"> # ${mypage.MO_DETAILCATEGORY }</span></span>
            <hr class="hrhr">
         </div>
         </div>
         </c:forEach>
         </c:if>
               <c:if test="${fn:length(mypageInfo[4]) eq 0}">
                   <div style="height:300px; margin-top:150px;">참여한 모임이 없습니다!!</div>
                </c:if>
         </c:if>
      </div>
      
      </div>         
      </section>
   </c:if>
   
      <c:if test="${mypageCategory eq '3' }">
      <section id="3" class="pro_sec">
      <button type="submit" <c:if test="${selectReview eq '5'}">class="btn-review on"</c:if>
      <c:if test="${selectReview ne '5'}">class="btn-review"</c:if>
          id="check5">내가 남긴 리뷰 (${fn:length(mypageInfo[5])})</button>
      <button type="submit" <c:if test="${selectReview eq '6'}">class="btn-review on"</c:if>
          <c:if test="${selectReview ne '6'}">class="btn-review"</c:if>
         id="check6">나에게 남긴 리뷰 (${fn:length(mypageInfo[6])})</button>      
    </section>
    
    <c:if test="${selectReview eq '5' }">
    <section id="4" class="pro_sec">
       <div class="container">
          <div class="row gy-5">
          <c:if test="${fn:length(mypageInfo[5]) ne 0}">
          <c:forEach begin="0" end="${fn:length(mypageInfo[5])}" items="${mypageInfo[5]}" var="mypage">
             <div class="col-lg-3 menu-item">
                     <div class="row gy-5">
                <img src="${pageContext.request.contextPath}/resources/img/icons/list.png" class="moim-img">
                     <p class="rezimm-title">${mypage.MO_TITLE}
                     <span class="moim-date"><fmt:formatDate value="${mypage.MO_REGDATE}" pattern="yyyy-MM-dd"/>
                     </span></p>
                     <hr class="hrhr">
                     <p class="review-star" >
                        <c:if test="${mypage.RV_STAR eq 1}"><c:out value="★☆☆☆☆"/></c:if> 
                        <c:if test="${mypage.RV_STAR eq 2}"><c:out value="★★☆☆☆" /></c:if> 
                        <c:if test="${mypage.RV_STAR eq 3}"><c:out value="★★★☆☆" /></c:if> 
                        <c:if test="${mypage.RV_STAR eq 4}"><c:out value="★★★★☆" /></c:if>
                        <c:if test="${mypage.RV_STAR eq 5}"><c:out value="★★★★★" /></c:if>
                     </p>
                  </div>
                  </div>
               </c:forEach>
               </c:if>
               <c:if test="${fn:length(mypageInfo[5]) eq 0}">
                   <div style="height:300px; margin-top:150px;">남긴 리뷰가 없습니다!!</div>
                </c:if>
               </div>
               </div>
            </section>
            </c:if>


      
       <c:if test="${selectReview eq '6' }">
       <section id="5" class="pro_sec">
       <div class="container">
                  <div class="row gy-5">      
                  <c:if test="${fn:length(mypageInfo[6]) ne 0}">      
         <c:forEach begin="0" end="${fn:length(mypageInfo[6])}" items="${mypageInfo[6]}" var="mypage">
          <div class="col-lg-3 menu-item">
                  <div class="row gy-5">
                  <img src="${pageContext.request.contextPath}/resources/img/icons/list.png" class="moim-img">
            <p class="rezimm-title">${mypage.MO_TITLE}
                     <span class="moim-date"><fmt:formatDate value="${mypage.MO_REGDATE}" pattern="yyyy-MM-dd"/>
                     </span></p>
                     <hr class="hrhr">
                     <p class="review-star">
                        <c:if test="${mypage.RV_STAR eq 1}"><c:out value="★☆☆☆☆"/></c:if> 
                        <c:if test="${mypage.RV_STAR eq 2}"><c:out value="★★☆☆☆" /></c:if> 
                        <c:if test="${mypage.RV_STAR eq 3}"><c:out value="★★★☆☆" /></c:if> 
                        <c:if test="${mypage.RV_STAR eq 4}"><c:out value="★★★★☆" /></c:if>
                        <c:if test="${mypage.RV_STAR eq 5}"><c:out value="★★★★★" /></c:if>
                       </p>
                       </div>
                       </div>
         </c:forEach>
         </c:if>
          <c:if test="${fn:length(mypageInfo[6]) eq 0}">
                   <div style="height:300px; margin-top:150px;">남겨진 리뷰가 없습니다!!</div>
                </c:if>
         </div>
         </div>
         </section>
      </c:if>
   </c:if>
   
   
   <c:if test="${mypageCategory eq '4' }">
      <section id="6" class="pro_sec">
      <!-- 비공개 처리했을 경우 -->
         <c:if test="${privateCheck eq '1' || privateCheck eq '3'}"><div style="height:300px; margin-top:150px;">비공개입니다.</div></c:if>
      <!-- 비공개 처리 안한 경우 -->
      <c:if test="${privateCheck eq '0' || privateCheck eq '2'}">
      <button type="submit" <c:if test="${selectZzim eq '7'}">class="btn-review on"</c:if>
            <c:if test="${selectZzim ne '7'}">class="btn-review"</c:if>
         id="check7">내가 찜한 모임 (${fn:length(mypageInfo[7]) })</button>      
      <button type="submit" <c:if test="${selectZzim eq '8'}">class="btn-review on"</c:if>
            <c:if test="${selectZzim ne '8'}">class="btn-review"</c:if>
         id="check8">내가 찜한 자유게시판 (${fn:length(mypageInfo[8]) })</button>
      
                           <c:if test="${selectZzim eq '7' }">
                           <section id="7" class="pro_sec">
                              <div class="container" >
                                 <div class="row gy-5" >
                                 <c:if test="${fn:length(mypageInfo[7]) ne 0}">      
                              <c:forEach begin="0" end="${fn:length(mypageInfo[7])}" items="${mypageInfo[7]}" var="mypage">
                              <div class="col-lg-3 menu-item">
                              <div class="row gy-5" id="zzimMoim">
                                 <a onclick= "location.href='/moim/${mypage.MO_CATEGORY}/${mypage.MO_IDX}.sosu'">
                                 <input type="hidden" name="MO_CATEGORY" value="${mypage.MO_CATEGORY}">
                              <input type="hidden" name="MO_IDX" value="${mypage.MO_IDX}">
                              <img src="${pageContext.request.contextPath}/resources/img/upload/${mypage.F_SVNAME}" class="moim-img">
                                </a>
                                <p class="detail-region">${mypage.MO_DETAILREGION }</p>
                                 <p class="moim-title">${mypage.MO_TITLE}
                                 <span class="moim-people">[${mypage.MOIMMEMBER} / ${mypage.MO_MAXPEOPLE }]
                                 <span class="detail-cate" > # ${mypage.MO_DETAILCATEGORY }</span></span></p>
                                 <hr class="hrhr">
                                 <p class="mo-cost" style="margin-top:10px"> 
                                 <fmt:formatNumber type="number" maxFractionDigits="3" value="${mypage.MO_COST }" />￦
                                 <span class="parent"><input type="button" disabled value="♥" class="heart"></span></p>
                                 </div>
                                 </div>
                              </c:forEach>
                              </c:if>
                              <c:if test="${fn:length(mypageInfo[7]) eq 0}">
                               <div style="height:300px; margin-top:150px;">찜한 모임이 없습니다!!</div>
                               </c:if>
                              </div>
                              </div>
                              </section>
                           </c:if>
            
                           <c:if test="${selectZzim eq '8' }">
                           <section id="8" class="pro_sec">
                           <div class="container" >
                           <div class="row gy-5" >
                           <c:if test="${fn:length(mypageInfo[8]) ne 0}">      
                           <c:forEach begin="0" end="${fn:length(mypageInfo[8])}" items="${mypageInfo[8]}" var="mypage">
                              <div class="col-lg-3 menu-item">
                              <div class="row gy-5" >
                                 <img src="${pageContext.request.contextPath}/resources/img/icons/list.png" class="moim-img">
                                 <p class="zzimWriter">
                                 <span>
                                 <img class="img-pro-free" src="${pageContext.request.contextPath}/resources/img/upload/${mypage.PROFILE}">
                                 </span>
                                 &nbsp;${mypage.FR_WRITER}</p>
                                 <p class="zzimtitle"> ${mypage.FR_TITLE }</p>
                                 <hr class="hrhr">
                                 <span class="parent"><input type="button" disabled value="♥" class="heart"></span>
                                 </div>
                                 </div>
                              </c:forEach>
                              </c:if>
                              <c:if test="${fn:length(mypageInfo[8]) eq 0}">
                               <div style="height:300px; margin-top:150px;">찜한 자유게시판이 없습니다!!</div>
                               </c:if>
                              </div>
                              </div>
                              </section>
                           </c:if>
            </c:if>
            </section>
      </c:if>
   
   </form>
    <a href = "/main.sosu" style="text-decoration: none;">
<button type ="button" class = "mrgbtn">메인으로</button></a>
</div>
</body>
</html>