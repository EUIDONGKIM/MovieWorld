<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h2>영화 리스트(상영작/ 상영예정작) </h2>

<table class="table">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>		
			<th>등급</th>
			<th>장르</th>
			<th>개봉일</th>
			<td>수정및삭제</td>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="movieDto" items="${list}">
			<tr>
				<td>${movieDto.movieNo}</td>
				<td>${movieDto.movieTitle}</td>
				<td>${movieDto.movieGrade}</td>
				<td>${movieDto.movieType}</td>
				<td>${movieDto.movieOpening}</td>
				<td><a href="#">수정 및 삭제</a></td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>