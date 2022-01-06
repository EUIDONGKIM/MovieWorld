<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1> 관리자 메뉴 </h1>


<h2><a href="${root}/admin/memberlist">회원 목록(관리)</a></h2>

<h2><a href="${root}/movie/list">영화 정보 관리(해당 영화의 상영 관리 포함)</a></h2>
<h2><a href="${root}/actor/list">영화인 정보 관리 리스트</a></h2>
<h3><a href="${root}/admin/review">영화 리뷰 관리</a></h3>

<h2><a href="${root}/admin/theater">극장 정보 관리</a></h2>
<h2><a href="${root}/admin/hall">상영관 정보 관리</a></h2>
<h2><a href="${root}/admin/schedule">상영 영화 관리</a></h2>

<h2><a href="${root}/admin/price">영화관람료 관리</a></h2>

<h2><a href="${root}/admin/statistics">통계 현황</a></h2>

<h2>결제(예매) 관리</h2>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>