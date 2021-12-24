<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="login" value="${ses != null}"></c:set>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '관리자'}"></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/commons.css">
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/layout.css">

<style>
.logo-wrapper {
	width: 130px;
}

.logo-wrapper>img {
	width: 100%;
	height: 100%;
}

.title-wrapper {
	flex-grow: 1;
}
.memberInfo_wrap{
	display:flex;
}
.memberInfo_wrap2{
	display: block;
	padding: 2px 2px 2px 2px;
	margin: 0px
}

img { 
	display: block;
	vertical-align: top;
}




</style>

</head>
<body>
<!-- 메인시작 -->
	<main>
		<!--  헤더시작   -->
		<header>
			<div class="flex-container">
				<div class="flex-equal container-left">
					<a href="${root}">
						<img src="${root}/resources/image/메인로고.png" height="120px" width="250px">
					</a>
				</div>
				<div class="flex-equal center">
					<div>로그인 상태 : ${login}</div>
					<div>등급 : ${grade}</div>
				</div>
				<div class="flex-equal container-right" style="padding-top: 30px" >
					<ul class="memberInfo_wrap" >
						<c:if test="${!login}">
							<li>
								<a href="${root}/member/login">
									<img src="${root}/resources/image/로그인.png"  class="memberInfo_wrap2" width="50px" height="50px">
									<span>로그인</span>
								</a>
							</li>
							<li>
								<a href="${root}/member/join">
									<img src="${root}/resources/image/회원가입.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>회원가입</label>
								</a>
							</li>
						</c:if>
						<c:if test="${login}">
							<li>
								<a href="${root}/member/logout">
									<img src="${root}/resources/image/로그인.png"  class="memberInfo_wrap2" width="50px" height="50px">
									<span>로그아웃</span>
								</a>
							</li>						
							
						</c:if>
							<li>
								<a href="#">
									<img src="${root}/resources/image/마이페이지.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>마이페이지</label>
								</a>
						    </li>
						    <li>
								<a href="#">
									<img src="${root}/resources/image/고객센터.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>고객센터</label>
								</a>
						    </li>
						
			
					</ul>	
	
				</div>
			</div>

		</header>
		<!-- 헤더 끝 -->
		<!-- 네비게이션 시작 -->
		<nav>
			<ul class="slide-menu">

						<li><a href="${root}/movie/">영화</a></li>
						<li><a href="${root}/theater/">극장</a></li>
						<li><a href="${root}/reservation/">예매</a></li>
				<c:choose>
					<c:when test="${login}">
								<c:choose>
									<c:when test="${admin}">
										<li><a href="${root}/admin/">관리메뉴</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="${root}/member/logout">로그아웃</a></li>
										<li><a href="${root}/member/mypage">마이페이지</a></li>
										<li><a href="#">고객센터</a>
									</c:otherwise>
								</c:choose>
					</c:when>
					<c:otherwise>
						<li><a href="${root}/member/login">로그인</a></li>
						<li><a href="${root}/member/join">회원가입</a></li>
						<li><a href="#">고객센터</a>
					</c:otherwise>
				</c:choose>


			</ul>
		</nav>

		<section>