<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
<div class="container-1200 container-center">
	<div class="row">
		<div class="col">
			<h1 class="center">내가예약한영화</h1>
		</div>
	</div>
	<c:forEach var="reservationDto" items="${list}">
		<div class="row">
			<div class="col">
				<table class="table table-border table-hover">
					<thead>
						<tr>
							<th width="10%">예매번호</th>
							<th width="20%">예매좌석</th>
							<th width="5%">인원</th>
							<th>예약시간</th>
							<th>상태</th>
							<th>결제내역<th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${reservationDto.reservationNo}</td>
							<td>${reservationDto.itemName}</td>
							<td>${reservationDto.reservationTotalNumber}</td>
							<td>${reservationDto.buyTime}</td>
							<td>${reservationDto.reservationStatus}</td>
							<td><a href="${root}/reservation/success_result?reservationNo=${reservationDto.reservationNo}">결제내역</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</c:forEach>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>