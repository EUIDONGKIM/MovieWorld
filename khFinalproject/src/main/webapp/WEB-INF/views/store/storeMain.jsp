<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>스토어 메인</h1>

<h2><a href="storeInsert">상품 등록</a></h2>
<h2><a href="${root}/store/storeList">상품 목록(관리)</a></h2>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
