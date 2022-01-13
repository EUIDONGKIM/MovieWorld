<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
	var d = new Date();
	var day = d.toISOString();
	var input = day.substring(0,10);
	$("input[name=movieOpening]").attr("min",input);
	
});
</script>

<%--
		영화 장르, 국가, 런타임 직접 입력
		영화 등급 선택으로 만들어
 --%>
 <div class="container-600 container-center">
	<div class="row">
		<div class="col center">
			<h1> 영화 추가 </h1>
		</div>
	</div>
	<form method="post" enctype="multipart/form-data">
		<div class="row">
			<div class="col-3">
				 <label>영화제목[KOR]</label>
			</div>
			<div class="col">
				<input type="text" name="movieTitle" required class="form-control form-control-lg">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>영화제목[ENG]</label>
			</div>
			<div class="col">
				<input type="text" name="movieEngTitle" required class="form-control form-control-lg">
			</div>
		</div>

		<div class="row">
			<div class="col-3">
				<label>영화 등급</label>
			</div>
			<div class="col">
				<select name="movieGrade" required class="form-select">
					<option value="">등급 선택</option>
					<option>12세 관람가</option>
					<option>15세 관람가</option>
					<option>청소년 관람불가</option>
					<option>전체 관람가</option>	
				</select>
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>장르</label>
			</div>
			<div class="col">
				<input type="text" name="movieType" required class="form-control form-control-lg">
			</div>
		</div>

		<div class="row">
			<div class="col-3">
				<label>국가</label>
			</div>
			<div class="col">
				<input type="text" name="movieCountry" required class="form-control form-control-lg">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>개봉일</label>
			</div>
			<div class="col">
				<input type="date" name="movieOpening" required class="form-control form-control-lg">
			</div>
		</div>
	
		<div class="row">
			<div class="col-3">
				<label>런타임</label>
			</div>
			<div class="col">
				<input type="number" name="movieRuntime" required min="0" class="form-control form-control-lg">
			</div>
		</div>

		<div class="row">
			<div class="col-3">
				<label>영화 줄거리</label>
			</div>
			<div class="col">
				<textarea  name="movieContent" placeholder="내용을 입력해주세요." required rows="3" cols="56" class="form-control"></textarea>
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
		 	<button type="submit" class="btn btn-info">역할/동영상 추가</button>
		</div>
		
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>