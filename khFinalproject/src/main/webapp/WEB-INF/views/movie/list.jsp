<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
.after{
display: none;
}
.inside-two{
display: none;
}

</style>
<script>
	$(function(){
		
		$(".toggle-one").click(function(e){
			e.preventDefault();
			//$(".after").hide();
			var check=$(this).parents("tbody.before").next("tfoot.after").data("movie-no");
			$(".after").each(function(){
			if($(this).data("movie-no") != check){
				
				if($(this).show()){
					$(this).hide();
				}
				
			}	
			});
			$(this).parents("tbody.before").next("tfoot.after").toggle();
			
			//$(".inside-one").toggle();
		});
		$(".toggle-two").click(function(e){
			e.preventDefault();
			$(this).next().toggle();
		});
		
		var movieTotal = '${movieTotal}';
		$("input[name=movieTotal]").each(function(){
			if(movieTotal == "D"){				
			$(this).prop("checked",true);
			}
		});
	});
</script>

<div class="container">
	<div class="row">
			<h1 class="center">
				<c:choose>
					<c:when test="${movieTotal == 'A'}">
						[영화 관리 리스트(모든 영화 목록)]
					</c:when>
					<c:when test="${movieTotal == 'F' }">
						[영화 관리 리스트(상영 영화 목록)]
					</c:when>
					<c:otherwise>
						[영화 관리 리스트(단일 영화 검색)]
					</c:otherwise>
				</c:choose>
			</h1>
	</div>
	
	<div class="d-flex flex-row-reverse bd-highlight">
		<button  class="btn btn-outline-dark" onclick="location.href='${root}/movie/admin/insert'">영화 추가</button>
		<button  class="btn btn-outline-dark" onclick="location.href='${root}/schedule/admin/create_total'">상영 영화 일괄 생성</button>
	</div>
	
		<form action="${root}/movie/admin/list" method="get">
		<div class="row">
		<h5>[상영 관리용 단일 영화 검색](<label><input type="checkbox" name="movieTotal" value="D"><span>현재 상영 관리 검색)</span></label></h5>
		</div>		
	<div class="d-flex flex-row">
			<input type="text" name="movieTitle" value="${movieTitle }" required class="form-control me-sm-2 form-inline" >
			<input type="submit" value="영화 검색" class="btn btn-info my-2 my-sm-0">
	</div>
		</form>
	<c:if test="${param.error != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">해당 영화에 상영하고 있는 영화가 있습니다.</h4>
			</div>
		</div>
	</c:if>
	
	<c:if test="${param.errorSchedule != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">해당 지점의 상영이 있습니다.</h4>
			</div>
		</div>
	</c:if>
	
	<div class="d-flex flex-row-reverse bd-highlight">
		<button class="btn btn-outline-dark" onclick="location.href='${root}/movie/admin/list?movieTotal=F'">현재 상영작</button>
		<button class="btn btn-outline-dark" onclick="location.href='${root}/movie/admin/list'">모든 영화 목록</button>
	</div>
	
</div>
	<br>
<div class="container">
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
			<c:forEach var="list" items="${sendList}">
		<tbody class="before" data-movie-no="${list.key.movieNo}">
				<tr>
					<td>${list.key.movieNo}</td>
					
						<td>
						<c:choose>
								<c:when test="${empty list.value}">
									<a href="${root }/movie/admin/list?movieTitle=${list.key.movieTitle}">${list.key.movieTitle}</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="toggle-one">${list.key.movieTitle}</a>
								</c:otherwise>
						</c:choose>
						</td>
						
					<td>${list.key.movieGrade}</td>
					
					<td>${list.key.movieType}</td>
					
					<td>${fn:substring(list.key.movieOpening,0,10) }</td>
	
					<td>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/movie/movieDetail?movieNo=${list.key.movieNo}'">상세</button>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/movie/admin/edit?movieNo=${list.key.movieNo}'">내용 수정</button>
					<button class="btn btn-outline-dark" onclick="location.href='${root}/movie/admin/insert_actor?movieNo=${list.key.movieNo}'">배역 수정</button>
					<button class="btn btn-outline-primary" onclick="location.href='${root}/movie/admin/delete?movieTitle=${list.key.movieTitle }&movieTotal=${movieTotal}&movieNo=${list.key.movieNo}'">삭제</button>
					</td>
	
				</tr>
		</tbody>	
				<c:if test="${not empty list.value}">
			<tfoot class="after" data-movie-no="${list.key.movieNo}">
					<tr>
						<td colspan="6">
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
																				<td>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,0,16) }</td>
																				<td>
																					<a href="${root}/schedule/time/admin/edit?movieTitle=${movieTitle }&movieTotal=${movieTotal}&scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">수정</a>
																					<br>
																					<a href="${root}/schedule/time/admin/delete?movieTitle=${movieTitle }&movieTotal=${movieTotal}&scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">삭제</a>
																				</td>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
															</c:if>	
														</td>
														<td>${map.key.scheduleStart }</td>
														<td>${map.key.scheduleEnd }</td>
														<td><a href="${root}/schedule/time/admin/create?scheduleNo=${map.key.scheduleNo}">추가</a></td>
														<td>
															<a href="${root}/schedule/admin/edit?movieTitle=${movieTitle }&movieTotal=${movieTotal}&scheduleNo=${map.key.scheduleNo}">수정</a>
															<br>
															<a href="${root}/schedule/admin/delete?movieTitle=${movieTitle }&movieTotal=${movieTotal}&scheduleNo=${map.key.scheduleNo}">삭제</a>
														</td>
													</tr>
										</c:forEach>
									</c:forEach>	
								</tbody>
							</table>
						</td>
					</tr>
			</tfoot>	
				</c:if>
			</c:forEach>	
	</table>

	
	
	<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center " style="justify-content: center;">
			<c:choose>
				<c:when test="${paginationMovieVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${paginationMovieVO.isSearch()}">
							<li class="page-item">
								<!-- 검색용 링크 -->
								<a href="${root }/movie/admin/list?movieTotal=${paginationMovieVO.getMovieTotal()}&movieTitle=${paginationMovieVO.getMovieTitle()}&p=${PaginationActorVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="${root }/movie/admin/list?p=${paginationMovieVO.getPreviousBlock()}&movieTotal=${paginationMovieVO.getMovieTotal()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&lt;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${paginationMovieVO.getStartBlock()}" end="${paginationMovieVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${paginationMovieVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
							<a href="${root }/movie/admin/list?movieTotal=${paginationMovieVO.getMovieTotal()}&movieTitle=${paginationMovieVO.getMovieTitle()}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="${root }/movie/admin/list?p=${i}&movieTotal=${paginationMovieVO.getMovieTotal()}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${paginationMovieVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${paginationMovieVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="${root }/movie/admin/list?movieTotal=${paginationMovieVO.getMovieTotal()}&movieTitle=${paginationMovieVO.getMovieTitle()}&p=${PaginationActorVO.getNextBlock()}" class="page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root }/movie/admin/list?p=${paginationMovieVO.getNextBlock()}&movieTotal=${paginationMovieVO.getMovieTotal()}" class="page-link">&gt;</a>
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
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>