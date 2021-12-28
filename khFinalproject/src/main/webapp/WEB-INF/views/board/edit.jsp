<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form method="post" > <!-- enctype="multipart/form-data" -->
<input type="hidden" name="boardNo" value="${boardDto.boardNo}">

<div class="container-800 container-center">
	<div class="row center">
		<h2>게시글 수정</h2>	
	</div>
	
	<div class="row">
		<label>제목</label>
		<input type="text" name="boardTitle" required value="${boardDto.boardTitle}" class="form-input">
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="boardContent" required 
					rows="10" class="form-input">${boardDto.boardContent}</textarea>
	</div>
	
	<div class="row">
		<label class="form-block">첨부파일</label>
		<input type="file" name="attach" accept="image/*" multiple="multiple" class="form-input form-inline">
	</div>
	
	<div class="row right">
		<a href="list" class="form-link-btn">목록</a>
		<input type="submit" value="수정" class="form-btn form-inline">
	</div>
</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>