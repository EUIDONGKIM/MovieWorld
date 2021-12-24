<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1> 관리자 메뉴 </h1>

<h2>회원 목록(관리)</h2>

<h2><a href="${root}/admin/movieInfo">영화 정보 관리</a></h2>
<h2><a href="#">영화인 정보 관리</a></h2>

<h2><a href="${root}/admin/theater">극장 정보 관리</a></h2>
<h2><a href="${root}/admin/hall">상영관 정보 관리</a></h2>
<h2><a href="${root}/admin/schedule">상영 영화 관리</a></h2>

<h2>금액 관리(영화 금액 설정/ 할인 금액 설정)</h2>

<h2>통계 현황</h2>

<h2>결제(예매) 관리</h2>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>