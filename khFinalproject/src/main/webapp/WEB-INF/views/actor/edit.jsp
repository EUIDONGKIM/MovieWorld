<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	var actorJob = '${actorDto.actorJob}';
	$(".select-job").each(function(){
		if(actorJob==$(this).val()){
			$(this).prop("selected",true);
		}
	});

});
</script>
<div class="container-600 container-center">
	<div class="row">
		<div class="col center">
			<h1> 영화인 수정 </h1>
		</div>
	</div>
	<form method="post" enctype="multipart/form-data">
		<div class="row">
			<div class="col-3">
				<label>프로필 이미지</label>
			</div>
			<div class="col">
				<input type="file" name="attach" accept="image/*" class="form-control">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>영화인 이름(KOR)</label>
			</div>
			<div class="col">
				<input type="text" name="actorName" value="${actorDto.actorName }" class="form-control form-control-lg" required>
			</div>
		</div>

		<div class="row">
			<div class="col-3">
				<label>영화인 이름(ENG)</label>
			</div>
			<div class="col">
				<input type="text" name="actorEngName" value="${actorDto.actorEngName }" class="form-control form-control-lg" required>
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>출생</label>
			</div>
			<div class="col">
				<input type="date" name="actorBirth" value="${actorDto.getStringBirth() }" class="form-control form-control-lg">
			</div>
		</div>

		<div class="row">
			<div class="col-3">
				<label>국적</label>
			</div>
			<div class="col">
				<input type="text" name="actorNationality" value="${actorDto.actorNationality }" class="form-control form-control-lg">
			</div>
		</div>
		
		<div class="row">
			<div class="col-3">
				<label>직업 선택</label>
			</div>
			<div class="col">
				<select name="actorJob" class="form-select">
					<option class="select-job">actor</option>
					<option class="select-job">director</option>
					<option class="select-job">staff</option>
				</select>
			</div>
		</div>
	
		<div class="row">
		 	<button type="submit" class="btn btn-info">수정</button>
		</div>
		
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>