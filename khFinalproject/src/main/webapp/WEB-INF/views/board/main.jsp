<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="searchList" value="${boardSearchVO.list}"></c:set>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<!-- 충놀나서꺠졋나용 -->ㅁㄴㅇㄴㅁㅇ

<div class="container-1200 container-center">
	<div class="row center">
		<c:if test="${param.boardTypeName==1}">
			<h2>공지사항</h2>
		</c:if>
		
		<c:if test="${param.boardTypeName==2}">
			<h2>자주찾는질문</h2>
		</c:if>
		
		<c:if test="${param.boardTypeName==3}">
			<h2>공지/뉴스</h2>
		</c:if>
		
		<c:if test="${param.boardTypeName==4}">
			<h2>문의사항</h2>
		</c:if>
		
		<c:if test="${param.boardTypeName==5}">
			<h2>단체대관/문의</h2>
		</c:if>
	</div>
	<div class="row center">
		<h6>타인에 대한 무분별한 비판은 제재 대상입니다</h6>
	</div>
<c:if test="${admin}">
	<div class="row" >
		<div class="col right">
			<a href="write?boardTypeName=${param.boardTypeName}" class="btn btn-info">글쓰기</a>
		</div>
	</div>
</c:if>
<c:if test="${!admin }">
	<c:if test="${boardSearchVO.boardTypeName==4 || boardSearchVO.boardTypeName==5}">
		<div class="row" >
			<div class="col right">
				<a href="write?boardTypeName=${param.boardTypeName}" class="btn btn-info">글쓰기</a>
			</div>
		</div>
	</c:if>		
</c:if>
	<div class="row">
		<table class="table table-hover">
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

				<c:forEach var="boardVO" items="${searchList}">
		
				<tr>
					<td>${boardVO.boardNo}</td>
					
					<td class="left" style="text-align: left;">
						<c:if test="${boardVO.hasDepth()}">
							<c:forEach var="i" begin="1" end="${boardVO.boardDepth}" step="1">
										&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
							<img src="${root}/resources/image/reply.png" width="15" height="15">
						</c:if>
					
						<a href="${root}/board/viewUp?boardNo=${boardVO.boardNo}&boardTypeName=${param.boardTypeName}">
							${boardVO.boardTitle}
						</a>
					</td>
					
					<td>${boardVO.memberNick}</td>
					<td>${boardVO.boardDate}</td>
					<td>${boardVO.boardViews}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
<c:if test="${admin}">
	<div class="row" >
		<div class="col right">
			<a href="write?boardTypeName=${param.boardTypeName}" class="btn btn-info">글쓰기</a>
		</div>
	</div>
</c:if>
<c:if test="${boardSearchVO.boardTypeName==4 || boardSearchVO.boardTypeName==5} && ${!admin}">
	<div class="row" >
		<div class="col right">
			<a href="write?boardTypeName=${param.boardTypeName}" class="btn btn-info">글쓰기</a>
		</div>
	</div>
</c:if>	
	
	<!-- 게시판 아래부분  -->
	<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center " style="justify-content: center;">
			<c:choose>
				<c:when test="${boardSearchVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${boardSearchVO.isSearch()}">
							<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getPreviousBlock()}&boardTypeName=${param.boardTypeName}" class="page-link">&laquo;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
	<%-- 						<a href="main?p=${boardSearchVO.getPreviousBlock()}">&lt;</a> --%>
							<li class="page-item">
							<a href="main?&p=${boardSearchVO.getPreviousBlock()}&boardTypeName=${param.boardTypeName}" class="page-link" >&laquo;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&laquo;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${boardSearchVO.getStartBlock()}" end="${boardSearchVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${boardSearchVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
						<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${i}&boardTypeName=${param.boardTypeName}"  class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="main?p=${i}&boardTypeName=${param.boardTypeName}" class="page-link ">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${boardSearchVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${boardSearchVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
							<a href="main?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getNextBlock()}&boardTypeName=${param.boardTypeName}}" class="page-link">&raquo;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="main?p=${boardSearchVO.getNextBlock()}&boardTypeName=${param.boardTypeName}" class="page-link">&raquo;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&raquo;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
	
	<!-- 검색창 -->
	<div class="row">
		<div class="col-3">
		</div>
		<div class="col-6 right">
			<form method="get" class="d-flex">
					<!-- 히든으로 보드타입을 보내준다. -->
					<input type="hidden" name="boardTypeName" value="${param.boardTypeName}">
				
				<select name="column" class="form-input form-inline">
					<c:choose>
						<c:when test="${boardSearchVO.columnIs('board_title')}">
							<option value="board_title" selected>제목</option>
							<option value="board_content">내용</option>
							<option value="member_nick">작성자</option>
						</c:when>
						
						<c:when test="${boardSearchVO.columnIs('board_content')}">
							<option value="board_title">제목</option>
							<option value="board_content" selected>내용</option>
							<option value="member_nick">작성자</option>
						</c:when>
						
						<c:otherwise>
							<option value="board_title">제목</option>
							<option value="board_content">내용</option>
							<option value="member_nick" selected>작성자</option>
						</c:otherwise>
					</c:choose>
				</select>
				
				<input type="search" name="keyword" placeholder="검색어 입력" required 
						value="${boardSearchVO.keyword}" class="form-control me-sm-2">
				
				<input type="submit" value="검색" class="btn btn-info my-2 my-sm-0">
				
			</form>
		</div>
		<div class="col-3">
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>