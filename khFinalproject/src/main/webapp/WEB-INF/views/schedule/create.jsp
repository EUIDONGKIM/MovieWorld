<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	$(".movie-pick").on("input",function(){
		
		var open = $(".pick-select:selected").data("opening");
		console.log(open);
		$(".schedule-start").empty();
		var template = $("#template-start").html();
		template = template.replace("{{min}}",open);
		
		$(".schedule-start").append(template);

	});
	
	var d = new Date();
	var day = d.toISOString();
	var input = day.substring(0,10);
	$("input[name=scheduleEnd]").attr("min",input);
	
});
</script>

<h1> 상영 영화 생성 </h1>
<template id="template-start">
		<label>상영 시작일</label>
		<input type="date" name="scheduleStart" required min="{{min}}">
</template>

<form method="post">
	<div class="row">
		<label>극장 선택</label>
		<select name="theaterNo" required>
			<option value="">극장 선택</option>
				<c:forEach var="theaterDto" items="${TheaterList}">
					<option value="${theaterDto.theaterNo}">${theaterDto.theaterName}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label>영화 선택</label>
		<select class="movie-pick" name="movieNo" required>
			<option value="">영화 선택</option>
				<c:forEach var="movieDto" items="${movieList}">
					<option class="pick-select" value="${movieDto.movieNo}" data-opening="${movieDto.getOpeningDay()}">${movieDto.movieTitle}</option>
				</c:forEach>
		</select>
	</div>

	
	<div class="row schedule-start">
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