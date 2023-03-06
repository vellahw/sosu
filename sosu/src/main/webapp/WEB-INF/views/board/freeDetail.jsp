<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/freeboard.js"></script>
<link href="/resources/css/free.css" rel="stylesheet">
<title>소수 자유게시판</title>
</head>
<main>
   <article>
       <form action="/freeboard/deletefree.sosu" method="post" onsubmit="return confirm('삭제하시겠습니까?')">
         <input type="hidden" name="FR_IDX" value="${map.FR_IDX }">
         <input type="hidden" name="M_IDX" value="${map.M_IDX }">
             <div class="board_wrap">          
               <div class="board_view_wrap">
                   <div class="board_view">
                      <div class="title">
                         ${map.FR_TITLE }
                      </div>
                      <div class="info">
                         <dl>
                            <dt>카테고리</dt>
                            <dd>${map.FR_CATEGORY }</dd>
                         </dl>
                         <dl>
                            <dt>작성자</dt>
                            <dd>${map.FR_WRITER }</dd>
                         </dl>
                         <dl>
                            <dt>작성일</dt>
                            <dd>${map.FR_REGDATE }</dd>
                         </dl>
                         <dl>
                            <dt>수정여부</dt>
                            <dd>${map.RE_MOD_YN }</dd>
                         </dl>
                      </div>
                      <div class="cont">${map.FR_CONTENT }
                         <c:forEach items="${Flist}" var="Flist">
                            <c:if test="${Flist.F_SVNAME != '0' }">
                              <center>
                                 <img src="${pageContext.request.contextPath}/resources/img/upload/${Flist.F_SVNAME }"  style="max-width: 100%; height: auto;"/>
                              </center>
                           </c:if>
                           <c:if test="${Flist.F_SVNAME == '0' }">
                           </c:if>
                        </c:forEach>
                      </div>
                     <div class="bt_wrap">      
                        <a href="/freeboard/${map.FR_CATEGORY }.sosu" class="list">목록으로</a>
                        <c:if test="${map.M_IDX == M_IDX }">
                        <a class="use_move update" href="/freeboard/updateForm/${map.FR_CATEGORY }/${map.FR_IDX }.sosu" onclick="move(this, 'in', 'FR_IDX')">
                           수정하기                        
                        </a>
                        <button type="submit">삭제하기</button>
                        </c:if>
                     </div>
                   </div>
                </div>
            </div>
       </form>   
   </article>
</main>