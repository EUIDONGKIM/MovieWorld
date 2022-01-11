<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
});
</script>

<h1> 상영관 생성 </h1>

<form action="${pageContext.request.contextPath}/hall/admin/create_seat" method="post">

	<div class="row">
		<h3>지점명 : ${theaterDto.theaterName }</h3>
		<input type="hidden" name="theaterNo" value="${theaterDto.theaterNo}">
	</div>


	<div class="row">
		<label>상영관 종류</label>
		<select name="hallType" required>
			<option value="">종류 선택</option>
				<c:forEach var="hallTypePriceDto" items="${hallTypeList}">
					<option>${hallTypePriceDto.hallType}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label>상영관 이름</label>
		<input type="text" name="hallName" value="${hallCount + 1}관"required>
	</div>
	
	
	<div class="row">
		<label>행수</label>
		<select name="hallRows" required>
			<option value="">행수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	
	<div class="row">
		<label>열수</label>
		<select name="hallCols" required>
			<option value="">열수 선택</option>
				<c:forEach var="i" begin="1" end="10" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
	</div>
	
	<button type="submit">좌석 설정</button>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>