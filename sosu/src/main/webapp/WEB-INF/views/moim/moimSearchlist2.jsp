<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/resources/css/list.css" rel="stylesheet">
<body>
	<input type="hidden" value="${sessionss}" id="session">

	<div class="container" style="margin-top: 75px; margin-bottom: 50px;">
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

		<br />
		<div class="row gy-5" style="margin-bottom: 20px;">
			<p
				style="font-weight: bold; margin-bottom: 30px; padding-left: 11px; font-size: 24px;">
				문화/예술 <span style="font-size: 15px;">(총 ${count1.MO_COUNT}개)</span>

				<c:if test="${count1.MO_COUNT gt 4}">
					<a href="/moim/culture.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>
			<c:forEach begin="0" end="3" items="${list1}" var="m" varStatus="var">
				<c:if test="${count1.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>
			</c:forEach>

			<c:if test="${count1.MO_COUNT eq 0}">
				<div class="row gy-5">
					<div class="none" style="margin-bottom: 76px; font-size: 17px;">모임이
						존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
		<hr>
		<br />

		<div class="row gy-5" style="margin-bottom: 20px;">
			<p
				style="font-weight: bold; margin-bottom: 22px; padding-left: 11px; font-size: 24px;">
				스포츠 <span style="font-size: 15px;">(총 ${count2.MO_COUNT}개)</span>

				<c:if test="${count2.MO_COUNT gt 4}">
					<a href="/moim/sports.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>
			<c:forEach begin="0" end="3" items="${list2}" var="m" varStatus="var">
				<c:if test="${count2.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>

			</c:forEach>
			<c:if test="${count2.MO_COUNT eq 0}">
				<div class="row gy-5">
					<div class="none" style="margin-bottom: 76px; font-size: 17px;">모임이
						존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
		<hr>
		<br />

		<div class="row gy-5" style="margin-bottom: 20px;">
			<p
				style="font-weight: bold; margin-bottom: 22px; padding-left: 11px; font-size: 24px;">
				게임 <span style="font-size: 15px;">(총 ${count3.MO_COUNT}개)</span>

				<c:if test="${count3.MO_COUNT gt 4}">
					<a href="/moim/game.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>

			<c:forEach begin="0" end="3" items="${list3}" var="m" varStatus="var">
				<c:if test="${count3.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>
			</c:forEach>
			<c:if test="${count3.MO_COUNT eq '0'}">
				<div class="row gy-5">
					<div class="none" style="margin-bottom: 76px; font-size: 17px;">모임이
						존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
		<hr>
		<br />


		<div class="row gy-5" style="margin-bottom: 20px;">
			<p
				style="font-weight: bold; margin-bottom: 22px; padding-left: 11px; font-size: 24px;">
				아웃도어/여행 <span style="font-size: 15px;">(총
					${count4.MO_COUNT}개)</span>

				<c:if test="${count4.MO_COUNT gt 4}">
					<a href="/moim/outdoor.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>
			<c:forEach begin="0" end="3" items="${list4}" var="m" varStatus="var">
				<c:if test="${count4.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>
			</c:forEach>
			<c:if test="${count4.MO_COUNT eq 0}">
				<div class="row gy-5">
					<div class="none" style="margin-bottom: 76px; font-size: 17px;">모임이
						존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
		<hr>
		<br />


		<div class="row gy-5" style="margin-bottom: 20px;">
			<p
				style="font-weight: bold; margin-bottom: 22px; padding-left: 11px; font-size: 24px;">
				음식 <span style="font-size: 15px;">(총 ${count5.MO_COUNT}개)</span>

				<c:if test="${count5.MO_COUNT gt 4}">
					<a href="/moim/food.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>
			<c:forEach begin="0" end="3" items="${list5}" var="m" varStatus="var">
				<c:if test="${count5.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>
			</c:forEach>
			<c:if test="${count5.MO_COUNT eq '0'}">
				<div class="row gy-5">
					<div class="none" style="margin-bottom: 76px; font-size: 17px;">모임이
						존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
		<hr>
		<br />

		<div class="row gy-5" style="margin-bottom: 50px;">
			<p
				style="font-weight: bold; margin-bottom: 22px; padding-left: 11px; font-size: 24px;">
				기타 <span style="font-size: 15px;">(총 ${count6.MO_COUNT}개)</span>

				<c:if test="${count6.MO_COUNT gt 4}">
					<a href="/moim/etc.sosu?KEYWORD2=${KEYWORD2}"> <input
						type="hidden" name="KEYWORD2" value="${KEYWORD2}">
						<button type="button" class="mrgbtn"
							style="float: right; margin-right: 30px; margin-top: 8px;">더보기</button>
					</a>
				</c:if>
			</p>
			<c:forEach begin="0" end="3" items="${list6}" var="m" varStatus="var">
				<c:if test="${count6.MO_COUNT ne 0}">
					<%@ include file="../moim/include_MSL.jsp"%>
				</c:if>
			</c:forEach>
			<c:if test="${count6.MO_COUNT eq '0'}">
				<div class="row gy-5">
					<div class="none">모임이 존재하지 않습니다.</div>
				</div>
			</c:if>
		</div>
	</div>
</body>