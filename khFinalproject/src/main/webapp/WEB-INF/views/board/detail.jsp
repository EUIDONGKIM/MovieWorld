<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.form-inline{

 width: auto;
}
</style>
<%-- 번외 : 수정 버튼을 눌렀을 때 처리되도록 구현하는 스크립트(나중에 배움) --%>
<script src="https://code.jquery.com/jquery-latest.js"></script>

<c:set var="owner" value="${boardDto.memberEmail == memberEmail}"></c:set>

<div class="container-1200 container-center">

	<div class="row center">
		<h2>${boardDto.boardNo}번 게시글</h2>		
	</div>
	
	<div class="row">
		<hr>
		<h3>${boardDto.boardTitle}</h3>
		<hr>
	</div>
	
	<div class="row">
	 <div class="col">
		등록일 : ${boardDto.boardDate}
		|
		작성자 : ${boardDto.memberEmail}
	</div>
	<div class="col right">
		조회수 : ${boardDto.boardViews}
	</div>
	
	<br>
	
	<div class="row" style="min-height:250px;">
		<pre>${boardDto.boardContent}</pre>
	</div>
	
	<div class="row right">
	 <div class="col">
		<a href="write?boardSuperno=${boardDto.boardNo}&boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">답글쓰기</a>
		<a href="main?boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">목록보기</a>
		
		<c:if test="${owner}">
		<a href="edit?boardNo=${boardDto.boardNo}&boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}" class="btn btn-outline-info">삭제하기</a>
		</c:if>
	 
	 </div>
	</div>
	
	<hr>
	
	<%-- 첨부파일이 있다면 첨부파일을 다운받을 수 있는 링크를 제공 --%>
	<c:if test="${not empty boardFileList}">
		<c:forEach var="boardFileDto" items="${boardFileList}">
			<div class="row">
				<h3>
					${boardFileDto.boardFileUploadName}
					(${boardFileDto.boardFileSize} bytes)
					<a href="${pageContext.request.contextPath}/board/file?boardFileNo=${boardFileDto.boardFileNo}">
						다운로드
					</a>
				</h3>
			</div>
		</c:forEach>
	</c:if>

	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>