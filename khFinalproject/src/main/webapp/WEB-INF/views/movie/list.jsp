<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
.inside-one{
font-size: 9px;
display: none;
}
.inside-two{
font-size: 5px;
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

			<h1 class="center">
				<c:choose>
					<c:when test="${movieTotal != null}">
						[영화 관리 리스트(모든 영화 목록)]
					</c:when>
					<c:when test="${movieTitle != null }">
						[영화 관리 리스트(단일 영화 검색)]
					</c:when>
					<c:when test="${scheduleStart != null }">
						[영화 관리 리스트(상영 기간별 검색)]
					</c:when>
					<c:otherwise>
						[영화 관리 리스트(상영 영화 목록)]
					</c:otherwise>
				</c:choose>
			</h1>



<div class="row right">
	<button onclick="location.href='${root}/movie/insert'">영화 추가</button>
		&nbsp;
	<button onclick="location.href='${root}/schedule/create_total'">상영 영화 일괄 생성</button>
</div>
<div class="row center">
	<form action="${root}/movie/list" method="get">
		<label>[단일 영화 히스토리 검색]</label>
		<input type="text" name="movieTitle" value="${movieTitle }" required>
		<input type="submit" value="영화 검색">
	</form>
</div>
<div class="row center">
	<form action="${root}/movie/list" method="get">
		<label>[상영 기간별 목록 조회]</label>
		<label>시작일 : </label>
		<input type="date" name="scheduleStart" value="${scheduleStart }" required>
		<label>종료일 : </label>
		<input type="date" name="scheduleEnd" value="${scheduleEnd }" required>
		<input type="submit" value="기간별 검색">
	</form>
</div>
<div class="row right">
	<button onclick="location.href='${root}/movie/list'">현재 상영작</button>
		&nbsp;
	<button onclick="location.href='${root}/movie/list?movieTotal'">모든 영화 목록</button>
</div>
<table class="table table-border">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>		
			<th>등급</th>
			<th>장르</th>
			<th>개봉일</th>
			<th>관리</th>
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

				<td>
				<button onclick="location.href='${root}/movie/movieDetail?movieNo=${list.key.movieNo}'">상세</button>
				<button onclick="location.href='${root}/movie/edit?movieNo=${list.key.movieNo}'">내용 수정</button>
				<button onclick="location.href='${root}/movie/insert_actor?movieNo=${list.key.movieNo}'">배역 수정</button>
				<button onclick="location.href='${root}/movie/delete?movieNo=${list.key.movieNo}'">삭제</button>
				</td>

			</tr>	
		</c:forEach>	
	</tbody>	
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>