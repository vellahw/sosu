<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/css/form.css" rel="stylesheet">
<meta charset="UTF-8" name="viewport"
   content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script defer type="text/javascript" src="/resources/js/moimRegister.js"></script>
<script type="text/javascript">
history.replaceState({}, null, location.pathname);
</script>
</head>
<body>
<div class="container" style="text-align:center; margin-bottom: 100px;">
<h2 style=" margin-top: 90px; margin-bottom: 50px;">모임 개설하기</h2>
   <form action="/moim/moimRegister.pro" method="post" encType="multipart/form-data" name="moimR" onsubmit="return check()">
            
    <input type="hidden" name="M_IDX" value = "${M_IDX}">
               
    <table class="input-form" >
      <colgroup>
      <col style="width:150px;">
      <col style="width:auto;"> 
      </colgroup>
   
         <tbody>
            <tr>
               <th class="header"><label for="MO_TITLE" >제목</label><span style="color:#fd8731; margin-left:3px;">*</span></th>
               <td class="contents"><input type="text" class="form-control" name="MO_TITLE" id="MO_TITLE"
                  placeholder="제목 입력(4-70)" style="width: 754px;"></td>
            </tr>
            
            <tr>
               <th class="header"><label for="MO_CATEGORY" >카테고리</label><span style="color:#fd8731; margin-left:3px;">*</span></th>
               <td class="contents">
                  <select name="MO_CATEGORY" class="mo_cate" id="MO_CATEGORY">
                       <option value="culture" <c:if test="${MO_CATE == 'culture'}">selected="selected"</c:if>>문화/예술</option>
                        <option value="sports" <c:if test="${MO_CATE == 'sports'}">selected="selected"</c:if>>운동/스포츠</option>
                        <option value="game"  <c:if test="${MO_CATE == 'game'}">selected="selected"</c:if>>게임/오락</option>
                        <option value="outdoor" <c:if test="${MO_CATE == 'outdoor'}">selected="selected"</c:if>>아웃도어/여행</option>
                        <option value="food" <c:if test="${MO_CATE == 'food'}">selected="selected"</c:if>>음식</option>
                        <option value="etc" <c:if test="${MO_CATE == 'etc'}">selected="selected"</c:if>>기타</option>
                     </select>
                     
                  <label for="mo_detailca" style="padding:0 5px 0 25px; font-size: 15px;">세부 카테고리</label>
                  <span style="color:#fd8731;">*</span>
                   <input type="text" name="MO_DETAILCATEGORY" class="mo_detailca" placeholder="예) 뮤지컬" style ="width:363px;"  maxlength = "10">
               </td>
            </tr>
            
            <tr>
               <th class="header"><label for="selectRegion" >지역</label><span style="color:#fd8731; margin-left:3px;">*</span></th>
               <td class="contents">
                  <select name="MO_REGION" id="selectRegion" class="selectRegion" onchange="addressKindChange(this)" required="required">
                     <option class="sr">지역을 선택해주세요.</option>
                     <option value="중부">중부</option>
                     <option value="동부">동부</option>
                     <option value="서부">서부</option>
                     <option value="남부">남부</option>
                     <option value="북부">북부</option>
                  </select>
                     
                  <label for="selectRDetail" style="padding:0 3px 0 25px; font-size: 15px;">세부 지역</label>
                  <span style="color:#fd8731;">*</span>
                    <select name="MO_DETAILREGION" class="form-control" id="selectRDetail" required="required">
                       <option>선택해주세요.</option>
                    </select>
               </td>
            </tr>
         
         <tr>
               <th class="header"><label for="MO_PERMIT">승인 허가 여부</label><span style="color:#fd8731;margin-left:3px;">*</span></th>
               <td class="gc" style="padding: 15px 0px 15px 0px;">
               <label for="MO_PERMIT" style="vertical-align: middle;">필요</label><input style="vertical-align: middle;" type="radio" name="MO_PERMIT" value="Y" id="MO_PERMIT">
                  <label for="MO_PERMIT" style="vertical-align: middle;">불필요</label><input style="vertical-align: middle;" type="radio" name="MO_PERMIT" value="N">
               </td>
            </tr>
         <tr>
               <th class="header"><label for="MO_GENDER">참가 성별</label><span style="color:#fd8731;margin-left:3px;">*</span></th>
               <td class="gc">
               <label for="MO_GENDER" style="vertical-align: middle;">여성</label><input style="vertical-align: middle;" type="radio" name="MO_GENDER" value="W" id="MO_GENDER">
                  <label for="MO_GENDER" style="vertical-align: middle;">남성</label><input style="vertical-align: middle;" type="radio" name="MO_GENDER" value="M">
                  <label for="MO_GENDER" style="vertical-align: middle;">제한없음</label><input style="vertical-align: middle;" type="radio" name="MO_GENDER" value="0">
               </td>
            </tr>
            <tr>
               <th></th>
               <td style="text-align: left; font-size: small; color: red; padding-bottom: 15px;">
               *참가 성별은 모임 개설 후 수정이 불가능합니다.
               </td>
            </tr>
            <tr>
	            <th class="header">
	            	<label for="MO_MINAGE" >참가 연령</label>
	           		<span style="color:#fd8731;margin-left:3px;">*</span>
	            </th>
	            <td class="contents" id="age-td" style="padding-bottom: 0px;">
	                <input type="number" class="form-control" name="MO_MINAGE" id="MO_MINAGE" maxlength="2" oninput="maxLengthCheck(this)"
	                   	   placeholder="최소 (숫자만 입력해주세요.)" style="margin-right:12px">
	                <span id="wave" style = "font-weight:bold">~</span>
	                <input type="number" class="form-control" name="MO_MAXAGE" id="MO_MAXAGE" maxlength="2" oninput="maxLengthCheck(this)"
	                       placeholder="최대 (숫자만 입력해주세요.)" style="margin-left:12px">
	            </td>
            </tr>   
	        <tr>
	           <th></th>
	           <td>
		    	   <input type="button" id="ageNoLimitBtn" class="noLB" value="제한없음" style="cursor: pointer;">
		           <input type="button" id="ageLimitCancelBtn" class="noLB" value="되돌리기" style="cursor: pointer; display: none;">
	           </td>
	        </tr>
            <tr>
	            <th class="header"><label for="MO_MAXPEOPLE" >참가 인원</label>
	            	<span style="color:#fd8731;margin-left:3px;">*</span>
	            </th>
	            <td class="contents" style="padding-bottom: 0px;">
	            <input type="number" class="form-control" name="MO_MAXPEOPLE" id="MO_MAXPEOPLE"
	                   placeholder="최대 (본인포함, 숫자만 입력해주세요.)" maxlength="100">
            	</td>
         </tr> 
         <tr>
          <th></th>
          <td><button type="button" id="peopleNoLimit" class="noLB" style="cursor: pointer;">제한 없음</button></td>
       </tr>
         
            
           <tr>
            <th class="header"><label for="MO_COST" >참가 비용</label></th>
            <td class="contents" style="padding-bottom: 0px;">
            <input type="number" class="form-control" name="MO_COST" id="MO_COST"
                  placeholder="0" maxlength="100">
            </td>
         </tr>   
         <tr>
            <th></th>
            <td style="text-align: left; font-size: small; color: red; padding-bottom: 15px;">
               *참가 비용이 있다면 숫자로만 작성 해주세요.(ex.1000)
            </td>
         </tr>
         
           <tr>
            <th class="header"><label for="date" >모임 날짜</label><span style="color:#fd8731;margin-left:3px;">*</span></th>
            <td class="contents">
               <input type="date" class="form-control" name="MO_DEADLINE" id="date">
            </td>
         </tr>  
            
         <tr>
            <th class="header"><label for="MO_DEADTIME" >모임 시간</label><span style="color:#fd8731;margin-left:3px;">*</span></th>
            <td class="contents">
               <input type="time" class="form-control" name="MO_DEADTIME" id="date2">
            </td>
         </tr>
         <tr>
            <th class="header"><label for="MO_MAP" >모임 장소</label></th>
            <td class="contents">
               <input type="text" class="form-control" id="MO_MAP" readonly="readonly" name="ADDRESS">
               <button type="button" class="searchMap"
                  		onclick="kaMap()">주소 검색</button>
               <br/>   		
               <input type="text" id="detailAddress" placeholder="상세주소 입력" name="DEADDRESS">
               <div id="map" style="width:500px;height:400px; margin-top: 10px;"></div>
               <input type="hidden" name="WII">
               <input type="hidden" name="KYUNG">
            </td>
         </tr>
         <tr>
            <th class="header"><label for="textArea_byteLimit" >내용</label>
            <span style="color:#fd8731;margin-left:3px;">*</span></th>
            <td class="contents">
               <textarea style="width: 100%; resize: none; height: 12.25em; border: 1px solid #e6e6e6; resize: none; padding: 3px 3px 3px 5px; outline: none;" rows="17" class="form-control"  name="MO_DETAIL" placeholder="내용 작성" class="form-control" id="textArea_byteLimit" name="textArea_byteLimit" onkeyup="fn_checkByte(this)" wrap="hard" cols = ""></textarea>
                 <sup style="color: #c2c2c2; float: right; transform: translate(9px, -1px);">(<span id="nowByte">0</span>/1800bytes)</sup>
            </td>
         </tr> 
            
         <tr>
            <th class="header"><label for="file" >이미지 첨부</label></th>
            <td class="contents">
          <div id = "main" style="margin-bottom: 11px;">메인 이미지 <span>
             <input type="file" name="mainIamge" style="border: none; width: auto;">
            </span>
         </div>
         상세 이미지
            <span>
            <input type="file" id="file" name="file_0" style="border: none; width: auto;">
               <a href="#this" class="btn" id="delete" name="delete">삭제</a>
               <a href="#this" class="btn" id="addFile">파일 추가</a>
            </span>
            <div id="fileDiv"></div>
            </td>
         </tr>  
   </tbody>
   </table>
   
         <input type="submit" value="등록" class="btn2">   
         </form>
      </div>
</body>
 
</html>