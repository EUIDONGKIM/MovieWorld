<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="owner" value="${boardDto.memberEmail == memberEmail}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 container-center">

	<div class="row center">
		<h2>${boardDto.boardNo}번 게시글</h2>		
	</div>
	
	<div class="row">
		<hr>
		<h3>${boardDto.boardTitle}</h3>
		<hr>
	</div>
	
	<div class="row">
		등록일 : ${boardDto.boardTime}
		|
		작성자 : ${boardDto.memberEmail}
		|
		조회수 : ${boardDto.boardViews}
	</div>
	
	<div class="row" style="min-height:250px;">
		<pre>${boardDto.boardContent}</pre>
	</div>
	
	<div class="row right">
		<a href="write" class="link-btn">글쓰기</a>
		<a href="write?boardSuperno=${boardDto.boardNo}" class="link-btn">답글쓰기</a>
		<a href="list" class="link-btn">목록보기</a>
		
		<c:if test="${owner}">
		<a href="edit?boardNo=${boardDto.boardNo}" class="link-btn">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}" class="link-btn">삭제하기</a>
		</c:if>
		
	</div>
</div>
	<hr>
	
