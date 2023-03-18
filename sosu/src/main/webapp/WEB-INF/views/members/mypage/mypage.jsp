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
<script defer type="text/javascript" src="/resources/js/mypage.js"></script>
<script src="/resources/js/common.js"></script>
<link href="/resources/css/mypage.css" rel="stylesheet">
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
</head>

<body>

<div class="container" style="text-align:center">
   <h1 style="margin-top:50px; margin-bottom:40px">MY PAGE</h1>
      <div class="pro_firsttt">
         <!-- 프로필 사진  -->
         <form enctype="multipart/form-data">
            <img class="img-pro" src="${pageContext.request.contextPath}/resources/img/upload/${mypageInfo[9][0].F_SVNAME}"><br/>
         </form>

      <!-- 공통 정보 -->
      <!-- 닉네임 + 수정하기 버튼 -->
      <p class="nickname">${mypageInfo[0][0].M_NICKNAME} 
         <span><a href="/members/mypagemodifyform.sosu">
         <img class="img-modi" src="/resources/img/icons/modify.png">
         </a></span>
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
   
   
   <form action="/members/mypage.sosu" method="get">
      <input type="hidden" id="category" class="mypageCategory" name="mypageCategory" value="">
      <input type="hidden" id="review" name="selectReview" value="">
      <input type="hidden" id="zzim" name="selectZzim" value="">
      
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
      <div class="container" >
      <div class="row gy-5" >
         
         <c:if test="${fn:length(mypageInfo[3]) ne 0 }">
            <c:forEach begin="0" end="${fn:length(mypageInfo[3])}" items="${mypageInfo[3]}" var="mypage">
            <div class="col-lg-3 menu-item">
            <div class="row gy-5" style="padding-bottom: 80px;">
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
               
               <span class="moim-people">
                        <c:if test="${mypage.MO_MAXPEOPLE ne '0' }">
                     [${mypage.MOIMMEMBER}명 / ${mypage.MO_MAXPEOPLE }명]
                     </c:if>
                     <c:if test="${mypage.MO_MAXPEOPLE eq '0' }">
                     [제한없음]
                     </c:if>
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
   <div class="container" >
   
   
   <p>비공개 처리
      <label class="switch-button" >
         <input type="checkbox" onclick="checkReview()" id="private1" value="1" <c:if test="${privateCheck eq '1' || privateCheck eq '2'}">checked</c:if>>
      <span class="onoff-switch"></span>
   </label></p>
   
   <div class="row gy-5" >
   <c:if test="${fn:length(mypageInfo[4]) ne 0}">
      <c:forEach begin="0" end="${fn:length(mypageInfo[4])}" items="${mypageInfo[4]}" var="mypage" varStatus="status">
      <div class="col-lg-3 menu-item">
      <div class="row gy-5" style="padding-bottom: 80px;">
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
         <span class="moim-people">
                <c:if test="${mypage.MO_MAXPEOPLE ne '0' }">
                     [${mypage.MOIMMEMBER}명 / ${mypage.MO_MAXPEOPLE }명]
                     </c:if>
                     <c:if test="${mypage.MO_MAXPEOPLE eq '0' }">
                     [제한없음]
                     </c:if>
         <span class="detail-cate"> # ${mypage.MO_DETAILCATEGORY }</span></span>
         <hr class="hrhr">
         
      </div>
      </div>
      </c:forEach>
      </c:if>
   </div>
   
         <c:if test="${fn:length(mypageInfo[4]) eq 0}">
             <div style="height:300px; margin-top:150px;">참여한 모임이 없습니다!!</div>
          </c:if>
   </div>
   </section>
   </c:if>
   
   
   <!-- 리뷰 카테고리 -->
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
         <div class="row gy-5" >
         
            <c:if test="${fn:length(mypageInfo[5]) ne 0}">
               <c:forEach begin="0" end="${fn:length(mypageInfo[5])}" items="${mypageInfo[5]}" var="mypage">
                  <div class="col-lg-3 menu-item">
                  <div class="row gy-5" style="padding-bottom: 80px;">
                     <a
                                 onclick="location.href='/review/${mypage.MO_CATEGORY}/${mypage.RV_IDX}.sosu'">
                                 <c:choose>
                                    <c:when test="${not empty mypage.F_SVNAME}">
                                    <img
                                    src="${pageContext.request.contextPath}/resources/img/upload/${mypage.F_SVNAME}"
                                    class="moim-img"> 
                                    </c:when>
                                    <c:otherwise>
                                       <img
                                       src="${pageContext.request.contextPath}/resources/img/icons/list.png"
                                       class="moim-img">
                                    </c:otherwise>
                                 </c:choose>
                                 <input type="hidden" name="RV_IDX"
                                 value="${mypage.RV_IDX}"> <input type="hidden"
                                 name="MO_CATEGORY" value="${mypage.MO_CATEGORY}"> <input
                                 type="hidden" name="M_IDX" value="${mypage.M_IDX}">
                              </a>
                  
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
                  <div class="row gy-5" style="padding-bottom: 80px;">
                     <img src="${pageContext.request.contextPath}/resources/img/icons/list.png" class="moim-img">
                         <c:if test="${fn:length(mypage.MO_TITLE) >= 5}">
                            <p class="rezimm-title">${mypage.MO_TITLE}...
                        </c:if>
                        
                        <c:if test="${fn:length(mypage.MO_TITLE) < 11}">
                            <p class="rezimm-title">${mypage.MO_TITLE}
                        </c:if>
                     
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
   
   <!-- 찜 카테고리 -->
   <c:if test="${mypageCategory eq '4' }">
   <section id="6" class="pro_sec">
         <p >비공개 처리
         <label class="switch-button">
           <input type="checkbox" onclick="checkZzim()" id="private2" value="1" <c:if test="${privateCheck eq '1' || privateCheck eq '3'}">checked</c:if>>
            <span class="onoff-switch"></span>
         </label></p>
   </section>
   
      <section id="7" class="pro_sec">
   <button type="submit" <c:if test="${selectZzim eq '7'}">class="btn-review on"</c:if>
         <c:if test="${selectZzim ne '7'}">class="btn-review"</c:if>
      id="check7">내가 찜한 모임 (${fn:length(mypageInfo[7]) })</button>      
      
   <button type="submit" <c:if test="${selectZzim eq '8'}">class="btn-review on"</c:if>
         <c:if test="${selectZzim ne '8'}">class="btn-review"</c:if>
      id="check8">내가 찜한 자유게시판 (${fn:length(mypageInfo[8]) })</button>      
      </section>

   
   <c:if test="${selectZzim eq '7' }">
   <section id="8" class="pro_sec">
   <div class="container" >
      <div class="row gy-5"  >
      
         <c:if test="${fn:length(mypageInfo[7]) ne 0}">      
            <c:forEach begin="0" end="${fn:length(mypageInfo[7])}" items="${mypageInfo[7]}" var="mypage">
               <div class="col-lg-3 menu-item">
               <div class="row gy-5" id="zzimMoim" style="padding-bottom: 80px;">
               <a onclick= "location.href='/moim/${mypage.MO_CATEGORY}/${mypage.MO_IDX}.sosu'">
               <input type="hidden" name="MO_CATEGORY" value="${mypage.MO_CATEGORY}">
            <input type="hidden" name="MO_IDX" value="${mypage.MO_IDX}">
            <img src="${pageContext.request.contextPath}/resources/img/upload/${mypage.F_SVNAME}" class="moim-img">
               </a>
                  <p class="detail-region">${mypage.MO_DETAILREGION }</p>
                  <p class="moim-title">${mypage.MO_TITLE}</p>
                  <span class="moim-people">
                         <c:if test="${mypage.MO_MAXPEOPLE ne '0' }">
                     [${mypage.MOIMMEMBER}명 / ${mypage.MO_MAXPEOPLE }명]
                     </c:if>
                     <c:if test="${mypage.MO_MAXPEOPLE eq '0' }">
                     [제한없음]
                     </c:if>
                  <span class="detail-cate" > # ${mypage.MO_DETAILCATEGORY }</span></span>
                  <hr class="hrhr">
                 
                   
                   <span id="parent" class="parent">
                   <input type=hidden value="${mypage.Z_IDX}" id="zIDX">
                   <input type="hidden" value="N" id="zDelYN">
                     <c:if test="${mypage.Z_DEL_YN eq 'N'}"> 
                        <input type="button" id="delZzim1" name="Z_IDX" value='❤️' class="heart"></c:if>
                      
                     <c:if test="${memberDetail[0].Z_DEL_YN eq 'Y'}"> 
                        <input type="button" id="delZzim1" name="Z_IDX" value="🤍" class="non-heart"></c:if>
                     </span>
                     
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
          <section id="9" class="pro_sec">
          <div class="container" >
      <div class="row gy-5" >
      
         <c:if test="${fn:length(mypageInfo[8]) ne 0}">      
            <c:forEach begin="0" end="${fn:length(mypageInfo[8])}" items="${mypageInfo[8]}" var="mypage">
               <div class="col-lg-3 menu-item">
               <div class="row gy-5" style="padding-bottom: 80px;">
               ""
               <a onclick= "location.href='/freeboard/${mypage.FR_CATEGORY}/${mypage.FR_IDX}.sosu'">
               <c:if test="${mypage.FREEIMG ne null }">
                  <img src="${pageContext.request.contextPath}/resources/img/upload/${mypage.FREEIMG}" class="moim-img">
               </c:if>
               <c:if test="${mypage.FREEIMG eq null }">
                  <img src="${pageContext.request.contextPath}/resources/img/icons/list.png" class="moim-img">
               </c:if>
               </a>
                  <p class="zzimWriter">
                  <span>
                  <img class="img-pro-free" src="${pageContext.request.contextPath}/resources/img/upload/${mypage.PROFILE}">
                  </span>
                  &nbsp;${mypage.FR_WRITER}</p>
                  <p class="zzimtitle"> ${mypage.FR_TITLE }</p>
                  <hr class="hrhr">
                  
                  <div id="parent" class="parent">
                   <input type=hidden value="${mypage.Z_IDX}" id="zIDX">
                   <input type="hidden" value="N" id="zDelYN">
                            <c:if test="${mypage.Z_DEL_YN eq 'N'}"> 
                        <input type="button" id="delZzim2" name="Z_IDX"  value='❤️' class="heart"></c:if>
                        <c:if test="${memberDetail[0].Z_DEL_YN eq 'Y'}"> 
                        <input type="button" id="delZzim2" name="Z_IDX" value="🤍" class="heart"></c:if>

                  </div>
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
   
   </form>
    <a href = "/main.sosu" style="text-decoration: none;">
<button type ="button" class = "mrgbtn">메인으로</button></a>
</div>

</body>