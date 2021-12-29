<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 상세 정보(이 페이지에서 지도, 상영시간표까지 보여주기)</h1>

<h3>극장명 : ${theaterDto.theaterName}</h3>
<h3>주소 : ${theaterDto.getTheaterFullAddress()}</h3>
<pre>${theaterDto.theaterInfo}</pre>

<hr>
<h2>지도 영역</h2>
<hr>
<h2>상영시간표 영역</h2>
<hr>

<h2>관리메뉴(관리자만 볼 수 있게 / 해당 영화관으로 영화예약내역? 상영중인 영화? 있으면 수정/삭제 불가능하게? </h2>
<div>
	<a href="edit?theaterNo=${theaterDto.theaterNo}">수정</a>
	<a href="delete?theaterNo=${theaterDto.theaterNo}">삭제</a>
	<a href="${root}/hall/create2?theaterNo=${theaterDto.theaterNo}">상영관 추가</a>
	<h3>상영관 목록</h3>
	<c:forEach var="hallDto" items="${hallList}">
		<h5>
			${hallDto.getFullName()} | ${hallDto.hallSeat}석 
			<a href="#">상세보기</a>
			<a href="#">수정(나중에)</a>
			<a href="${root}/hall/delete?hallNo=${hallDto.hallNo}">삭제</a>
		</h5>
	</c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>