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

<h1> 영화인 수정 </h1>

<form method="post" enctype="multipart/form-data">
	<div class= "container-400">
	
	<div class="row">
			<label>프로필 이미지(한장)</label>
				<input type="file" name="attach" accept="image/*">
		</div>
	
		<div class="row">
			<label>영화인 이름(한국어)</label>
				<input type="text" name="actorName" value="${actorDto.actorName }" required>
		</div>
		
		<div class="row">
			<label>영화인 이름(영어)</label>
				<input type="text" name="actorEngName" value="${actorDto.actorEngName }" required>
		</div>
		
		<div class="row">
			<label>출생</label>
				<input type="date" name="actorBirth" value="${actorDto.getStringBirth() }">
		</div>
		
		<div class="row">
			<label>국적</label>
				<input type="text" name="actorNationality" value="${actorDto.actorNationality }">
		</div>
		
		<div class="row">
			<label>직업 선택</label>
				<select name="actorJob">
					<option class="select-job">actor</option>
					<option class="select-job">director</option>
					<option class="select-job">staff</option>
				</select>
		</div>
		
		<button type="submit">등록</button>
		
	</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>