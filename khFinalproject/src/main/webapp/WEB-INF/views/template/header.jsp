<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="login" value="${ses != null}"></c:set>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<c:set var="memberNo" value="${memberNo}"></c:set>

<!DOCTYPE html>z
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">
<!-- Bootstrap CSS CDN-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://bootswatch.com/5/journal/bootstrap.css" type="text/css" rel="stylesheet">
<!-- jquey cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--Bootstrap bundle CSS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- sha1 암호화 cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

<style>
 #header{
 padding: 0;
 }
 .b{
      border:1px solid black;
  }
</style>

</head>
<script>
// 	 //form이 전송되면 input[type=password]가 자동 암호화되도록 설정
// 	$(function(){
// 	$("form").submit(function(e){
// 		e.preventDefault();//form 기본 전송 이벤트 방지
	
// 		//this == form
// 		//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
// 		$(this).find("input[type=password]").each(function(){
// 			//this == 입력창
// 			var origin = $(this).val();
// 			console.log(origin);
// 			var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
// 			var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
// 			$(this).val(encrypt);
// 		});
		
// 		this.submit();//form 전송 지시
// 	});
// 	});
</script>
<body>
<!-- 메인시작 -->
	<main>
		<!--  헤더시작   -->
		<header id="header">
			<div class="container-fluid ">
				<div class="row">
					<div class="col-3">
					<br><br><br>
						<div class="row center">
							<div class="col-6">
								<h4>로그인: ${login}</h4>
							</div>
							<div class="col-6">
								<h4>등급 : ${grade}</h4>
								<h4>회원번호 : ${memberNo}</h4>
							</div>
						</div>
					</div>
					
					<div class="col-6 center">
						
						<a href="${root}">
							<img src="${root}/resources/image/메인로고.png" height="160px" width="250px">
						</a>					
					</div>
					
					<div class="col-1">
					</div>
					
					<div class="col-1">
					<ul>
							<c:if test="${!login}">							
									<li>
									<a href="${root}/member/login">
										<img src="${root}/resources/image/로그인.png"  width="50px" height="50px">
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
					</ul>
	
					</div>
				
					<div class="col-1">
						<ul>
							<li>
								<a href="${root}/member/mypage">
									<img src="${root}/resources/image/마이페이지.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>MYPAGE</label>
								</a>
							</li>
							<li>
								<a href="${root}/board/main?boardTypeName=1">
									<img src="${root}/resources/image/고객센터.png" class="memberInfo_wrap2" width="50px" height="50px">
									<label>고객센터</label>
								</a>
							</li>	
						</ul>
					</div>
						
					
				</div>
			</div>

		</header>
		<!-- 헤더 끝 -->
		<!-- 네비게이션 시작 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
 <div class="container-fluid">	
	<div class="collapse navbar-collapse" id="navbarColor02">
      <ul class="navbar-nav me-auto">
          <li class="nav-item">
          	<a class="nav-link active" href="${root}">HOME
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${root}/movie/movieChart">영화
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${root}/theater/list">극장</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${root}/reservation/">예매</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${root}/store/storeMain">스토어</a>
        </li>
        <c:if test="${admin}">
        <li class="nav-item">
          <a class="nav-link active" href="${root}/admin/">관리자페이지</a>
        </li>
        </c:if>
        <li class="nav-item dropdown">
        	
        	<a class="nav-link dropdown-toggle active" data-bs-toggle="dropdown" href="${root}/board/main?boardTypeName=1" role="button" aria-haspopup="true" aria-expanded="false">고객센터</a>
        	<div class="dropdown-menu">
				<a class="dropdown-item" href="${root}/board/main?boardTypeName=2">자주찾는질문</a>
            	<a class="dropdown-item" href="${root}/board/main?boardTypeName=3">공지/뉴스</a>
            	<a class="dropdown-item" href="${root}/board/main?boardTypeName=4">분실물문의</a>
            	<div class="dropdown-divider"></div>
           		<a class="dropdown-item" href="${root}/board/main?boardTypeName=5">단체대관/문의</a>
          </div>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-sm-2" type="text" placeholder="Search">
        <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

		<section>