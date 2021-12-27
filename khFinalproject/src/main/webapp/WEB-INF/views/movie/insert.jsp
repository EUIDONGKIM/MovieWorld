<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h1> 영화 추가 </h1>
<%--
		영화 장르, 국가, 런타임 직접 입력
		영화 등급 선택으로 만들어
 --%>

<form method="post" enctype="multipart/form-data">
	<div class= "container-400 container-center">
		<div class="row center">
			<label>영화 한국어 제목</label>
				<input type="text" name="movieTitle" required>
		</div>
	
	<div class="row">
			<label>영화 영어 제목</label>
				<input type="text" name="movieEngTitle" required>
		</div>
	
	<div class="row">
			<label>영화 등급</label>
				<select name="movieGrade" required>
					<option value="">등급 선택</option>
						
				</select>
		</div>
	
	<div class="row">
			<label>장르</label>
				<input type="text" name="movieType" required>
		</div>
		
		<div class="row">
			<label>국가</label>
				<input type="text" name="movieCountry" required>
		</div>
		
		<div class="row">
			<label>개봉일</label>
				<input type="date" name="movieOpening" required>
		</div>
		
		<div class="row">
			<label>런타임</label>
				<input type="text" name="movieRuntime" required>
		</div>
		
		<div class="row">
			<label>메인 포스터 이미지(한장)</label>
				<input type="file" name="photo" accept="image/*" required>
		</div>
		
		<div class="row">
			<label>스틸컷(여러장)</label>
				<input type="file" name="attach" accept="image/*" mutiple>
		</div>
		
		<button type="submit">역할 선택(동영상 추가 포함)</button>
	</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>