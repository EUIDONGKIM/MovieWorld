<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h2>영화인 목록</h2>
<form method="get">
		<div class="row center">
			<label>직업 선택</label>
				<select name="actorJob">
					<option class="select-job" value="">선택</option>
					<option class="select-job" value="director">감독</option>
					<option class="select-job" value="actor">배우</option>
					<option class="select-job" value="staff">스태프</option>
				</select>
			<label>이름 검색</label>
				<input type="text" name="actorName" value="${PaginationActorVO.actorName}">
				<input type="submit" value="검색">
		</div>
	</form>
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
					<button onclick="location.href='${root}/movie/actorDetail?actorNo=${actorDto.actorNo}'">상세</button>
					<button onclick="location.href='${root}/movie/edit?actorNo=${actorDto.actorNo}'">수정</button>
					<button onclick="location.href='${root}/movie/delete?actorNo=${actorDto.actorNo}'">삭제</button>
				</td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>
	<div class="row pagination">
		<!-- 이전 버튼 -->
		<c:choose>
			<c:when test="${PaginationActorVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="${root }/actor/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getPreviousBlock()}">&lt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="${root }/actor/list?p=${PaginationActorVO.getPreviousBlock()}">&lt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${PaginationActorVO.getStartBlock()}" end="${PaginationActorVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${PaginationActorVO.isSearch()}">
					<!-- 검색용 링크 -->
					<a href="${root }/actor/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<!-- 목록용 링크 -->
					<a href="${root }/actor/list?p=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${PaginationActorVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="${root }/actor/list?actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getNextBlock()}">&gt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="${root }/actor/list?p=${PaginationActorVO.getNextBlock()}">&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>