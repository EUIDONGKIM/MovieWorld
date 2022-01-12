<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.form-inline{

 width: auto;
}
</style>

<c:set var="owner" value="${boardVO.memberEmail == memberEmail}"></c:set>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>


<div class="container-1200 container-center">

	<div class="row center">
		<h2>${boardVO.boardNo}번 게시글</h2>		
	</div>
	
	<div class="row">
		<hr>
		<h3>${boardVO.boardTitle}</h3>
		<hr>
	</div>
	
	<div class="row">
	 <div class="col">
		등록일 : ${boardVO.boardDate}
		|
		작성자 : ${boardVO.memberNick}
	</div>
	<div class="col right">
		조회수 : ${boardVO.boardViews}
	</div>
	
	<br>
	
	<div class="row" style="min-height:250px;">
		<pre>${boardVO.boardContent}</pre>
	</div>
	
	<div class="row right">
	 <div class="col">
		<a href="write?boardSuperno=${boardVO.boardNo}&boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">답글쓰기</a>
		<a href="main?boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">목록보기</a>
		
		<c:if test="${owner||admin}">
		<a href="edit?boardNo=${boardVO.boardNo}&boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">수정하기</a>
		<a href="delete?boardNo=${boardVO.boardNo}&boardTypeName=${param.boardTypeName}" class="btn btn-outline-info">삭제하기</a>
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
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>