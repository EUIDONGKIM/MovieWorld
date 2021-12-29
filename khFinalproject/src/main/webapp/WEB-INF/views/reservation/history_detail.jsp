<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>대표 결제 정보</h1>

<ul>
	<li>고유번호 : ${reservationDto.reservationNo}</li>
	<li>거래번호 : ${reservationDto.tid}</li>
	<li>거래명 : ${reservationDto.itemName}</li>
	<li>거래금액 : ${reservationDto.totalAmount}</li>
	<li>거래시각 : ${reservationDto.buyTime}</li>
</ul>
	<c:choose>
		<c:when test="${reservationDto.reservationStatus == '결제완료'}">	
			<h2><a href="cancel?resrvationNo=${reservationDto.reservationNo}">예매 취소</a></h2>
		</c:when>
		<c:otherwise>
			<h2>취소 완료</h2>
		</c:otherwise>
	</c:choose>
<hr>

<ul>
<c:forEach var="reservationDetailDto" items="${rList}">
		<li>
		좌석 : ${reservationDetailDto.seatRows}행 ${reservationDetailDto.seatCols}열
		<br>
		상영관 종류 : ${reservationDetailDto.hallType}
		<br>
		연령 구분 : ${reservationDetailDto.ageName}
		<br>
		연령 할인  : ${reservationDetailDto.ageDiscountPrice}
		<br>
		상영 구분 : ${reservationDetailDto.scheduleTimeDiscountType}
		<br>
		상영 할인 : ${reservationDetailDto.scheduleTimeDiscountPrice} 
		<br>
		총 금액 : ${reservationDetailDto.reservationDetailPrice}
		</li>
</c:forEach>
</ul>

<hr>

<ul>
	<li>tid : ${responseVO.tid}</li>
	<li>cid : ${responseVO.cid}</li>
	<li>status : ${responseVO.status}</li>
	<li>partner_order_id : ${responseVO.partner_order_id}</li>
	<li>partner_user_id : ${responseVO.partner_user_id}</li>
	<li>payment_method_type : ${responseVO.payment_method_type}</li>
	<li>amount : ${responseVO.amount}</li>
	<li>canceled_amount : ${responseVO.canceled_amount}</li>
	<li>cancel_available_amount : ${responseVO.cancel_available_amount}</li>
	<li>item_name : ${responseVO.item_name}</li>
	<li>item_code : ${responseVO.item_code}</li>
	<li>quantity : ${responseVO.quantity}</li>
	<li>created_at : ${responseVO.created_at}</li>
	<li>approved_at : ${responseVO.approved_at}</li>
	<li>canceled_at : ${responseVO.canceled_at}</li>
	<li>selected_card_info : ${responseVO.selected_card_info}</li>
	<li>
		payment_action_detail : ${responseVO.payment_action_details}
		<ul>
			<c:forEach var="detail" items="${responseVO.payment_action_details}">
			<li>${detail}</li>
			</c:forEach>
		</ul>
	</li>
</ul>
