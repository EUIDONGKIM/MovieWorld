<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:set var="answer" value="${boardSuperno != null}"></c:set>

<form method="post"  enctype="multipart/form-data">

	<c:if test="${answer}">
		<input type="hidden" name="boardSuperno" value="${boardSuperNo}">
	</c:if>

<div class="container-1000 container-center">


	<!-- 제목 -->
	<div class="row">
		<c:choose>
			<c:when test="${answer}">
				<h2>답글 작성</h2>
			</c:when>
			<c:otherwise>
				<h2>새글 작성</h2>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<div class="row">
		<label>제목</label>
		<input type="text" name="boardTitle" required class="form-input">
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="boardContent" required rows="10" class="form-input"></textarea>
	</div>
	
	<div class="row">
		<label class="form-block">첨부파일</label>
		<input type="file" name="attach" accept="image/*" multiple="multiple" class="form-input form-inline">
	</div>
	
	<div class="row right">
		<a href="main?boardTypeName=${param.boardTypeName}" class="form-link-btn">목록</a> 
		<input type="submit" value="등록" class="form-btn form-inline">
	</div>
	
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>