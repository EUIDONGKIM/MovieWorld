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

<div class="container-600 container-center">
<div class="row">
		<div class="col center">
			<h1> 영화 수정 </h1>
		</div>
	</div>
	
<form method="post" enctype="multipart/form-data">
	<div class="row">
			<div class="col-3">
				<label>영화제목[KOR]</label>
			</div>
			<div class="col">
				<input type="text" name="movieTitle" value="${movieDto.movieTitle }" required class="form-control form-control-lg">
		</div>
	</div>
	
	<div class="row">
		<div class="col-3">
			<label>영화제목[ENG]</label>
		</div>
			<div class="col">
				<input type="text" name="movieEngTitle" value="${movieDto.movieTitle }" required class="form-control form-control-lg">
		</div>
	</div>
	
	<div class="row">
		<div class="col-3">
			<label>영화 등급</label>
		</div>
		<div class="col">
				<select name="movieGrade" required class="form-select">
					<option class="select-grade" value="">등급 선택</option>
					<option class="select-grade">12세 관람가</option>
					<option class="select-grade">15세 관람가</option>
					<option class="select-grade">청소년 관람불가</option>
					<option class="select-grade">전체 관람가</option>	
				</select>
		</div>
	</div>
	
	<div class="row">
			<div class="col-3">
				<label>장르</label>
			</div>
			<div class="col">
				<input type="text" name="movieType" value="${movieDto.movieType }" required class="form-control form-control-lg">
		</div>
	</div>
	
		<div class="row">
			<div class="col-3">
				<label>국가</label>
			</div>
			<div class="col">
				<input type="text" name="movieCountry" value="${movieDto.movieCountry }" required class="form-control form-control-lg">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>개봉일</label>
			</div>
			<div class="col">
				<input type="date" name="movieOpening" value="${movieDto.getOpeningDay() }" required class="form-control form-control-lg">
			</div>
		</div>
		
	<div class="row">
		<div class="col-3">
			<label>런타임</label>
		</div>
			<div class="col">
				<input type="number" name="movieRuntime" value="${movieDto.movieRuntime }" required min="0" class="form-control form-control-lg">
			</div>
	</div>
		
		<div class="row">
			<div class="col-3">
				<label>영화 줄거리</label>
			</div>
			<div class="col">
				<textarea required rows="3" cols="56" class="form-control" name="movieContent" placeholder="내용을 입력해주세요.">${movieDto.movieContent }</textarea>
			</div>
		</div>	
		
		<div class="row">
			<div class="col-3">
				<label>메인 포스터 이미지(한장)</label>
			</div>
			<div class="col">
				<input type="file" name="photo" accept="image/*" required class="form-control">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>스틸컷(여러장)</label>
			</div>
			<div class="col">
				<input type="file" name="attach" accept="image/*" multiple="multiple" class="form-control">
			</div>
		</div>	
		
		<div class="row">
			<button type="submit">수정 완료</button>
		</div>
		
	</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>