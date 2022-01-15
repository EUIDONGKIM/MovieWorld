<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<style>
	#map {
		width:500px;
		height:400px;
	}
	
	.c { 
		border-bottom:1px solid #DDD; 
		border-top:1px solid #DDD; 
	}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd24b2186cc6c3b286f427d9685ecdcf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		var msg = "${msg}";
		if(msg.length > 0){
			alert(msg);
		}
		
		
		
		
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var address = $("#theater-address").data("address");

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(address, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        
				//인포윈도우 추가(위치 : location)
				var infoWindowText = $("#marker-info-window-template").html();
				infoWindowText = infoWindowText.replace("{{latitude}}", result[0].y);
				infoWindowText = infoWindowText.replace("{{longitude}}", result[0].x);

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: infoWindowText
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		
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
	    
	});
</script>

<template id="marker-info-window-template">
	<div style="padding:5px;">
		무비월드 ${theaterDto.theaterName}<br>
		<a href="https://map.kakao.com/link/to/${theaterDto.theaterAddress},{{latitude}},{{longitude}}" style="color:blue" target="_blank">길찾기</a>
	</div>
</template>

<div class="container">
	<div class="row text-center my-3">
		<h1>${theaterDto.theaterName}</h1>
	</div>
	<div class="row text-center">
		<pre>${theaterDto.theaterInfo}</pre>
	</div>
	
	<hr>
	
	<div class="row">
		<h4>교통안내</h4>
	</div>
	<div class="row ms-2">
		<p class="p-0 m-0"id="theater-address" data-address="${theaterDto.theaterAddress}">도로명주소 : ${theaterDto.getTheaterFullAddress()}</p>
		<div id="map"></div>
	</div>
	
	<hr>
	
	<div class="row">
		<h4>상영시간표</h4>
	</div>
	
	<div class="row">
		<c:forEach var="i" items="${dateList}" varStatus="index">
			<div class="col p-0">
				<button class="btn-page btn btn btn-outline-primary w-100" data-count="${index.count}" data-value="${i}">${i}</button>
			</div>
		</c:forEach>
	</div>
	
	<div class="row my-3">
		<h5 class="show-date">${dateList[0]}</h5>
	</div>
	
	<div class="row">
			
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList1}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList2}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList3}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList4}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList5}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList6}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
		<div class="page">
			<c:forEach var="mapListByMovie" items="${infoList7}">
				<c:forEach var="mapListByhall" items="${mapListByMovie.value }" varStatus="status">
					<c:if test="${status.index == 0}">	
						<div class="row bg-primary text-white m-0">
							<h5>${mapListByhall.value[0].movieTitle} / ${mapListByhall.value[0].movieGrade} / ${mapListByhall.value[0].movieType} / ${mapListByhall.value[0].movieRuntime}분</h5>
						</div>					
					</c:if>
						<c:forEach var="lastInfoViewDto" items="${mapListByhall.value }" varStatus="status">
							<c:if test="${status.index == 0}">	
							<div class="row border border-primary m-0">
								<p>${lastInfoViewDto.hallName}[${lastInfoViewDto.hallType}] 총 ${lastInfoViewDto.hallSeat}석</p>
							</div>
							</c:if>
								<c:set var = "disabled" value = "${lastInfoViewDto.scheduleTimeCount }" />
								<c:set var = "available" value = "${lastInfoViewDto.hallSeat - disabled }" />
								<div class="row mx-0 my-1 c">
									<p>
										${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석
										<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a>
										<c:if test="${admin}">
											<a class="schedule-delete-btn btn btn-info" href="${root}/schedule/admin/delete_time?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">x</a>
										</c:if>
									</p>								
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
	</div>
</div>
<c:if test="${admin}">

<hr>

	<div class="container">
	
		<div class="row my-5">
			<h1>영화관 관리<a class="btn btn-info mx-2" href="${root}/admin/theater">목록</a><a class="btn btn-info mx-2" href="${root}/theater/admin/edit?theaterNo=${theaterDto.theaterNo}">수정</a></h1>
		</div>
		
		<hr>
		
		<div class="row">
			<h4>상영관 현황</h4>
		</div>
		
		<div class="row"> 
			<div class="d-flex flex-row-reverse bd-highlight">
				<a class="btn btn-info my-2 my-sm-0" href="${root}/hall/admin/create2?theaterNo=${theaterDto.theaterNo}">상영관 생성</a>
			</div>
		</div>
		<table class="table table-hover">
		 	<thead>
			 	<tr>
			 		<th>상영관 이름</th>
			 		<th>상영관 종류</th>
			 		<th>좌석 수</th>
			 		<th>메뉴</th>
			 	</tr>
		 	</thead>
		 	<tbody>
		 		<c:forEach var="hallDto" items="${hallList}">
		 		<tr>
		 			<td>${hallDto.hallName}</td>
		 			<td>${hallDto.hallType}</td>
		 			<td>${hallDto.hallSeat}</td>
		 			<td><a href="${root}/hall/admin/detail?hallNo=${hallDto.hallNo}">상세보기</a></td>			 		
 				</tr>
	 		</c:forEach>
	 		</tbody>
		</table>
		<hr>
		<div class="row">
			<h4>현재 상영중인 영화</h4>
		</div>
		
		<c:if test="${param.errorSchedule != null}">
			<div class="row center">
				<div class="col">
					<h5 class="error">해당 지점의 상영 스케쥴이 있습니다.</h5>
				</div>
			</div>
		</c:if>
		
		<div class="row"> 
			<div class="d-flex flex-row-reverse bd-highlight">
				<a class="btn btn-info my-2 my-sm-0" href="${root}/schedule/admin/create2?theaterNo=${theaterDto.theaterNo}">상영 영화 생성</a>
			</div>
		</div>		
		<table class="table table-hover">
		 	<thead>
			 	<tr>
					<th>제목</th>		
					<th>등급</th>
					<th>시작일</th>
					<th>종료일</th>
					<th>관리</th>
			 	</tr>
		 	</thead>
		 	<tbody>
				<c:forEach var="totalInfoViewDto" items="${scheduleList}">
		 		<tr>
		 			<td>${totalInfoViewDto.movieTitle}</td>
		 			<td>${totalInfoViewDto.movieGrade}</td>
		 			<td>${totalInfoViewDto.scheduleStart}</td>
		 			<td>${totalInfoViewDto.scheduleEnd}</td>
		 			<td>
						<a class="btn btn-info" href="${root }/schedule/time/admin/create2?scheduleNo=${totalInfoViewDto.scheduleNo}">스케쥴 등록</a>
						<a class="btn btn-info" href="${root }/schedule/admin/edit2?scheduleNo=${totalInfoViewDto.scheduleNo}">수정</a>
						<a class="btn btn-outline-info" href="${root }/schedule/admin/delete_theater?theaterNo=${theaterDto.theaterNo}&scheduleNo=${totalInfoViewDto.scheduleNo}">삭제</a>
		 			</td>			 		
 				</tr>
	 		</c:forEach>
	 		</tbody>
		</table>
		
	</div>
</c:if>	






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>