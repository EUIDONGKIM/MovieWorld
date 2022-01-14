<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<c:set var="reservationStatus" value="${reservationDto.reservationStatus}"></c:set>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	

	<div class="container container-center">
		<c:choose>
			<c:when test="${reservationStatus == '결제완료' }">
				<h1 class="center">[ 결제 완료  ]</h1>
			</c:when>
			<c:otherwise>
				<h1 class="center">[ 결제 취소 ]</h1>
			</c:otherwise>
		</c:choose>
		<br>
		<div class="row center">
				<h2>E-ticket</h2>
		</div>

		
			
			<div class="container card text-center" style="width: 30rem;">
			  <img src="${root}/movie/movieImg?moviePhotoNo=${moviePhotoNo}" width="150px" height="200px" class="card-img-top h-100">
			  <div class="card-body">
			    <h5 class="card-title">${reservationInfoViewDto.movieTitle }(${reservationInfoViewDto.movieEngTitle })</h5>
			    <p class="card-text">${reservationInfoViewDto.theaterName }</p>
			    <p class="card-text">${reservationInfoViewDto.theaterAddress } ${reservationInfoViewDto.theaterDetailAddress }</p>
			    <p class="card-text">${hallDto.hallName }(${hallDto.hallType})</p>
			    <p class="card-text">${fn:substring(reservationInfoViewDto.scheduleTimeDateTime,0,16) }</p>
			    <p class="card-text">${reservationInfoViewDto.scheduleTimeDiscountType }</p>
			    <p class="card-text">${reservationInfoViewDto.theaterName }</p>
			  </div>
			  <ul class="list-group list-group-flush">
			    <li class="list-group-item">
			    <p class="card-text">예매 번호 : ${reservationDto.reservationNo }</p>
			    <p class="card-text">예매 이름 : ${reservationDto.itemName }</p>
			    <p class="card-text">인원 수 : ${reservationDto.reservationTotalNumber } 명</p>
			    <p class="card-text">예매 금액 : <fmt:formatNumber value="${reservationDto.totalAmount }" pattern="#,###" /> 원</p>
			    <p class="card-text">포인트 사용 금액 : <fmt:formatNumber value="${reservationDto.pointUse }" pattern="#,###" /> 점</p>
			    <p class="card-text">최종 결제 금액 : <fmt:formatNumber value="${resultAmount}" pattern="#,###" /> 원</p>
			    <p class="card-text">예매 번호 : ${reservationDto.reservationNo }</p>
			    <p class="card-text">결제 상태 : ${reservationDto.reservationStatus }</p>
			    </li>
			  </ul>
			  <div class="card-body">
			    <a href="history_detail?reservationNo=${reservationDto.reservationNo}" class="card-link btn btn-outline-primary">결제 상세 내역 /취소</a>
			  </div>
					</div>


	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>