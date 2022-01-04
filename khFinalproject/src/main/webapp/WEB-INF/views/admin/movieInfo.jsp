<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h1> 영화 정보 관리 페이지 </h1>

<%-- 영화 리스트에서 영화 수정 및 삭제 처리 하기! --%>
<h3><a href="${root}/movie/insert">영화 추가</a></h3>

<h3><a href="${root}/movie/list">영화 리스트(상영작/상영예정작)</a></h3>

<h2><a href="${root}/schedule/create_total">상영 영화 일괄 생성</a></h2>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>