<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>



<div class="container container-center">
	<div class="row">
		<h1> 상영관 정보 관리 </h1>
	</div>
	
<%-- 목록에서 수정 및 삭제를 처리 한다. --%>
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영관 목록</h5>
				    <p class="card-text">상영관 목록 </p>
				    <h5><a href="${root}/hall/list">상영관 목록</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영관 생성</h5>
				    <p class="card-text">상영관 생성</p>
				    <h5><a href="${root}/hall/create">상영관 생성</a></h5>
				  </div>
			</div>
		</div>
		
		
	 <br><br>

   </div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>