<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h1> 현재 ${totalCount}개의 영화관이 운영 중입니다. | <a href="${root}/theater/create">극장 생성</a></h1>

<hr>

<div class="container-1200 contianer-center">
	
	<!-- 검색창 -->
	<div class="row center">
		<form method="get">
	
			<select name="column" class="form-input form-inline">
				<c:choose>
					<c:when test="${paginationVO.columnIs('theater_sido')}">
						<option value="theater_sido" selected>지역</option>
						<option value="theater_name">지점명</option>
					</c:when>
					
					<c:when test="${paginationVO.columnIs('theater_name')}">
						<option value="theater_sido">지역</option>
						<option value="theater_name" selected>지점명</option>
					</c:when>
					
					<c:otherwise>
						<option value="theater_sido">지역</option>
						<option value="theater_name">지점명</option>
					</c:otherwise>
				</c:choose>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required 
					value="${paginationVO.keyword}" class="form-input form-inline">
			
			<input type="submit" value="검색" class="form-btn form-inline">
			
		</form>
	</div>


 <table class="table">
 	<thead>
	 	<tr>
	 		<th>영화관 번호</th>
	 		<th>지역</th>
	 		<th>지점명</th>
	 		<th>주소</th>
	 		<th>메뉴</th>
	 	</tr>
 	</thead>
 	<tbody>
 		<c:forEach var="theaterDto" items="${list}">
	 		<tr>
	 			<td>${theaterDto.theaterNo}</td>
	 			<td>${theaterDto.theaterSido}</td>
	 			<td>${theaterDto.theaterName}</td>
	 			<td>${theaterDto.theaterFullAddress}</td>
	 			<td>${memberDto.memberPoint}</td>
	 			<td><a href="${root}/theater/detail?theaterNo=${theaterDto.theaterNo}">상세보기</a></td>
	 		</tr>
 		</c:forEach>
 	</tbody>
 </table>
 <!-- 페이지 네이션 및 검색 -->
 	<div class="row pagination">
		<!-- 이전 버튼 -->
		<c:choose>
			<c:when test="${paginationVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=1">&lt;&lt;</a>
						<a href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.getPreviousBlock()}">&lt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="theater?p=1">&lt;&lt;</a>
						<a href="theater?p=${paginationVO.getPreviousBlock()}">&lt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&lt;&lt;</a>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${paginationVO.isSearch()}">
					<!-- 검색용 링크 -->
					<a href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<!-- 목록용 링크 -->
					<a href="theater?p=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${paginationVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.getNextBlock()}">&gt;</a>
						<a href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.lastBlock}">&gt;&gt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="theater?p=${paginationVO.getNextBlock()}">&gt;</a>
						<a href="theater?p=${paginationVO.lastBlock}">&gt;&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
				<a>&gt;&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>