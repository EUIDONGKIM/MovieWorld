<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<h1> 영화 추가 </h1>

<form method="post">
	<div class="row">
	<label>영화 한국어 제목</label>
	<input type="text" name="movieTitle" required>
	</div>
	
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>