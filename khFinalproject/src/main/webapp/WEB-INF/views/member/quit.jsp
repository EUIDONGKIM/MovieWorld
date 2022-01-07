<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

	<div class="container-500 container-center">
		<div class="row center">
				<h2>회원 탈퇴 페이지</h2>
		</div>
	<form method="post">
		<div class="row">
				<label>이메일</label>
				<input type="text" name="membeEmail" required class="form-control fsize" id="floatingInput">
		</div>
		
		<div class="row">
				<label>비밀번호</label>
				<input type="password" name="memberPw" required class="form-control fsize" id="floatingInput">
		</div>
		
		<c:if test="${param.error != null}">
			<div class="row center">
					<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
			</div>
		</c:if>
		
		<div class="row">
				<input type="submit" value="회원탈퇴" class="btn btn-info">
		</div>
	</form>
	
	
	</div>
