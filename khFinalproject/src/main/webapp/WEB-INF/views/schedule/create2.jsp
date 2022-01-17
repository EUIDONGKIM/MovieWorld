<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
	$(".movie-pick").on("input",function(){
		
		var open = $(".pick-select:selected").data("opening");
		var end = $(".pick-select:selected").data("end");
		
		$(".schedule-start").empty();
		$(".schedule-end").empty();
		
		var template = $("#template-start").html();
		template = template.replace("{{min}}",open);
		template = template.replace("{{max}}",end);
		
		var template2 = $("#template-end").html();
		template2 = template2.replace("{{min}}",open);
		template2 = template2.replace("{{max}}",end);
		
		$(".schedule-start").append(template);
		$(".schedule-end").append(template2);
	});
	
	$(".cancel-btn").click(function(e){
		e.preventDefault();
		self.location = "${root}/theater/detail?theaterNo=${theaterDto.theaterNo}";
	});

	
});
</script>

<template id="template-start">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart" required min="{{min}}" max="{{max}}">
</template>
<template id="template-end">
		<label>상영 종료일</label>
		<input type="date" name="scheduleEnd" required min="{{min}}" max="{{max}}">
</template>


<div class="container-600 mx-auto">
	<div class="row my-3">
		<h1>${theaterDto.theaterName }점 상영 영화 생성 </h1>
	</div>

<form method="post">
	<div class="row">
		<input type="hidden" name="theaterNo" value="${theaterDto.theaterNo }">
	</div>
	
	<div class="row">
		<label class="form-label">영화 선택</label>
		<select class="form-select movie-pick" name="movieNo" required>
			<option value="">영화 선택</option>
				<c:forEach var="movieDto" items="${movieList}">
					<option class="pick-select" value="${movieDto.movieNo}" data-opening="${movieDto.getOpeningDay()}" data-end="${movieDto.getEndingDay()}">${movieDto.movieTitle}</option>
				</c:forEach>
		</select>
	</div>

	
	<div class="row schedule-start">
		<label class="form-label" >상영 시작일</label>
		<input class="form-control" type="date" name="scheduleStart" required>
	</div>
	
	
	<div class="row schedule-end">
		<label class="form-label">상영 종료일</label>
		<input class="form-control" type="date" name="scheduleEnd" required>
	</div>
	
	<button class="btn btn-primary" type="submit">상영 영화 생성</button>
	<button type="button" class="cancel-btn btn btn-outline-primary">취소</button>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>