<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	
	</style>

	<div class="contianer-1200 container-center"> <!-- moviechart 큰 box 시작 -->

		<div class="row"><!-- 무비차트 카테고리 찍는 박스 -->

      		<h1>✿MOVIE CHART✿</h1>
      		<hr />
      		<input type="checkbox" name="release" value="released" /> 현재 상영중
		</div>
		
      <%--한줄 box 시작 --%>
      <div class="row">
      
      <%--for문으로 한줄에 4개 찍기--%>
      	<img src="${root}/movie/movieImg?movieNo=122" width="100%">
      
      <c:forEach var="movieChartVO" items="${list}">
      	<div class="container-300">
      		<div class="row center">NO.1</div>
      		<div class="row">
      			<a href="${root}/movie/movieDetail">
      			<img src="${root}/movie/movieImg?movieNo=${movieChartVO.movieNo}" width="100%"></a>
      		</div>
      		<div class="row">
      			<a href="${root}/movie/movieDetail">${movieChartVO.movieTitle }</a>
      		</div>
      		<div class="row">예매율 : ${movieChartVO.movieRatio}%</div>
      		<div class="row">평점 : ${movieChartVO.movieStarpoint}점</div>
      		<div class="row">${movieChartVO.movieOpening} 개봉</div>
      		<div class="row">
      			<a href="${root}/reservation/">예매하기</a>
      		</div>      		
      	</div>
      </c:forEach>
      	
      	</div>
      	
      </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>