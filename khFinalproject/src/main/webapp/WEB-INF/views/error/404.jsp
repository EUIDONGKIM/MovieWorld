<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-600 container-center">
	<div class="row center">
		<h2>페이지를 찾을 수 없습니다</h2>
	</div>
	<div class="row">
		<img src="${pageContext.request.contextPath}/resources/image/error/404.jpg" width="100%">		
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>