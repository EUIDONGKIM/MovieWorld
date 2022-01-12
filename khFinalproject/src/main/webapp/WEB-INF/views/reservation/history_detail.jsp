<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>대표 결제 정보</h1>

<ul>
	<li>예매번호 : ${reservationDto.reservationNo}</li>
	<li>거래번호 : ${reservationDto.tid}</li>
	<li>거래명 : ${reservationDto.itemName}</li>
	<li>예매금액 : <fmt:formatNumber value="${reservationDto.totalAmount }" pattern="#,###" /> 원</li>
	<li>포인트 사용 금액 : <fmt:formatNumber value="${reservationDto.pointUse }" pattern="#,###" /> 점</li>
	<li>총 결제 금액 : <fmt:formatNumber value="${resultAmount}" pattern="#,###" /> 원</li>
	<li>거래시각 : ${reservationDto.buyTime}</li>
</ul>
	<c:choose>
		<c:when test="${reservationDto.reservationStatus == '결제완료'}">	
			<h2><a href="cancel?reservationNo=${reservationDto.reservationNo}">예매 취소</a></h2>
		</c:when>
		<c:otherwise>
			<h2>취소 할수 없는 상태입니다</h2>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${param.error != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">상영 시간이 지나서 취소 할수 없는 상태입니다.</h4>
			</div>
		</div>
	</c:if>
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
		연령 할인  : <fmt:formatNumber value="${reservationDetailDto.ageDiscountPrice}" pattern="#,###" /> 원
		<br>
		상영 구분 : ${reservationDetailDto.scheduleTimeDiscountType}
		<br>
		상영 할인 : <fmt:formatNumber value="${reservationDetailDto.scheduleTimeDiscountPrice}" pattern="#,###" /> 원
		<br>
		총 금액 : <fmt:formatNumber value="${reservationDetailDto.reservationDetailPrice}" pattern="#,###" /> 원
		</li>
</c:forEach>
</ul>

<hr>
<c:if test="${admin}">
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
			payment_action_detail :
			<ul>
				<c:forEach var="detail" items="${responseVO.payment_action_details}">
				<li>${detail}</li>
				</c:forEach>
			</ul>
		</li>
	</ul>
</c:if>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>