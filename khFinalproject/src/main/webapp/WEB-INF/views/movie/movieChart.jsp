<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- Bootstrap CSS CDN-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- boorStrap Skin cdn -->
<link href="https://bootswatch.com/5/journal/bootstrap.css" type="text/css" rel="stylesheet">
<!-- jquey cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--Bootstrap bundle CSS CDN -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


	<style>
	
	</style>


	<div class="contianer"> <!-- moviechart 큰 box 시작 -->
		<div class="row">
			<div class="col">
					<h1>✿MOVIE CHART✿</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
					<input type="checkbox" name="release" value="released" /> 현재 상영중
			</div>
		</div>
	</div>
		
      
      <%--for문으로 한줄에 4개 찍기--%>
      
      <c:forEach var="movieChartVO" items="${list}">
      	<div class="container-300">
	      	<div class="row">
	      		  <div class="col-3 center">
	      		  		<div class="row">
	      		  		   	<h1> no.1</h1>
	      		  		</div>
	      		  		<div class="row"> 
	      		  			 <img src="https://placeholeder.com/300x300">
	      		  		</div>
	      		  </div>
      	    </div>

      		<div class="row">
      			<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
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