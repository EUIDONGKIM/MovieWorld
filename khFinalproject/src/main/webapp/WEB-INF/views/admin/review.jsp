<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<div class="container container-center">
	<div class="row">
		<h1> 리뷰 관리 페이지 </h1>
	</div>
	
<%-- 영화 리스트에서 영화 수정 및 삭제 처리 하기! --%>
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">리뷰 작성</h5>
				    <p class="card-text">리뷰 작성 </p>
				    <h5><a href="${root}/review/write">리뷰 작성</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">리뷰 목록</h5>
				    <p class="card-text">리뷰 목록 </p>
				    <h5><a href="${root}/review/list">리뷰 목록</a></h5>
				  </div>
			</div>
		</div>
		
		
	 <br><br>

   </div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

