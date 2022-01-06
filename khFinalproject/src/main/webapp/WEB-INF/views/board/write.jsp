<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:set var="answer" value="${boardSuperno != null}"></c:set>

<form method="post"  enctype="multipart/form-data">

	<c:if test="${answer}">
		<input type="hidden" name="boardSuperno" value="${boardSuperno}">
	</c:if>

<div class="container-1000 container-center">


	<!-- 제목 -->
	<div class="row center">
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
		<input type="text" name="boardTitle" required class="form-control form-control-lg" id="inputLarge">
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="boardContent" required rows="10" class="form-control" id="exampleTextarea"></textarea>
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