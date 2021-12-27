<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h1> 영화인 정보 관리 페이지 </h1>

<%-- 영화인 리스트에서 수정 및 삭제 처리 하기! --%>
<h3><a href="${root}/actor/list">영화인 리스트(상영작/상영예정작)</a></h3>

<h3><a href="${root}/actor/insert">영화인 추가</a></h3>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>