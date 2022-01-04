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
		
		$(".toggle-one").click(function(e){
			e.preventDefault();
			$(this).next().toggle();
		});
		$(".toggle-two").click(function(e){
			e.preventDefault();
			$(this).next().toggle();
		});
	});
</script>

<h2>영화 리스트(상영작/ 상영예정작) </h2>

<div class="row center">
	<h3>상영 영화 일괄 생성</h3>
	<a href="${root}/schedule/create_total">각각 설정 기능은 극장 상세페이지에서 가능(현재 상영 등록 하지 않은 영화들만 나옴)</a>
</div>
<div class="row center">
	<h3>상영 중인 영화(관리 가능/현재 상영 관리용)</h3>
	<a href="${root}/movie/list">현재 상영만 표시</a>
</div>
<div class="row center">
	<h3>모든 영화 목록(관리 불가능/목록 이력 조회용)</h3>
	<a href="${root}/movie/list?movieTotal">이전 영화 포함 목록만 표시</a>
</div>
<div class="row center">
	<h3>단일 영화 히스토리 검색(관리 가능/상세 이력 조회용)</h3>
	<form action="${root}/movie/list" method="get">
		<input type="text" name="movieTitle" value="${movieTitle }" required>
		<input type="submit" value="영화 검색">
	</form>
</div>
<div class="row center">
	<h3>상영 기간별 상세 검색(관리 가능/기간별 상영 조회용)</h3>
	<form action="${root}/movie/list" method="get">
		<label>언제부터</label>
		<input type="date" name="scheduleStart" value="${scheduleStart }" required>
		<label>언제까지</label>
		<input type="date" name="scheduleEnd" value="${scheduleEnd }" required>
		<input type="submit" value="기간별 검색">
	</form>
</div>
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

				<td><a href="${root}/movie/movieDetail">수정 및 삭제</a></td>

			</tr>	
		</c:forEach>	
	</tbody>	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>