<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>결제 완료!</h1>

<h2>결제 내역</h2>

	<div class="container-500 container-cecnter">
		<div class="row center">
			<label>예매 이름 : ${reservationDto.itemName }</label>
		</div>
		<div class="row center">
			<label>인원 수 : ${reservationDto.reservationTotalNumber }</label>
		</div>
		<div class="row center">
			<label>총 금액 : ${reservationDto.totalAmount }</label>
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
			<label>상영 시간 : ${reservationInfoViewDto.scheduleTimeDateTime }</label>
		</div>
		<div class="row center">
			<label>상영 구분 : ${reservationInfoViewDto.scheduleTimeDiscountType }</label>
		</div>
	</div>


<h2><a href="history_detail?reservationNo=${reservationDto.reservationNo}">결제 상세로 가기</a></h2>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>