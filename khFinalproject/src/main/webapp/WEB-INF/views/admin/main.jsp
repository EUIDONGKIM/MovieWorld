<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container container-center">
	<div class="row center">
		<h1> 관리자 메뉴 </h1>
	</div>
	
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">회원관리</h5>
				    <p class="card-text">회원 목록 / 수정 </p>
				    <h5><a href="${root}/admin/memberlist" class="card-link">회원 목록(관리)</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">영화 정보 관리</h5>
				    <p class="card-text">영화 정보 관리 </p>
				    <h5><a href="${root}/movie/list" class="card-link">영화 정보 관리</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">영화인 정보 관리</h5>
				    <p class="card-text">영화인 정보 관리 </p>
				    <h5><a href="${root}/actor/list" class="card-link">영화인 정보 관리</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">영화 리뷰 관리</h5>
				    <p class="card-text">영화 리뷰 관리 </p>
				    <h5><a href="${root}/admin/review" class="card-link">영화 리뷰 관리</a></h5>
				  </div>
			</div>			
		</div>
	</div>
		
	 <br><br>
	
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">극장 정보 </h5>
				    <p class="card-text">극장 정보  </p>
				    <h5><a href="${root}/admin/theater" class="card-link">극장 정보</a></h5>
				  </div>
			</div>	
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영관 정보</h5>
				    <p class="card-text">상영관 정보 </p>
				    <h5><a href="${root}/admin/hall" class="card-link">상영관 정보</a></h5>
				  </div>
			</div>				
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영 영화 관리</h5>
				    <p class="card-text">상영 영화 관리</p>
				    <h5><a href="${root}/admin/schedule" class="card-link">상영 영화 관리</a></h5>
				  </div>
			</div>				
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">영화관람료 관리</h5>
				    <p class="card-text">영화관람료 관리</p>
				    <h5><a href="${root}/admin/price" class="card-link">영화관람료 관리</a></h5>
				  </div>
			</div>				
		</div>
	</div>
	 
	<br><br>
	
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">통계 현황</h5>
				    <p class="card-text">통계 현황</p>
				    <h5><a href="${root}/admin/statistics" class="card-link">통계 현황</a></h5>
				  </div>
			</div>	
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상품 등록</h5>
				    <p class="card-text">상품 등록</p>
				    <h5><a href="${root}/store/storeInsert" class="card-link">상품 등록</a></h5>
				  </div>
			</div>	
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상품 목록(관리)</h5>
				    <p class="card-text">상품 목록(관리)</p>
				    <h5><a href="${root}/store/storeList" class="card-link">상품 목록(관리)</a></h5>
				  </div>
			</div>					
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">결제(예매) 관리</h5>
				    <p class="card-text">결제(예매) 관리</p>
				    <h5><a href="#" class="card-link">결제(예매) 관리</a></h5>
				  </div>
			</div>		
		</div>
	
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>