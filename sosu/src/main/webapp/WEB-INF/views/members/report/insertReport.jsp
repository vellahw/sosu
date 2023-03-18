<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
function reportClose(){
   window.close();
}

$(document).ready(function(){
    $('#reportInsert').on('click',function(e){
       var r_reason = $('#r_reason').val();
       var r_detail = $('#r_detail').val();
       console.log(r_reason);
       
       //질문 선택안한 경우
       if(r_reason==null || r_reason==''){
            alert("신고 사유를 선택해주세요");
            $('#r_reason').focus();
            return false;
         }
       
       //상세내용이 없을 경우
       if(r_detail==null || r_detail==''){
          alert("내용을 입력해주세요");
          $('#r_detail').focus();
          return false;
       }
       
       if((r_detail != null || r_detail != '')&&(r_reason != null || r_reason != '' )){
          var param = $("form[name=reportForm]").serialize();
           $.ajax({
               	type : "POST",
				url : "/members/report.sosu",
                contentType: "application/json",
                data : param,
                dataType:'json',
             })
       	}
    });
});

</script>

<div class="container">
<c:if test="${impossible ne null}">
   <h3>이미 신고가 완료된 회원입니다.</h3>
   <input type="button" value="닫기" onclick="reportClose();">
</c:if>

<c:if test="${impossible eq null}">
<c:if test="${close eq null}">
<form action="/members/report.sosu" name="reportForm" method="post" id="report">

   <div><h2>신고사유</h2></div>
   
      <input type="hidden" name="M_IDX" value="${M_IDX}">
   
      <div>
         <select name="R_REASON" id="r_reason">
            <option value="">질문을 선택해주세요.</option>
            <option value="1">폭언/욕설</option>
            <option value="2">개인정보 노출 게시물</option>
            <option value="3">도배, 불법 광고</option>
            <option value="4">음란물</option>
            <option value="5">기타</option>
         </select>
      </div>
      
      <div><h2>상세내용</h2></div>
      <div><textarea id="r_detail" rows="17" name="R_DETAIL" placeholder="내용 작성"></textarea></div>
   
      <input type="submit" value="신고하기" id="reportInsert">
      </form>
   </c:if>
   
   <c:if test="${close ne null}">
         <h3>신고가 완료됐습니다.</h3>
         <input type="button" value="닫기" id="reportClose" onclick="reportClose();">
   </c:if>
   </c:if>
</div>

</body>
</html>