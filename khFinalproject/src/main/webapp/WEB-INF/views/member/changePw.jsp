<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--  <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> --%>
	<div class="container-500 container-center">
		<div class="row center">
			<h2>비밀번호 변경</h2>
		</div>
		<form method="post">
			<div class="row">
				<label>현재 비밀번호</label>
				<input type="password" name="memberPw" required class="form-control fsize" id="floatingInput">
			</div>
			
			<div class="row">
				<label>바꿀 비밀번호</label>
				<input type="password" name="changePw" required class="form-control fsize" id="floatingInput">
			</div>
			
			<div class="row">
				<input type="submit" value="비밀번호 변경" class="btn btn-info">
			</div>
		</form>
		<c:if test="${param.error != null}">
		<div class="row center">
			<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
		</div>
		</c:if>
		
	</div>
<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>
