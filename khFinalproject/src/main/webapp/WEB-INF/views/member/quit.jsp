<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container-600 container-center">
		<div class="row">
			<div class="col">
				<h1>회원 탈퇴 페이지</h1>
			</div>
		</div>
	<form method="post">
		<div class="row">
			<div class="col">
				<label>이메일</label>
				<input type="text" name="membeEmail" required class="form-input form-inline">
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<label>비밀번호</label>
				<input type="password" name="memberPw" required class="form-input form-inline">
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<input type="submit" value="회원탈퇴" class="form-btn">
			</div>
		</div>
	</form>
	
	
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>