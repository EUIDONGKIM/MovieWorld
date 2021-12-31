<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h1>${theaterDto.theaterName }점 상영 영화 생성 </h1>


<form method="post">
	<div class="row">
		<input type="hidden" name="theaterNo" value="${theaterDto.theaterNo }">
	</div>
	
	
	<div class="row">
		<label>영화 선택</label>
		<select name="movieNo" required>
			<option value="">영화 선택</option>
				<c:forEach var="movieDto" items="${movieList}">
					<option value="${movieDto.movieNo}">${movieDto.movieTitle}</option>
				</c:forEach>
		</select>
	</div>

	
	<div class="row">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart" required>
	</div>
	
	
	<div class="row">
		<label>상영 종료일</label>
		<input type="date" name="scheduleEnd" required>
	</div>
	
	<button type="submit">상영 영화 생성</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>