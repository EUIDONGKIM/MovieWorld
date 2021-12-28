<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h2>영화 리스트(상영작/ 상영예정작) </h2>

<table>
	<thead>
		<tr>
			<th>제목</th>
			<th>Title</th>
			<th>등급</th>
			<th>장르</th>
			<th>국가</th>
			<th>개봉일</th>
			<th>런타임</th>
			<th>메인 포스터</th>
			<th>스틸컷</th>
			<th>역할 선택</th>
			<th>관리 메뉴</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="movieDto" items="${movieDto}">
			<tr>
				<td>${movieDto.movieTitle}</td>
				<td>${movieDto.movieEngTitle}</td>
				<td>${movieDto.movieGrade}</td>
				<td>${movieDto.movieType}</td>
				<td>${movieDto.movieCountry}</td>
				<td>${movieDto.movieOpening}</td>
				<td>${movieDto.movieRuntime}</td>
				<td>${movieDto.photo}</td>
				
		</c:forEach>	
	</tbody>
	
	
	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>