<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 상세 정보(이 페이지에서 지도, 상영시간표까지 보여주기)</h1>

<h3>극장명 : ${theaterDto.theaterName}</h3>
<h3>주소 : ${theaterDto.getTheaterFullAddress()}</h3>
<h3>설명 : ${theaterDto.theaterInfo}</h3>

<hr>

<a href="${pageContext.request.contextPath }/hall/create2?theaterNo=${theaterDto.theaterNo}">상영관 추가</a>

<h3>상영관 목록</h3>
<c:forEach var="hallDto" items="${hallList}">
	<h5>${hallDto.getFullName()} | ${hallDto.hallSeat}석 <a href="#">상세보기</a></h5>
</c:forEach>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>