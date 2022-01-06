<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<style>
	
	</style>


	<div class="contianer">
		<div class="row">
			<div class="col">
					<h1>✿무비 차트✿</h1>
					<hr>
			</div>
		</div>
	</div>

      <%--for문으로 시작--%>
     
      <c:forEach var="movieChartVO" items="${list}">
      	<div class="container">
	      	<div class="row-vh d-flex flex-row justify-content-around">
	      		<div class="item">
<%-- 	      			${index.current} --%>
	      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
	      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="100%"></a>
      						
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
      	    </div>
		</div>
      </c:forEach>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<!--       		<div class="row"> -->
<%--       			<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}"> --%>
<%--       			<img src="${root}/movie/movieImg?movieNo=${movieChartVO.movieNo}" width="100%"></a> --%>
<!--       		</div> -->
<!--       		<div class="row"> -->
<%--       			<a href="${root}/movie/movieDetail">${movieChartVO.movieTitle }</a> --%>
<!--       		</div> -->
<%--       		<div class="row">예매율 : ${movieChartVO.movieRatio}%</div> --%>
<%--       		<div class="row">평점 : ${movieChartVO.movieStarpoint}점</div> --%>
<%--       		<div class="row">${movieChartVO.movieOpening} 개봉</div> --%>
<!--       		<div class="row"> -->
<%--       			<a href="${root}/reservation/">예매하기</a> --%>
<!--       		</div>      		 -->
<!--       	</div> -->
<%--       </c:forEach> --%>
      