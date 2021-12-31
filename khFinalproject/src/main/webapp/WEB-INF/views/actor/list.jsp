<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h2>영화인 목록</h2>

<table class="table">
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>		
			<th>이름(영문)</th>		
			<th>출생일</th>		
			<th>직업</th>
			<th>국적</th>
			
			<td>수정및삭제</td>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="actorDto" items="${list}">
			<tr>
				<td>${actorDto.actorNo}</td>
				<td>${actorDto.actorName}</td>
				<td>${actorDto.actorEngName}</td>
				<td>${actorDto.actorBirth}</td>
				<td>${actorDto.actorJob}</td>
				<td>${actorDto.actorNationality}</td>
				
				<td><a href="#">수정 및 삭제</a></td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>