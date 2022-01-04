<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h1> 상영 영화 정보 수정 </h1>


<form method="post">
	<div class="row">
		<h2>극장 : ${totalInfoViewDto.theaterName }</h2>
	</div>
	
	
	<div class="row">
		<h2>영화 : ${totalInfoViewDto.movieTitle } (${totalInfoViewDto.movieGrade}, ${totalInfoViewDto.movieRuntime}분)</h2>
	</div>

	
	<div class="row">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart" value="${totalInfoViewDto.scheduleStart}" required min="${movieDto.getOpeningDay()}" max="${movieDto.getEndingDay()}">
	</div>
	
	
	<div class="row">
		<label>상영 종료일</label>
		<input type="date" name="scheduleEnd" value="${totalInfoViewDto.scheduleEnd}" required min="${movieDto.getOpeningDay()}" max="${movieDto.getEndingDay()}">
	</div>
	
	<button type="submit">수정</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>