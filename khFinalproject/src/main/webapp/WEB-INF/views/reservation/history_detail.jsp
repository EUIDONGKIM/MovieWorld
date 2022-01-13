<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


	<c:if test="${param.error != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">상영 시간이 지나서 취소 할수 없는 상태입니다.</h4>
			</div>
		</div>
	</c:if>

	<div class="card text-center" style="width: 30rem;">
	  <div class="card-body">
	    <h3 class="card-title">[대표 결제 정보]</h3>
	    <h4 class="card-subtitle mb-2 text-muted">예매번호 : ${reservationDto.reservationNo}</h4>
		<p class="card-text">거래번호 : ${reservationDto.tid}</p>
		<p class="card-text">영화명 : ${lastInfoviewDto.movieTitle}</p>
		<p class="card-text">지점 : ${lastInfoviewDto.theaterName}</p>
		<p class="card-text">주소 : ${lastInfoviewDto.theaterAddress}</p>
		<p class="card-text">상영관 : ${lastInfoviewDto.hallName}(${lastInfoviewDto.hallType })</p>
		<p class="card-text">상영일 : ${fn:substring(lastInfoviewDto.scheduleTimeDateTime,0,16) }</p>
		<p class="card-text">예매금액 : <fmt:formatNumber value="${reservationDto.totalAmount }" pattern="#,###" /> 원</p>
	    <p class="card-text">포인트 사용 금액 : <fmt:formatNumber value="${reservationDto.pointUse }" pattern="#,###" /> 점</p>
		<p class="card-text">총 결제 금액 : <fmt:formatNumber value="${resultAmount}" pattern="#,###" /> 원</p>
		<p class="card-text">거래시각 : ${reservationDto.buyTime}</p>
	  </div>
	  	<div class="card-body">
		<c:choose>
		<c:when test="${reservationDto.reservationStatus == '결제완료'}">	
			<h2><a href="cancel?reservationNo=${reservationDto.reservationNo}" class="btn btn-outline-primary">예매 취소</a></h2>
		</c:when>
		<c:otherwise>
			<h2>취소 할수 없는 상태입니다</h2>
		</c:otherwise>
	</c:choose>
		</div>
	</div>


<hr>
		<h3>[예매 세부 정보]</h3>
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach var="reservationDetailDto" items="${rList}">
		  <div class="col">
		    <div class="card text-center">
		      <div class="card-body">
		        <h5 class="card-title">${reservationDetailDto.seatRows}행 ${reservationDetailDto.seatCols}열</h5>
		        <p class="card-text">상영관 종류 : ${reservationDetailDto.hallType}</p>
		        <p class="card-text">연령 구분 : ${reservationDetailDto.ageName}</p>
		        <p class="card-text">연령 할인  : <fmt:formatNumber value="${reservationDetailDto.ageDiscountPrice}" pattern="#,###" /> 원</p>
		        <p class="card-text">상영 구분 : ${reservationDetailDto.scheduleTimeDiscountType}</p>
		        <p class="card-text">상영 할인 : <fmt:formatNumber value="${reservationDetailDto.scheduleTimeDiscountPrice}" pattern="#,###" /> 원</p>
		        <p class="card-text">총 금액 : <fmt:formatNumber value="${reservationDetailDto.reservationDetailPrice}" pattern="#,###" /> 원</p>
		      </div>
		    </div>
		  </div>
		  	</c:forEach>
		</div>

<hr>

<div class="card border-dark mb-3" style="max-width: 60rem;">
  <div class="card-header">결제 세부 정보</div>
  <div class="card-body text-dark">
    <h5 class="card-title">tid : ${responseVO.tid}</h5>
    <p class="card-text">cid : ${responseVO.cid}</p>
    <p class="card-text">status : ${responseVO.status}</p>
    <p class="card-text">partner_order_id : ${responseVO.partner_order_id}</p>
    <p class="card-text">partner_user_id : ${responseVO.partner_user_id}</p>
    <p class="card-text">payment_method_type : ${responseVO.payment_method_type}</p>
    <p class="card-text">amount : ${responseVO.amount}</p>
    <p class="card-text">canceled_amount : ${responseVO.canceled_amount}</p>
    <p class="card-text">cancel_available_amount : ${responseVO.cancel_available_amount}</p>
    <p class="card-text">item_name : ${responseVO.item_name}</p>
    <p class="card-text">quantity : ${responseVO.quantity}</p>
    <p class="card-text">created_at : ${responseVO.created_at}</p>
    <p class="card-text">approved_at : ${responseVO.approved_at}</p>
    <p class="card-text">canceled_at : ${responseVO.canceled_at}</p>
    <p class="card-text">selected_card_info : ${responseVO.selected_card_info}</p>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>