<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	});
	
	
</script>

<h1> 상영 영화 일괄 생성 </h1>
<template id="template-start">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart" required min="{{min}}" max="{{max}}">
</template>
<template id="template-end">
		<label>상영 종료일</label>
		<input type="date" name="scheduleEnd" required min="{{min}}" max="{{max}}">
</template>

<h1>${movieDto.movieTitle}</h1>

<form method="post">

	<div class="row">
		<label>영화 선택</label>
		<select class="movie-pick" name="movieNo" required>
			<option value="">영화 선택</option>
				<c:forEach var="movieDto" items="${movieList}">
					<option class="pick-select" value="${movieDto.movieNo}" data-opening="${movieDto.getOpeningDay()}" data-end="${movieDto.getEndingDay()}">${movieDto.movieTitle}</option>
				</c:forEach>
		</select>
	</div>
	
	<div class="row schedule-start">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart=" required min=${movieDto.getOpeningDay() }>
	</div>
	
	
	<div class="row schedule-end">
		<label>상영 종료일</label>
		<input type="date" name="scheduleEnd" required min=${movieDto.getOpeningDay() } max=${movieDto.getEndingDay() }>
	</div>
	
	<button type="submit">상영 영화 일괄 생성</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>