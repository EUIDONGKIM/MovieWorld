<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
	
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
<h2>상영시간표 영역</h2>
<c:forEach var="LocalDate" items="${dateList }">
<li>${LocalDate}</li>
</c:forEach>

<hr>

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