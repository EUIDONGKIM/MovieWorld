<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		$(".cancel-btn").click(function(e){
			e.preventDefault();
			self.location = "${root}/theater/detail?theaterNo=${totalInfoViewDto.theaterNo}";
		});
	});
</script>

<div class="container-600 mx-auto">
	<div class="row my-3">
		<h1>${totalInfoViewDto.theaterName}점 상영 영화 정보 수정 </h1>
	</div>
	
	<div class="row">
		<label class="form-label">영화</label>
		<input type="text" value="${totalInfoViewDto.movieTitle } (${totalInfoViewDto.movieGrade}, ${totalInfoViewDto.movieRuntime}분)" readonly>
	</div>

	<form method="post">
	
	<div class="row">
		<label class="form-label">상영 시작일</label>
		<input type="date" name="scheduleStart" value="${totalInfoViewDto.scheduleStart}" required min="${movieDto.getOpeningDay()}" max="${movieDto.getEndingDay()}" class="form-control">
	</div>
	
	<div class="row">
		<label class="form-label">상영 종료일</label>
		<input type="date" name="scheduleEnd" value="${totalInfoViewDto.scheduleEnd}" required min="${movieDto.getOpeningDay()}" max="${movieDto.getEndingDay()}" class="form-control">
	</div>
	
	<button type="submit" class="btn btn-primary">수정</button>
	<button type="button" class="cancel-btn btn btn-outline-primary">취소</button>
	</form>
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>