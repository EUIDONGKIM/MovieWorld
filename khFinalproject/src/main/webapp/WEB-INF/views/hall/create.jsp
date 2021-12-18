<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
	$(".city").change(function(){
		var city = $(this).val();
		console.log(city);
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getHalls",
			type:"get",
			data : {
				city:city
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);

				$("select[name=theaterNo]").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#theater-template").html();
					template = template.replace("{{no}}",resp[i].theaterNo);
					console.log("극장 번호",resp[i].theaterNo);
					template = template.replace("{{name}}",resp[i].theaterName);
					
					
					$("select[name=theaterNo]").append(template);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	});
	
});
</script>

<h1> 상영관 생성 </h1>

<template id="theater-template">
<option value="{{no}}">{{name}}</option>
</template>

<form action="create_seat" method="post">
	<div class="row">
		<label>지역 선택</label>
		<select class="city" required>
			<option value="">지역 선택</option>
			<option value="1">서울</option>
			<option value="2">대구</option>
		</select>
	</div>
	
	
	<div class="row">
		<label>지점 선택</label>
		<select name="theaterNo" required>
			<option value="">지점 선택</option>
		</select>
	</div>


	<div class="row">
		<label>상영관 종류</label>
		<select name="hallType" required>
			<option value="">종류 선택</option>
				<c:forEach var="hallTypePriceDto" items="${hallTypeList}">
					<option>${hallTypePriceDto.hallType}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label>상영관 이름</label>
		<input type="text" name="hallName" required>
	</div>
	
	
	<div class="row">
		<label>행수</label>
		<select name="hallRows" required>
			<option value="">행수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label>행수</label>
		<select name="hallCols" required>
			<option value="">열수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	<button type="submit">좌석 꾸미러가기</button>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>