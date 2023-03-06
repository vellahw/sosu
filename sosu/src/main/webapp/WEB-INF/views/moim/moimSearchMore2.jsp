<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/resources/css/list.css" rel="stylesheet">

<body>
	<input type="hidden" value="${MO_CATEGORY}">
	<input type="hidden" value="${KEYWORD2}" name="KEYWORD2">
	<input type="hidden" value="${sessionss}" id="session">

	<div class="container" style="margin-top: 75px;">
		<div class="row gy-5" style="margin-bottom: 90px;">
			<div class="container">
				<div style="font-size: 14.5px; margin-bottom: 0px">
					<div style="font-size: 35px">
						<span style="color: #fd8731; font-weight: bold">'${KEYWORD2}'&nbsp;</span><span>의
							검색 결과</span>
					</div>
					<div class="row gy-5">
						<div class="container">
							<div class="row gy-5">
								<div class="col">
									<div
										style="float: left; font-size: 17.5px; margin-top: 10px; padding-left: 11px;">
										총&nbsp;<strong style="color: #fd8731"><c:out
												value="${count}" /></strong>&nbsp;개의 결과
									</div>
									<%-- <div style="float: left">total <c:out value="${cateSize}"/> Items </div> --%>
								</div>
							</div>
							<hr>
						</div>
					</div>

					<div style="margin-bottom: 30px;">
						<select onchange="location.href=(this.value);">
							<option value="/moim/culture.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'culture'}">selected="selected"</c:if>>문화/예술</option>
							<option value="/moim/sports.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'sports'}">selected="selected"</c:if>>운동/스포츠</option>
							<option value="/moim/game.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'game'}">selected="selected"</c:if>>게임/오락</option>
							<option value="/moim/outdoor.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'outdoor'}">selected="selected"</c:if>>아웃도어/여행</option>
							<option value="/moim/food.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'food'}">selected="selected"</c:if>>음식</option>
							<option value="/moim/etc.sosu?KEYWORD2=${KEYWORD2}"
								<c:if test="${MO_CATEGORY == 'etc'}">selected="selected"</c:if>>기타</option>
						</select>
						
						<div style="float: right; padding: 29px 18px 0 0px;">
							<% if (session.getAttribute("M_IDX") != null) { %>
							<button type="button" onclick="location.href='/moim/moimRegister.sosu'" class="mrgbtn">모임 개설하기</button>
							<% } %>
						</div>
					</div>
				</div>
			</div>

			<c:choose>
				<c:when test="${fn:length(list2) > 0 }">
					<c:forEach items="${list2}" var="m" varStatus="var">
						<%@ include file="../moim/include_MSL.jsp"%>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="row gy-5" style="height: 165px; margin-bottom: 12px;">
						<div class="none">조회된 결과가 없습니다.</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>