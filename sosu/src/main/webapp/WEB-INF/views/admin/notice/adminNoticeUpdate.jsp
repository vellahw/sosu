<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript">

$(document).ready(function(){

   
   
   $('#update').on('click',function(e){
      var title = $('#title').val();
      var content = $('#content').val();
      
      if(title == null || title == ''){
         alert("제목을 입력해주세요");
         $('#title').focus();
         return false;
      }
      
      if(content = null || content ==''){
         alert("내용을 입력해주세요");
         $('#content').focus();
         return false;
      }
      
      
   })
   
})
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/qna.css" rel="stylesheet">
<link href="/resources/css/join.css" rel="stylesheet">

</head>
<body>
<%
   pageContext.setAttribute("crcn","\r\n");
   pageContext.setAttribute("br","<br>");

%>

<div class="container" style="text-align:center;">
<h1 style="margin-top:50px; margin-bottom:40px">공지사항 수정</h1>
<form action="/admin/noticeUpdate.sosu" method="post">

<input type="hidden" name="N_IDX" value="${update.N_IDX}">

<table class="input-form" >
   <colgroup>
   <col style="width:150px;">
   <col style="width:auto;">
   </colgroup>
      
      <tbody>
         <tr>
            <th class="header"><label for="m_name" >제목</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><input type="text" name="N_TITLE" value="${update.N_TITLE}" id="title"></td>
         </tr>   
         
         <tr>
            <th class="header"><label for="m_name" >내용</label><span style="color:#fd8731;">*</span></th>
            <td class="contents"><textarea name="N_CONTENT" placeholder="${fn:replace(update.N_CONTENT,crcn,br)}" class="noticeupdatecontent" id="content"></textarea>
            </td>
         </tr>
   </tbody>
   </table>


<input type="submit" value="수정" class="btn" id="update">

</form>
</div>

</body>
</html>