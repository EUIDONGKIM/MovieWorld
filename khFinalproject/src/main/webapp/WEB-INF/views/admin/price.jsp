<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>나중에 모달로 입력 수정 해보자...</h1>

<h1><a href="${root}/price/hall_type_price">상영관 종류별 금액 관리</a></h1>
<h1><a href="${root}/price/age_discount">연령대별 할인 금액 관리</a></h1>
<h1><a href="${root}/price/schedule_time_discount">상영시간대별 할인 금액 관리</a></h1>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>