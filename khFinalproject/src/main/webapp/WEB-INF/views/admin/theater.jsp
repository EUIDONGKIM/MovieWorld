<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		var deleteResult = "${deleteResult}";
		if(deleteResult){
			alert("삭제가 완료되었습니다.");
		}
	})
</script>    

<div class="container-1200 container-center">
	<div class="row">
		<div class="col">
			<h1 class="center"> 현재 ${totalCount}개의 영화관이 운영 중입니다.</h1>				
		</div>				
	</div>

	<div class="row">
		<div class="col-3">
		</div>
		<div class="col-6 right">
		<form method="get" class="d-flex">
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
					value="${paginationVO.keyword}" class="form-control me-sm-2">
			
			<input type="submit" value="검색" class="btn btn-info my-2 my-sm-0">
			
		</form>
		</div>
		<div class="col-3">
		</div>	
	</div>
	
	<div class="row"> 
		<div class="d-flex flex-row-reverse bd-highlight">
				<a class="btn btn-info my-2 my-sm-0" href="${root}/theater/admin/create">극장 생성</a>
		</div>
	</div>


 <table class="table table-hover">
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
	 			<td>${theaterDto.getTheaterFullAddress()}</td>
	 			<td>${memberDto.memberPoint}</td>
	 			<td><a href="${root}/theater/detail?theaterNo=${theaterDto.theaterNo}">상세보기</a></td>
	 		</tr>
 		</c:forEach>
 	</tbody>
 </table>
 <!-- 페이지 네이션 -->
 	<div class="row">
 		<div class="col">
 		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
		<ul class="pagination pagination-lg center " style="justify-content: center;">
		<c:choose>
			<c:when test="${paginationVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
						<a class="page-link" href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=1">&lt;&lt;</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.getPreviousBlock()}">&lt;</a>
						</li>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<li class="page-item">
						<a class="page-link" href="theater?p=1">&lt;&lt;</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="theater?p=${paginationVO.getPreviousBlock()}">&lt;</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				
				<li class="page-item"><a class="page-link">&lt;&lt;</a></li>
				<li class="page-item"><a class="page-link">&lt;</a></li>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${paginationVO.isSearch()}">
					<li class="page-item">
					<!-- 검색용 링크 -->
					<a  class="page-link" href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${i}">${i}</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
					<!-- 목록용 링크 -->
					<a class="page-link" href="theater?p=${i}">${i}</a>
					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${paginationVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
						<a class="page-link" href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.getNextBlock()}">&gt;</a>
						<a class="page-link" href="theater?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.lastBlock}">&gt;&gt;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a class="page-link" href="theater?p=${paginationVO.getNextBlock()}">&gt;</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="theater?p=${paginationVO.lastBlock}">&gt;&gt;</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link">&gt;</a></li>
				<li class="page-item"><a class="page-link">&gt;&gt;</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="col">
	</div>

	</div>
</div>








<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>