<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script defer type="text/javascript" src='/resources/js/common.js'></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script> 
<script type="text/javascript">
history.replaceState({},null,location.pathname);
</script>
<style type="text/css">
/*페이징 디자인*/
.pagination-class{
	margin-top: 30px;
}

.pagination-class a{
	color: black;
   /*  border: 1px solid black; */
    padding: 2px 5px 1px 8px;
    text-decoration: none;
    
}

.pagination-class strong{
	    color: black;
    border: 0px solid black;
    padding: 0px 8px 0px 8px;
    text-decoration: none;
    cursor: pointer;
    border-radius: 20%;
    background-color: #e6e6e6;
}
</style>
<link href="/resources/css/adminmem.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>

<div class="container" style="text-align:center">
	<h1 style="margin-top:50px; margin-bottom:40px">회원 관리</h1>

<table class="admin-table">
   <thead>
      <tr>
         <th>회원번호</th>
         <th>아이디</th>
         <th>닉네임</th>
         <th>이름</th>
         <th>회원상태</th>
         <th>정지일</th>
         <th>신고누적횟수</th>
         <th></th>
      </tr>
   </thead>
   
	<tbody>
		<c:if test="${adminList[0].M_IDX ne null}">
		<c:forEach begin="0" end="${fn:length(adminList)}" items="${adminList}" var="memberList">
            <tr>
            <td>${memberList.M_IDX}</td>
            <td>${memberList.M_EMAIL}</td>
            <td>${memberList.M_NICKNAME}</td>
            <td>${memberList.M_NAME}</td>
            
            <td>
               <c:if test="${memberList.M_DEL_YN eq 'N'}">
                  <p>정상</p>
               </c:if>
               <c:if test="${memberList.M_DEL_YN eq 'S'}">
                 <p class="stop-mem"> 정지</p>
               </c:if>
            </td>
            
            <td>
               <c:if test="${memberList.M_BAN_DATE eq null }">
                  -
               </c:if>
               <c:if test="${memberList.M_BAN_DATE ne null }">
                  <fmt:formatDate value="${memberList.M_BAN_DATE}" pattern="yyyy-MM-dd"/>
               </c:if>
            </td>
            <td>${memberList.RECOUNT}</td>
            <td>
               <form action="/admin/memberdetail.sosu">
                  <input type="hidden" name="M_IDX" value="${memberList.M_IDX}">
                  <input type="hidden" name="RECOUNT" value="${memberList.RECOUNT}">
                  <input type="submit" value="상세보기" class="detail-btn">
               </form>
            </td>
            </tr>
         </c:forEach>
         </c:if>
       
        </tbody>
        
</table>


<!-- 페이징 -->
<div class="pagination-class">
<c:if test="${not empty paginationInfo}">
		<ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
	</c:if>
	<input type="hidden" id="currentPageNo" name="currentPageNo"/>
<form id="commonForm" name="commonForm"></form>
</div>


<script type="text/javascript">
	function fn_search(pageNo){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/admin/memberlist.sosu' />");
		comSubmit.addParam("currentPageNo", pageNo);
		comSubmit.submit();
	}
</script>

</div>

</body>
</html>