<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
 	var hallType = '${hallDto.hallType}';
	
	$(".hall-type-list").each(function(){
		if($(this).val() == hallType){
			$(this).prop("selected",true);
		}
	}); 
});
</script>

<div class="container-600 container-center">

<div class="row my-3">
	<h1> 상영관 수정 </h1>
</div>

<form method="post">

	<input type="hidden" name="hallNo" value="${hallDto.hallNo}">
	
	<div class="row">
		<label class="form-label">상영관 이름</label>
		<input type="text" name="hallName" class="form-control" value="${hallDto.hallName}">
	</div>
	
	<div class="row">
		<label class="form-label">상영관 종류</label>
		<select class="form-select" name="hallType">
			<option value="">종류 선택</option>
			<c:forEach var="hallTypePriceDto" items="${hallTypeList}">
				<option class="hall-type-list">${hallTypePriceDto.hallType}</option>
			</c:forEach>
		</select>
	</div>
	
	<button type="submit" class="btn btn-primary">수정</button>
	<a class="btn btn-outline-primary" href="${root}/hall/admin/delete?hallNo=${hallDto.hallNo}">삭제</a>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>