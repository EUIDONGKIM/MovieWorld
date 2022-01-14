<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container-1200 container-center">
		<div class="row center">
		</div>
		<div class="row center border border-success border-5">
				<h1>회원가입을 환영합니다</h1>
			<a href="login"><img src="${root}/resources/image/모코코.gif" width="500px" height="600px"></a>
		</div>
		
		<div class="row center">
				<h1><a href="login" class="btn btn-info">로그인하러가기</a></h1>
		</div>
		
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>