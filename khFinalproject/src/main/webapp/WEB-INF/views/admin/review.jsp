<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h1> 영화 정보 관리 페이지 </h1>

<%-- 영화 리스트에서 영화 수정 및 삭제 처리 하기! --%>
<h3><a href="${root}/review/write">리뷰 작성</a></h3>

<h3><a href="${root}/review/list">리뷰 목록</a></h3>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>