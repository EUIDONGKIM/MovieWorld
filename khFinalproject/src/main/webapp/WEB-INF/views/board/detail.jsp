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
<script>
	$(function(){
		$(".view-row").find(".edit-btn").click(function(){
			$(this).parents("tr.view-row").hide();
			$(this).parents("tr.view-row").next("tr.edit-row").show();
		});
		
		$(".edit-row").find(".edit-cancel-btn").click(function(){
			$(this).parents("tr.edit-row").hide();
			$(this).parents("tr.edit-row").prev("tr.view-row").show();
		});
		
		$(".edit-row").hide();
	});
</script>    

<c:set var="owner" value="${boardDto.memberEmail == memberEmail}"></c:set>



<style>
	.flex-container > .reply-write-wrapper {
		width:80%;
	}
	.flex-container > .reply-send-wrapper {
		flex-grow:1;
	}
	.flex-container > .reply-send-wrapper > .form-btn,
	.flex-container > .reply-send-wrapper > .form-link-btn {
		width:100%;
		height:100%;
		display: flex;
		align-items:center;
		justify-content:center;
	}
</style>

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
		등록일 : ${boardDto.boardDate}
		|
		작성자 : ${boardDto.memberEmail}
		|
		조회수 : ${boardDto.boardViews}
	</div>
	
	<div class="row" style="min-height:250px;">
		<pre>${boardDto.boardContent}</pre>
	</div>
	
	<div class="row right">
		<a href="write" class="link-btn form-inline right">글쓰기</a>
		<a href="write?boardSuperno=${boardDto.boardNo}" class="link-btn form-inline right"  >답글쓰기</a>
		<a href="main" class="link-btn form-inline right">목록보기</a>
		
		<c:if test="${owner}">
		<a href="edit?boardNo=${boardDto.boardNo}" class="link-btn form-inline right">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}" class="link-btn form-inline right">삭제하기</a>
		</c:if>
		
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