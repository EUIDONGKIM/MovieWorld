<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">


<div class="container-500 container-center">
	<div class="row center">
		<h1>비밀번호 찾기</h1>
	</div>
 <form method="post">
	<div class="row">
		<label>이름</label>
		<input type="text" name="memberName" required class="form-input" placeholder="이름">
	</div>
	
	<div class="row">
		<label>이메일</label>
		<input type="email" name="memberEmail" required class="form-input" placeholder="example@goole.com">
	</div>
	
	<div class="row">
		<label>핸드폰번호</label>
		<input type="tel" name="memberPhone" required class="form-input"  placeholder="010-0000-0000">
	</div>
	
	<div class="row">
		<input type="submit" value="비밀번호찾기" class="form-btn">
	</div>
	
	<c:if test="${param.error != null}">
		<div class="row center">
			<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
		</div>
	</c:if>
  </form>
</div>