<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link href="/resources/css/form.css" rel="stylesheet">
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script> 
<script src="/resources/js/freeInsert.js"></script>
<script src="/resources/js/common.js"></script>


<title>자유게시판 작성</title>
</head>
<body>
<div class="container" style="text-align:center; margin-bottom: 100px;">
<h2 style=" margin-top: 90px; margin-bottom: 50px;">게시글 작성</h2>
<form id="frm" name="insertForm" enctype="multipart/form-data">
<input type="hidden" name="FR_IDX" value="${FR_IDX }">
<table class="input-form">
   <colgroup>
       <col style="width:150px;">
       <col style="width:auto;"> 
    </colgroup>   
   <tbody>   
      <tr>
         <th class="header">
            <label for="FR_TITLE">제목</label>
            <span style="color:#fd8731;">*</span>
         </th>
            <td class="contents">
            <input type="text" class="form-control" id="FR_TITLE" name="FR_TITLE" maxlength="70" placeholder="제목을 입력하세요" style="width: 754px;">
         </td>
      </tr>
      <tr>
         <th class="header">
            <label for="FR_CATEGORY">카테고리</label>
            <span style="color:#fd8731;">*</span>
         </th>
         <td class="contents">
            <select id="FR_CATEGORY" name="FR_CATEGORY" required>
               <option value="culture">문화/예술</option>
                      <option value="sports">운동/스포츠</option>
                     <option value="game">게임/오락</option>
                      <option value="outdoor">아웃도어/여행</option>
                      <option value="food">음식</option>
                      <option value="etc">기타</option>
            </select>
         <td>
      </tr>
      <tr>
         <th class="header">
            <label for="FR_WRITER">작성자</label>
            <span style="color:#fd8731;">*</span>
         </th>
         <td class="contents">
            ${M_NICKNAME }
            <input type="hidden" name="FR_WRITER" value="${M_NICKNAME }">
         </td> 
      </tr>
      <tr>
         <th class="header">
            <label for="textArea_byteLimit">내용</label>
            <span style="color:#fd8731;">*</span>
         </th>
            <td class="contents">
            <textarea style="width: 100%;" rows="17" class="form-control" name="FR_CONTENT" placeholder="내용을 입력하세요" class="form-control" id="textArea_byteLimit" name="textArea_byteLimit" onkeyup="fn_checkByte(this)" wrap="hard" cols = ""></textarea>
                   <sup>(<span id="nowByte">0</span>/2000bytes)</sup>
         </td> 
      </tr>
      <tr>
            <th class="header">
               <label for="file" >이미지 첨부</label>
            </th>
            <td class="contents" id="fileDiv">
               <span>메인이미지</span><br>
            <input type="file" name="mainIamge">
               <br>
                 <span>
                    <input type="file" id="file" name="file_0">
               <a href="#this" class="btn" id="delete" name="delete">삭제</a>
            </span>
            </td>
         </tr> 
   </tbody>
</table>
   <div align="center">   
      <a href="#this" class="btn" id="addFile">파일 추가</a>
      <a href="#this" class="btn" id="write">작성하기</a>
      <a href="/freeboard/${FR_CATEGORY }.sosu" class="btn">목록으로</a>
   </div>   
</form>
</div>
</body>
</html>