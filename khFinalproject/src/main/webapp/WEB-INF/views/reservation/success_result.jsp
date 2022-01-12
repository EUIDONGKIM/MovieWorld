<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<c:set var="reservationStatus" value="${reservationDto.reservationStatus}"></c:set>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	

	<div class="container-500 container-cecnter">
		<c:choose>
			<c:when test="${reservationStatus == '결제완료' }">
				<h1 class="center">[ 결제가 완료 되었습니다. ]</h1>
			</c:when>
			<c:otherwise>
				<h1 class="center">[ 취소된 결제 입니다. ]</h1>
			</c:otherwise>
		</c:choose>
		<br>
		<div class="row center">
			<div class="col">	
				<h2>결제 내역</h2>
			</div>
		</div>
		<br>
		<div class="row center">
			<label>예매 번호 : ${reservationDto.reservationNo }</label>
		</div>
		
		<div class="row center">
			<label>예매 이름 : ${reservationDto.itemName }</label>
		</div>
		
		<div class="row center">
			<label>인원 수 : ${reservationDto.reservationTotalNumber } 명</label>
		</div>
		
		<div class="row center">
			<label>예매 금액 : <fmt:formatNumber value="${reservationDto.totalAmount }" pattern="#,###" /> 원</label>
		</div>
		
		<div class="row center">
			<label>포인트 사용 금액 : <fmt:formatNumber value="${reservationDto.pointUse }" pattern="#,###" /> 점</label>
		</div>
		
		<div class="row center">
			<label>최종 결제 금액 : <fmt:formatNumber value="${resultAmount}" pattern="#,###" /> 원</label>
		</div>
		
		<div class="row center">
			<label>결제 상태 : ${reservationDto.reservationStatus }</label>
		</div>
		
		<hr>
		
		<div class="row center">
			<label>영화 제목 : ${reservationInfoViewDto.movieTitle }(${reservationInfoViewDto.movieEngTitle })</label>
		</div>
		<div class="row center">
			<label>지점명 : ${reservationInfoViewDto.theaterName }</label>
		</div>
		<div class="row center">
			<label>주소 : ${reservationInfoViewDto.theaterAddress } ${reservationInfoViewDto.theaterDetailAddress }</label>
		</div>
		<div class="row center">
			<label>상영관 : ${hallDto.hallName }(${hallDto.hallType})</label>
		</div>
		<div class="row center">
			<label>상영 시간 : ${fn:substring(reservationInfoViewDto.scheduleTimeDateTime,0,16) }</label>
		</div>
		<div class="row center">
			<label>상영 구분 : ${reservationInfoViewDto.scheduleTimeDiscountType }</label>
		</div>
	</div>

<c:if test="${admin}">
	<h2><a href="history_detail?reservationNo=${reservationDto.reservationNo}">결제 상세로 가기</a></h2>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>