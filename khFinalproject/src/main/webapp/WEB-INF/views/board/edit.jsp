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
		<input type="text" name="boardTitle" required value="${boardDto.boardTitle}" class="form-control form-control-lg" id="inputLarge">
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="boardContent" required 
					rows="10" class="form-control" id="exampleTextarea">${boardDto.boardContent}</textarea>
	</div>
	
	<div class="row right">
		<div class="col">
			<a href="main?boardTypeName=${param.boardTypeName}" class="btn btn-info">목록</a> 
		</div>
	</div>
	
	<div class="row">
		<label class="form-block">첨부파일</label>
		<input type="file" name="attach" accept="image/*" multiple="multiple" class="form-control">
	</div>
	
	<br>
	<div class="row">
		<input type="submit" value="등록" class="btn btn-info">
	</div>
	
</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>