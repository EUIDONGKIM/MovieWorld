<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-1200 container-center">
	<div class="row center">
		<h2>내가 작성한 게시글</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardDto" items="${list}">
				<tr>
					<td>${boardDto.boardNo}</td>
					
					<td class="left" style="text-align: left;">
<%-- 						<c:if test="${boardDto.hasDepth()}"> --%>
<%-- 							<c:forEach var="i" begin="1" end="${boardDto.boardDepth}" step="1"> --%>
<!-- 										&nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 							</c:forEach> --%>
<%-- 							<img src="${root}/resources/image/reply.png" width="15" height="15"> --%>
<%-- 						</c:if> --%>
					
						<a href="${root}/board/viewUp?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle}
						</a>
					</td>
					
					<td>${boardDto.memberEmail}</td>
					<td>${boardDto.boardDate}</td>
					<td>${boardDto.boardViews}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="row pagination">
		<!-- 이전 버튼 -->
		<c:choose>
			<c:when test="${boardSearchVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${boardSearchVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getPreviousBlock()}">&lt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="main?p=${boardSearchVO.getPreviousBlock()}">&lt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${boardSearchVO.getStartBlock()}" end="${boardSearchVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${boardSearchVO.isSearch()}">
					<!-- 검색용 링크 -->
					<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<!-- 목록용 링크 -->
					<a href="main?p=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${boardSearchVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${boardSearchVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getNextBlock()}">&gt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="main?p=${boardSearchVO.getNextBlock()}">&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 검색창 -->
	<div class="row center">
		<form method="get">
	
			<select name="column" class="form-input form-inline">
				<c:choose>
					<c:when test="${boardSearchVO.columnIs('board_title')}">
						<option value="board_title" selected>제목</option>
						<option value="board_content">내용</option>
					</c:when>
					
					<c:when test="${boardSearchVO.columnIs('board_content')}">
						<option value="board_title">제목</option>
						<option value="board_content" selected>내용</option>
					</c:when>
					
					<c:otherwise>
						<option value="board_title">제목</option>
						<option value="board_content">내용</option>
					</c:otherwise>
				</c:choose>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required 
					value="${boardSearchVO.keyword}" class="form-input form-inline">
			
			<input type="submit" value="검색" class="form-btn form-inline">
			
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>