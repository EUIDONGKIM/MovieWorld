<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>
<div class="container">
	<div class="row center">
		<h2>영화인 목록</h2>
	</div>
	
	<div class="d-flex flex-row-reverse bd-highlight">
		<h3><a  class="btn btn-info" href="${root}/actor/admin/insert">영화인 추가</a></h3>
	</div>
	<!-- 검색창시작 -->
	<div class="row justify-content-md-center">
	 <div class="col-2">
<form method="get">
		<select name="actorJob" class="form-select">
			<option class="select-job" value="">직업선택</option>
			<option class="select-job" value="director">감독</option>
			<option class="select-job" value="actor">배우</option>
			<option class="select-job" value="staff">스태프</option>
		</select>
	 </div>
	 <div class="col-4">
		<input type="text" name="actorName" value="${PaginationActorVO.actorName}" class="form-control" placeholder="이름검색">
	 </div>
	 <div class="col-1">
		<input type="submit" value="검색" class="btn btn-info">
	 </div>
</form>
	<div>
	</div>

	<!-- 검색창 끝 -->
	<br><br><br>
<table class="table">
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>		
			<th>이름(영문)</th>		
			<th>출생일</th>		
			<th>직업</th>
			<th>국적</th>
			
			<td>관리 메뉴</td>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="actorDto" items="${PaginationActorVO.list}">
			<tr>
				<td>${actorDto.actorNo}</td>
				<td>${actorDto.actorName}</td>
				<td>${actorDto.actorEngName}</td>
				<td>${fn:substring(actorDto.actorBirth,0,10) }</td>
				<td>${actorDto.actorJob}</td>
				<td>${actorDto.actorNationality}</td>
				<td>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/actor/detail?actorNo=${actorDto.actorNo}'">상세</button>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/actor/admin/edit?actorNo=${actorDto.actorNo}'">수정</button>
					<button class="btn btn-outline-primary" onclick="location.href='${root}/actor/admin/delete?actorNo=${actorDto.actorNo}'">삭제</button>
				</td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>
	<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center " style="justify-content: center;">
			<c:choose>
				<c:when test="${PaginationActorVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${PaginationActorVO.isSearch()}">
							<li class="page-item">
								<!-- 검색용 링크 -->
								<a href="${root }/actor/admin/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="${root }/actor/admin/list?p=${PaginationActorVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&lt;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${PaginationActorVO.getStartBlock()}" end="${PaginationActorVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
							<a href="${root }/actor/admin/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="${root }/actor/admin/list?p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${PaginationActorVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${PaginationActorVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="${root }/actor/admin/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getNextBlock()}" class="page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root }/actor/admin/list?p=${PaginationActorVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&gt;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>