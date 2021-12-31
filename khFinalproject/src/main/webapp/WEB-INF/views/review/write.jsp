<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>

<%-- 모달로 띄워주기 --%>
<h1> 관람평 작성 </h1>
<form>
	<div class="container-400 container-center">
		<div class="row center">
			<label>영화 제목자리~!</label>
		</div>
		
		<div class="row">
			<label>별점자리</label>
		
		</div>
		
		<div class="row">
			<textarea
				style="width:400px; height:400px"
				name="reviewContent"
				placeholder="실관람평을 남겨주세요."
				required
			></textarea>
		
		</div>
		
		<button type="submit">취소</button>
		<button type="submit">등록</button>

	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>