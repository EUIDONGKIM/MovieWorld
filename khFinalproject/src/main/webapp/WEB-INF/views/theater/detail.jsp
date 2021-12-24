<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 상세 정보</h1>

<h3>극장명 : ${theaterDto.theaterName}</h3>
<h3>주소 : ${theaterDto.getTheaterFullAddress()}</h3>
<h3>설명 : ${theaterDto.theaterInfo}</h3>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>