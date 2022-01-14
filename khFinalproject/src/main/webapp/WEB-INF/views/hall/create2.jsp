<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
});
</script>

<div class="container-600 mx-auto">
	<div class="row my-3">
		<h1>상영관 생성</h1>
	</div>

	<form action="${pageContext.request.contextPath}/hall/admin/create_seat" method="post">
	
	<div class="row">
		<label class="form-label">지점명</label>
		<input type="hidden" name="theaterNo" class="form-control" value="${theaterDto.theaterNo}" readonly>
		<input type="text" class="form-control" value="${theaterDto.theaterName}" readonly>
	</div>
	
	<div class="row">
		<label class="form-label">상영관 이름</label>
		<input type="text" class="form-control" name="hallName" value="${hallCount + 1}관" required>
	</div>
	
	<div class="row">
		<label class="form-label">상영관 종류</label>
		<select class="form-select" name="hallType" required>
			<option value="">종류 선택</option>
				<c:forEach var="hallTypePriceDto" items="${hallTypeList}">
					<option>${hallTypePriceDto.hallType}</option>
				</c:forEach>
		</select>
	</div>
	
	<div class="row">
		<label class="form-label">행수</label>
		<select class="form-select" name="hallRows" required>
			<option value="">행수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label class="form-label">열수</label>
		<select class="form-select" name="hallCols" required>
			<option value="">열수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	<button class="btn btn-primary" type="submit">좌석 설정</button>
</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>