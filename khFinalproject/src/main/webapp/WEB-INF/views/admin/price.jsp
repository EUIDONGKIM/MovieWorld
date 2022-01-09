<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>나중에 모달로 입력 수정 해보자...</h1>


<div class="container container-center">
	<div class="row">
		<h1> 가격관리 </h1>
	</div>
	
<%-- 목록에서 수정 및 삭제를 처리 한다. --%>
	<div class="row">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영관 종류별 금액 관리</h5>
				    <p class="card-text">상영관 종류별 금액 관리 </p>
				    <h5><a href="${root}/price/hall_type_price">상영관 종류별 금액 관리</a></h5>
				  </div>
			</div>
		</div>
		
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">연령대별 할인 금액 관리</h5>
				    <p class="card-text">연령대별 할인 금액 관리</p>
				    <h5><a href="${root}/price/age_discount">연령대별 할인 금액 관리</a></h5>
				  </div>
			</div>
		</div>
		
				
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">상영시간 할인 금액 관리</h5>
				    <p class="card-text">상영시간 할인 금액 관리</p>
				    <h5><a href="${root}/price/schedule_time_discount">상영시간 할인 금액 관리</a></h5>
				  </div>
			</div>
		</div>
		
		
	 <br><br>

   </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>