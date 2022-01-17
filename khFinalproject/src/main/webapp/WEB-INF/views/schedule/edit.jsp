<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<div class="container-600 container-center">
	<div class="row center">
		<div class="col">
			<h1> 상영 영화 정보 수정 </h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<h4>극장 : ${totalInfoViewDto.theaterName }</h4>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<h4>영화 : ${totalInfoViewDto.movieTitle } (${totalInfoViewDto.movieGrade}, ${totalInfoViewDto.movieRuntime}분)</h4>
		</div>
	</div>

	<form method="post">
	
	<div class="row">
		<div class="col-3">
			<label>상영 시작일</label>
		</div>
		<div class="col">
			<input type="date" name="scheduleStart" value="${totalInfoViewDto.scheduleStart}" required min="${movieDto.getOpeningDay()}" max="${movieDto.getEndingDay()}" class="form-control">
		</div>
	</div>
	
	<div class="row">
		<div class="col-3">
			<label>상영 종료일</label>
		</div>
		<div class="col">
				<input type="date" name="scheduleEnd" value="${totalInfoViewDto.scheduleEnd}" required min="${movieDto.getOpeningDay()}" class="form-control">
		</div>
	</div>
	
	<button type="submit" class="btn btn-info">수정</button>
	
	</form>
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>