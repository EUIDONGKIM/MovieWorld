<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	var movieGrade = '${movieDto.movieGrade}';
	$(".select-grade").each(function(){
		if(movieGrade==$(this).val()){
			$(this).prop("selected",true);
		}
	});
	
// 	var d = new Date();
// 	var day = d.toISOString();
// 	var input = day.substring(0,10);
// 	$("input[name=movieOpening]").attr("min",input);

});
</script>

<h1> 영화 수정 </h1>

<form method="post" enctype="multipart/form-data">
	<div class= "container-500 container-center">
		<div class="row center">
			<label>영화 한국어 제목</label>
				<input type="text" name="movieTitle" value="${movieDto.movieTitle }" required>
		</div>
	
	<div class="row">
			<label>영화 영어 제목</label>
				<input type="text" name="movieEngTitle" value="${movieDto.movieTitle }" required>
		</div>
	
	<div class="row">
			<label>영화 등급</label>
				<select name="movieGrade" required>
					<option class="select-grade" value="">등급 선택</option>
					<option class="select-grade">12세 관람가</option>
					<option class="select-grade">15세 관람가</option>
					<option class="select-grade">청소년 관람불가</option>
					<option class="select-grade">전체 관람가</option>	
				</select>
		</div>
	
	<div class="row">
			<label>장르</label>
				<input type="text" name="movieType" value="${movieDto.movieType }" required>
		</div>
		
		<div class="row">
			<label>국가</label>
				<input type="text" name="movieCountry" value="${movieDto.movieCountry }" required>
		</div>
		
		<div class="row">
			<label>개봉일</label>
				<input type="date" name="movieOpening" value="${movieDto.getOpeningDay() }" required>
		</div>
		
		<div class="row">
			<label>런타임</label>
				<input type="number" name="movieRuntime" value="${movieDto.movieRuntime }" required min="0">
		</div>
		
		<div class="row">
			<label>영화 줄거리</label>
				<textarea 
				style="width: 200px; height: 200px"
            	name="movieContent"
            	placeholder="내용을 입력해주세요."
            	required>${movieDto.movieContent }</textarea>
		</div>
		
		<div class="row">
			<label>메인 포스터 이미지(한장)</label>
				<input type="file" name="photo" accept="image/*">
		</div>
		
		<div class="row">
			<label>스틸컷(여러장)</label>
				<input type="file" name="attach" accept="image/*" multiple="multiple">
		</div>
		<div class="row center">
			<button type="submit">수정 완료</button>
		</div>
	</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>