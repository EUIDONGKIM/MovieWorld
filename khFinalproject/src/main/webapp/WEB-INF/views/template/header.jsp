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
<link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">
<!-- sha1 암호화 cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
<!--bootstrap cdn


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
-->
<!-- bootstrap javascript cdn
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

-->
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

</style>
<script>
// //form이 전송되면 input[type=password]가 자동 암호화되도록 설정
// $(function(){
// 	$("form").submit(function(e){
// 		e.preventDefault();//form 기본 전송 이벤트 방지
		
// 		//this == form
// 		//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
// 		$(this).find("input[type=password]").each(function(){
// 			//this == 입력창
// 			var origin = $(this).val();
// 			var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
// 			var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
// 			$(this).val(encrypt);
// 		});
		
// 		this.submit();//form 전송 지시
// 	});
// });

</script>

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
								<a href="${root}/member/mypage">
									<img src="${root}/resources/image/마이페이지.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>마이페이지</label>
								</a>
						    </li>
						    <li>
								<a href="${root}/board/main">
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

						<li><a href="${root}/movie/movieChart">영화</a></li>
						<li><a href="${root}/theater/list">극장</a></li>
						<li><a href="${root}/reservation/">예매</a></li>
						<li><a href="${root}/admin/">관리메뉴</a></li>
						<li><a href="${root}/store/storeMain">스토어</a></li>
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