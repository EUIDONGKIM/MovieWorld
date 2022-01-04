<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
.inside-one{
font-size: 10px;
display: none;
}
.inside-two{
font-size: 6px;
display: none;
}

</style>
<script>
	$(function(){
		
		$(".toggle-one").click(function(){
			$(this).next().toggle();
		});
		$(".toggle-two").click(function(){
			$(this).next().toggle();
		});
	});
</script>

<h2>영화 리스트(상영작/ 상영예정작) </h2>

<table class="table table-border">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>		
			<th>등급</th>
			<th>장르</th>
			<th>개봉일</th>
			<th>수정 및 삭제</th>
		</tr>
	</thead>	 
	<tbody>
		<c:forEach var="list" items="${sendList}">
			<tr>
				<td>${list.key.movieNo}</td>

					<td>
					<a href="#" class="toggle-one">${list.key.movieTitle}</a>

					<c:if test="${not empty list.value}">
						<table class="table table-border inside-one">
							<thead>
								<tr>		
									<th>지역</th>
									<th>극장 명</th>
									<th>상영 시작일</th>
									<th>상영 종료일</th>
									<th>상영 시간 추가</th>
									<th>관리 메뉴</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mapList" items="${list.value}" varStatus="status">	
									<c:forEach var="map" items="${mapList}" varStatus="status">
												<tr>
													<td>${map.key.theaterSido }</td>
													<td>
													<a href="#" class="toggle-two">${map.key.theaterName }</a>
														<c:if test="${not empty map.value}">
															<table class="table table-border inside-two">
																<thead>
																	<tr>		
																		<th>상영관 명</th>
																		<th>상영관 종류</th>
																		<th>총 좌석 수</th>
																		<th>남은 좌석 수</th>
																		<th>상영 종류</th>
																		<th>상영 시간</th>
																		<th>관리 메뉴</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach var="lastInfoViewDto" items="${map.value }" varStatus="status">
																		<tr>
																			<td>${lastInfoViewDto.hallName}</td>
																			<td>${lastInfoViewDto.hallType}</td>
																			<td>${lastInfoViewDto.hallSeat}</td>
																				<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
																				<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
																			<td>${available}</td>
																			<td>${lastInfoViewDto.scheduleTimeDiscountType}</td>
																			<td>${lastInfoViewDto.scheduleTimeDateTime}</td>
																			<td>
																				<a href="${root}/schedule/time/edit?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">수정</a>
																				<a href="${root}/schedule/time/delete?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">삭제</a>
																			</td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</c:if>	
													</td>
													<td>${map.key.scheduleStart }</td>
													<td>${map.key.scheduleEnd }</td>
													<td><a href="${root}/schedule/time/create?scheduleNo=${map.key.scheduleNo}">추가하기</a></td>
													<td>
														<a href="${root}/schedule/edit?scheduleNo=${map.key.scheduleNo}">수정</a>
														<a href="${root}/schedule/delete?scheduleNo=${map.key.scheduleNo}">삭제</a>
													</td>
												</tr>
									</c:forEach>
								</c:forEach>	
							</tbody>
						</table>
						</c:if>
					</td>

				<td>${list.key.movieGrade}</td>
				
				<td>${list.key.movieType}</td>
				
				<td>${list.key.movieOpening}</td>
				
				<td><a href="#">수정 및 삭제</a></td>
			</tr>	
		</c:forEach>	
	</tbody>	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>