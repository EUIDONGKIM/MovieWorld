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
	    
		var editResult = "${editResult}";
		if(editResult == "editSuccess"){
			alert("수정이 완료되었습니다.");
		}
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
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
									<p>${fn:substring(lastInfoViewDto.scheduleTimeDateTime,11,16) } | ${lastInfoViewDto.scheduleTimeDiscountType} | 잔여 좌석 : ${available } 석<a href="${root}/reservation/direct?scheduleTimeNo=${lastInfoViewDto.scheduleTimeNo}">[예매 바로가기]</a></p>
								</div>
						</c:forEach>
				</c:forEach>
			</c:forEach>
		</div>
		
	</div>
</div>
<c:if test="${admin}">

	<div class="container">
	<h2>관리메뉴(관리자만 볼 수 있게) <a href="${root}/admin/theater">목록으로...</a></h2>
		<a href="${root}/theater/admin/edit?theaterNo=${theaterDto.theaterNo}">수정</a>
		<a href="${root}/hall/admin/create2?theaterNo=${theaterDto.theaterNo}">상영관 추가</a>
		
		<div>
		<h3>상영관 목록</h3>
		
		<c:if test="${param.errorSchedule != null}">
			<div class="row center">
				<div class="col">
					<h4 class="error">해당 지점의 상영이 있습니다.</h4>
				</div>
			</div>
		</c:if>
	
		
		<c:forEach var="hallDto" items="${hallList}">
			<h5>
				${hallDto.getFullName()} | ${hallDto.hallSeat}석 
				<a href="${root}/hall/admin/detail?hallNo=${hallDto.hallNo}">상세보기</a>
			</h5>
		</c:forEach>
		</div>
		
		
		<div>
		<h3>현재 상영중인 영화<a href="${root}/schedule/admin/create2?theaterNo=${theaterDto.theaterNo}">상영 영화 생성</a></h3>
		<c:forEach var="totalInfoViewDto" items="${scheduleList }">
			<h5>
				${totalInfoViewDto.movieTitle }
				<a href="${root }/schedule/time/admin/create?scheduleNo=${totalInfoViewDto.scheduleNo}">상영 스케쥴 등록</a>
				<a href="${root }/schedule/admin/edit?scheduleNo=${totalInfoViewDto.scheduleNo}">시작일 / 종료일 수정</a>
				<a href="${root }/schedule/admin/delete_theater?theaterNo=${theaterDto.theaterNo}&scheduleNo=${totalInfoViewDto.scheduleNo}">삭제</a>
			</h5>
		</c:forEach>
		</div>
	</div>
</c:if>	






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>