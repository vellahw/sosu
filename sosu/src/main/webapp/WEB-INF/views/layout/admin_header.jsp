<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<link href="/resources/css/main.css" rel="stylesheet">

<div style="height: 90px;"
	class="parent">

	<!--============== 로고  ==============-->
	<div class="first_admin">
		<a href="/main.sosu" class="a-main"><img class="logo" src="/resources/img/logo.png" id="logo-btn"></a>
	</div>

	<!--============== 카테고리 ==============-->
	<div class="second_admin">
		<ul>
			<li class="dropdown"><a href="/admin/memberlist.sosu" class="cate-admin">회원관리</a>
                  <ul>
                     <li><a href="/admin/memberlist.sosu?listType=adminReportMemberList" class="down-admin">신고회원관리</a></li>
                     <li><a href="/admin/memberlist.sosu?listType=adminStopMemberListt"class="down-admin">정지회원관리</a></li>
                  </ul>
            </li>
			<li><a href="/admin/qnalist.sosu" class="cate-admin">Q&A관리</a></li>
			<li><a href="/admin/noticeList.sosu" class="cate-admin">공지관리</a></li>
		</ul>
	</div>

	<!--============== 로그인 메뉴 ==============-->
	<div class="third_admin">
		<ul id="header_navi">
         <li><a href="/members/logout.sosu" class="a-main"><img class="imgg" src="/resources/img/icons/logout.png"><span>LOGOUT</span></a>
         </li>
       </ul>
	</div>
	
</div>
</html>