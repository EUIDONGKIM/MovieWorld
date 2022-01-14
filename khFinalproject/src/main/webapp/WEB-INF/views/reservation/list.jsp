<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>

</script>
<div class="container">
	<div class="row center">
		<h2>[예매 관리 리스트]</h2>
	</div>
	<br><br>
	<!-- 검색창시작 -->
	<div class="row justify-content-md-center">
	 <div class="row center">
	 <div class="col-4">
	 </div>
	  <div class="col-4">
	 
	 <form method="get" class="d-flex">
	
			<select name="column" class="form-select form-inline">
				<c:choose>		
					<c:when test="${paginationVO.columnIs('reservation_no')}">
						<option value="">선택</option>
						<option value="reservation_no" selected>예약번호</option>
						<option value="tid">tid</option>
						<option value="member_name">회원명</option>
					</c:when>
					<c:when test="${paginationVO.columnIs('tid')}">
						<option value="">선택</option>
						<option value="reservation_no">예약번호</option>
						<option value="tid" selected>tid</option>
						<option value="member_name">회원명</option>
					</c:when>
					<c:when test="${paginationVO.columnIs('member_name')}">
						<option value="">선택</option>
						<option value="reservation_no">예약번호</option>
						<option value="tid">tid</option>
						<option value="member_name" selected>회원명</option>
					</c:when>
					<c:otherwise>
						<option value="" selected>선택</option>
						<option value="reservation_no">예약번호</option>
						<option value="tid">tid</option>
						<option value="member_name">회원명</option>
					</c:otherwise>
				</c:choose>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력"
					value="${paginationVO.keyword}" class="form-control form-inline">
			
			<input type="submit" value="검색" class="btn btn-info form-inline">
			
		</form>
		</div>
		 <div class="col-4">
	 	</div>
		</div>
	</div>

	<!-- 검색창 끝 -->
	<br><br><br>
	<div class="container-1400 container-center">
<table class="table">
	<thead>
		<tr>
			<th>예매 번호</th>
			<th>회원 번호</th>		
			<th>회원 이름</th>	
			<th>전화번호</th>	
			<th>tid</th>		
			<th>예약시간</th>
			<th>인원</th>
			<th>금액</th>
			<th>결제 상태</th>
			
			<td>관리 메뉴</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="reservationListVO" items="${paginationVO.list}">
			<tr>
				<td>${reservationListVO.reservationNo}</td>
				<td>
				<a href="${root}/admin/memberlist?column=member_no&keyword=${reservationListVO.memberNo}">
					${reservationListVO.memberNo}
				</a>
				</td>
				<td>${reservationListVO.memberName}</td>
				<td>${reservationListVO.memberPhone}</td>
				<td>${reservationListVO.tid}</td>
				<td>${reservationListVO.buyTime}</td>
				<td>${reservationListVO.reservationTotalNumber} 명</td>
				<td>
					<fmt:formatNumber value="${reservationListVO.totalAmount}" pattern="#,###" /> 원
				</td>
				<td>${reservationListVO.reservationStatus}</td>
				<td>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/reservation/history_detail?reservationNo=${reservationListVO.reservationNo}'">상세</button>
					<button class="btn btn-outline-primary" onclick="location.href='${root}/reservation/cancel?reservationNo=${reservationListVO.reservationNo}'">예매 취소</button>
				</td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>
</div>
</div>


	<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center " style="justify-content: center;">
			<c:choose>
				<c:when test="${paginationVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${paginationVO.isSearch()}">
							<li class="page-item">
								<!-- 검색용 링크 -->
								<a href="${root }/reservation/admin/list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.p}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="${root }/reservation/admin/list?p=${paginationVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&lt;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
							<a href="${root }/reservation/admin/list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="${root }/reservation/admin/list?p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${paginationVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${paginationVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="${root }/reservation/admin/list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&p=${paginationVO.p}" class="page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root }/reservation/admin/list?p=${paginationVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&gt;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>