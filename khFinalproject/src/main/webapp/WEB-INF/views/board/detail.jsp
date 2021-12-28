<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
		<a href="write" class="link-btn">글쓰기</a>
		<a href="write?boardSuperno=${boardDto.boardNo}" class="link-btn">답글쓰기</a>
		<a href="main" class="link-btn">목록보기</a>
		
		<c:if test="${owner}">
		<a href="edit?boardNo=${boardDto.boardNo}" class="link-btn">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}" class="link-btn">삭제하기</a>
		</c:if>
		
	</div>
	
	<hr>
	
	<!-- 댓글 작성 영역 -->
	<form action="./reply/insert" method="post">
	<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
	<input type="hidden" name="replyWriter" value="${memberId}">
	
	<div class="row flex-container">
		<div class="reply-write-wrapper">
			<textarea name="replyContent" required rows="4" class="form-input"></textarea>
		</div>
		<div class="reply-send-wrapper">
			<input type="submit" value="댓글작성" class="form-btn">
		</div>
	</div>
	
	</form>
	
	<!-- 댓글 목록 -->
	<c:choose>
		<c:when test="${replyList == null}">
			<div class="row center">
				<h3>작성된 댓글이 없습니다</h3>
			</div>		
		</c:when>
		<c:otherwise>
			<div class="row center">
				<table class="table table-stripe">
					<tbody>
						<c:forEach var="replyDto" items="${replyList}">
							<c:set var="myReply" value="${memberId == replyDto.replyWriter}"></c:set>
							<c:set var="ownerReply" value="${boardDto.boardWriter == replyDto.replyWriter}"></c:set>
							
						<tr class="view-row">
							<td width="20%">
							${replyDto.replyWriter}
								<%-- 게시글 작성자의 댓글에는 표시 --%>
								<c:if test="${ownerReply }">
									<span class="error">(작성자)</span>								
								</c:if>
								<br>
								(${replyDto.getReplyFullTime()})
							</td>
							<td class="left">
								<pre>${replyDto.getReplyContent()}</pre>
							</td>
							<td width="20%">
							<%-- 현재 사용자가 작성한 글에만 수정, 삭제를 표시 --%>
							<c:if test="${myReply}">							
							<a class="edit-btn link-btn">수정</a>
							<a href="reply/delete?boardNo=${replyDto.getBoardNo()}&replyNo=${replyDto.getReplyNo()}" class="link-btn">삭제</a>
							</c:if>
							</td>
						</tr>
						
						<%-- 본인 글일 경우 수정을 위한 공간을 추가적으로 생성 --%>
						<c:if test="${myReply}">
						<tr class="edit-row">
							<td colspan="3">
								<form action="reply/edit" method="post">
									<input type="hidden" name="replyNo" value="${replyDto.getReplyNo() }">
									<input type="hidden" name="boardNo" value="${replyDto.getBoardNo() }">
								
								<div class="flex-container">
									<div class="reply-write-wrapper">
										<textarea name="replyContent" required rows="4" cols="80" class='form-input'>${replyDto.getReplyContent()}</textarea>
									</div>
									<div class="reply-send-wrapper">
										<input type="submit" value="수정" class="form-btn">
									</div>
									<div class="reply-send-wrapper">
										<a class="edit-cancel-btn form-link-btn">취소</a>
									</div>
								</div>
									
								</form>
							</td>
						</tr>
						</c:if>
						
						</c:forEach>
					</tbody>
				</table>
			</div>	
		
		</c:otherwise>
	</c:choose>
	
	<%-- 첨부파일이 있다면 첨부파일을 다운받을 수 있는 링크를 제공 --%>
	<c:if test="${not empty boardFileList}">
		<c:forEach var="boardFileDto" items="${boardFileList}">
			<div class="row">
				<h3>
					${boardFileDto.boardFileUploadname}
					(${boardFileDto.boardFileSize} bytes)
					<a href="file?boardFileNo=${boardFileDto.boardFileNo}">
						다운로드
					</a>
				</h3>
			</div>
		</c:forEach>
	</c:if>

	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>