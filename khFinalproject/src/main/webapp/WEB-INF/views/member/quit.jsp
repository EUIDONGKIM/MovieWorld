<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

	<div class="container-600 container-center">
		<div class="row">
			<div class="col center">
				<h1>회원 탈퇴 페이지</h1>
			</div>
		</div>
	<form method="post">
		<div class="row">
			<div class="col">
				<label>이메일</label>
				<input type="text" name="membeEmail" required class="form-control fsize" id="floatingInput">
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<label>비밀번호</label>
				<input type="password" name="memberPw" required class="form-control fsize" id="floatingInput">
			</div>
		</div>
		
		<c:if test="${param.error != null}">
			<div class="row center">
				<div class="col">
					<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
				</div>
			</div>
		</c:if>
		
		<div class="row">
			<div class="col">
			</div>
			<div class="col">
			</div>
			<div class="col right">
				<input type="submit" value="회원탈퇴" class="btn btn-info">
			</div>
		
		</div>
	</form>
	
	
	</div>
