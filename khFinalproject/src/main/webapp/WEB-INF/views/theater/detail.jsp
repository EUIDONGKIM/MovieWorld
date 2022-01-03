<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="root" value="${pageContext.request.contextPath }" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		$(".page").hide();
	    $(".page").eq(0).show();
		
	    $(".btn-page").click(function(){
	    	var count = $(this).data("count");
	    	var p = parseInt(count)-1;
	    	
	         $(".page").hide();
	         $(".page").eq(p).show();
	    	
	         $(".show-date").empty();
	         $(".show-date").text($(this).data("value"));

	         
	    });
	    
		var editResult = "${editResult}";
		if(editResult == "editSuccess"){
			alert("수정이 완료되었습니다.");
		}
	});

</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 상세 정보(이 페이지에서 지도, 상영시간표까지 보여주기)</h1>

<h3>극장명 : ${theaterDto.theaterName}</h3>
<pre>${theaterDto.theaterInfo}</pre>

<hr>
<h2>지도 영역</h2>
<h3>주소 : ${theaterDto.getTheaterFullAddress()}</h3>

<hr>
<!-- 
 List<Map<Integer,Map<Integer,List<LastInfoViewDto>>>>
 -->
<h2>상영시간표 영역</h2>
	<div class="row center">
	
			<div class="row center">
				<c:forEach var="i" items="${dateList}" varStatus="index">
					<button class="btn-page" data-count="${index.count}" data-value="${i}">${i}</button>
				</c:forEach>
			</div>
			<h3>
			<div class="row center show-date">
				${dateList[0]}
			</div>
			</h3>
			
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList1}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList2}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList3}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList4}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList5}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList6}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList7}">
					
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
							<c:if test="${status.index == 0}">						
								<h4>${mapListByhall.value[0].movieTitle} | ${mapListByhall.value[0].movieType} | ${mapListByhall.value[0].movieRuntime}분 | ${fn:substring(mapListByhall.value[0].movieOpening,0,10) } 개봉</h4>
							</c:if>
				
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
								<h4>${lastInfoViewDto.hallType} | ${lastInfoViewDto.hallName} | 총 좌석 : ${lastInfoViewDto.hallSeat} 석</h4>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
									${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
								<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
							<br>
						</c:forEach>
						<br>
						
				</c:forEach>
				
				<hr>
			</c:forEach>
		</div>
		
	</div>


<div>
<h2>관리메뉴(관리자만 볼 수 있게 / 해당 영화관으로 영화예약내역? 상영중인 영화? 있으면 수정/삭제 불가능하게? </h2>
	<a href="edit?theaterNo=${theaterDto.theaterNo}">수정</a>
	<a href="${root}/hall/create2?theaterNo=${theaterDto.theaterNo}">상영관 추가</a>
	
	<div>
	<h3>상영관 목록</h3>
	<c:forEach var="hallDto" items="${hallList}">
		<h5>
			${hallDto.getFullName()} | ${hallDto.hallSeat}석 
			<a href="#">상세보기(나중에)</a>
			<a href="#">수정(나중에)</a>
			<a href="${root}/hall/delete?hallNo=${hallDto.hallNo}">삭제</a>
		</h5>
	</c:forEach>
	</div>
	
	
	<div>
	<h3>현재 상영중인 영화<a href="${root}/schedule/create2?theaterNo=${theaterDto.theaterNo}">상영 영화 생성</a></h3>
	<c:forEach var="totalInfoViewDto" items="${scheduleList }">
		<h5>
			${totalInfoViewDto.movieTitle }
			<a href="${root }/schedule/time/create?scheduleNo=${totalInfoViewDto.scheduleNo}">상영 스케쥴 등록</a>
			<a href="${root }/schedule/edit?scheduleNo=${totalInfoViewDto.scheduleNo}">시작일 / 종료일 수정</a>
			<a href="${root }/schedule/delete?scheduleNo=${totalInfoViewDto.scheduleNo}">삭제</a>
		</h5>
	</c:forEach>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>