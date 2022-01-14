<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" ></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container-1000 container-center">
		<div class="row">
			<img src="${root}/resources/image/SAYGOODBYE.png">
		</div>
		<div class="row center">
			<a href="https://www.google.com" class="link-btn-block">구글로 이동</a>
		</div>
		<div class="row center">
			<a href="https://www.naver.com" class="link-btn-block">네이버로 이동</a>
		</div>
		<div class="row center">
			<a href="https://www.github.com" class="link-btn-block">깃허브로 이동</a>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>