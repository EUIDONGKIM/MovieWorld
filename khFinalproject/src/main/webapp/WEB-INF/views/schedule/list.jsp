<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h1> 극장별 상영 영화 리스트 </h1>
<h2>리스트 보여주기 (개봉작)</h2>

<table>
	<thead>
		<tr>		
			<th>영화 명</th>
			<th>지역</th>
			<th>극장 명</th>
			<th>상영 시작일</th>
			<th>상영 종료일</th>
			<th>상영 시간 추가</th>
			<th>관리 메뉴</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="totalInfoViewDto" items="${totalInfoViewList}">	
			<tr>
				<td>${totalInfoViewDto.movieTitle }</td>
				<td>${totalInfoViewDto.theaterSido }</td>
				<td>${totalInfoViewDto.theaterName }</td>
				<td>${totalInfoViewDto.scheduleStart }</td>
				<td>${totalInfoViewDto.scheduleEnd }</td>
				<td><a href="${root}/schedule/time/create?scheduleNo=${totalInfoViewDto.scheduleNo}">추가하기</a></td>
				<td>
					<a href="${root}/schedule/edit?scheduleNo=${totalInfoViewDto.scheduleNo}">수정</a>
					<a href="${root}/schedule/delete?scheduleNo=${totalInfoViewDto.scheduleNo}">삭제</a>
				</td>
			</tr>
		</c:forEach>	
	</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>