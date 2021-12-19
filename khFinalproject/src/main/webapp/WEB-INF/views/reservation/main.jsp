<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.float-container > .float-item-left:nth-child(1) {
		width:25%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(2) {
    width:25%;
    padding:0.5rem;
}
.float-container > .float-item-left:nth-child(3) {
		width:10%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(4) {
    width:30%;
    padding:0.5rem;
}
.flex-container {
    display: flex;
    flex-direction: column;
}

</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
// 날짜는 상영에 기간에 따라서 보여줘야함 (영화/극장에 귀속)
$(function(){
	
	function movieList(){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getMovies",
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
		
	}
	
	
	
	
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

<h1> 예매 화면 </h1>

<template id="theater-template">
<option value="{{no}}">{{name}}</option>
</template>
영화와 극장은 서로 다르게 뿌려준다.
<div class="container-900 container-center">
	<div class="row float-container">
		
		<div class="float-item-left">
			<div class="row"><h2>영화</h2></div>
			<div class="flex-container">
				<c:forEach var="movieDto" items="${movieList}">
					<button class="movie-btn" data-movie_no="">${movieList.movieTitle}</button>
				</c:forEach>
			</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>극장</h2></div>
			
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>날짜</h2></div>
			
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>시간</h2></div>
			
			
		</div>
		
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>