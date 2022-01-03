<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h1> 상영 영화 관리 </h1>

<%-- 목록에서 수정 및 삭제를 처리 한다. --%>
<h2><a href="${root}/schedule/list">상영 영화 목록</a></h2> 

<h2><a href="${root}/schedule/create_total">상영 영화 일괄 생성</a></h2>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>