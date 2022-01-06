<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.board{
	padding:20px;
	}
	</style>

	<div class="container fluid">
		<div class="row">
			<div class="col">
					<h1>✿인물✿</h1>
					<hr>
			</div>
				<div class="row">
  					<div class="col"><img src="${root}/actor/actorImg?actorPhotoNo=${actorDto.actorNo}" width="250px" height="250px"></div>
  					<div class="col col-8">
  						<div class="row">
  							<div class="col-sm">
  								<strong class="inline">${actorDto.actorName }(${actorDto.actorEngName })</strong>
  							<hr>
  							</div>
  							</div>
  						<div class="row">
  						<p>출생일 : ${actorDto.actorBirth }</p>
  						<p>직업 : ${actorDto.actorJob }</p>
  						<p>국적 : ${actorDto.actorNationality }</p>
													</div>
  					</div>

  				</div>
			<br>
			<hr>
			<div class="row center"><p>[필모그래피]</p></div>
	<div class="container">
     	<div class="board d-flex flex-wrap">
      		<c:forEach var="movieChartVO" items="${movieList}">
	      		<div class="board">
	      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
	      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>
      						
      				<div class="row">
      					<c:choose>
      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
      							<a href="${root}/movie/movieDetail">${movieChartVO.movieTitle }</a>
      						</c:when>
      						<c:otherwise>
      							<a href="${root}/movie/movieDetail">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
      						</c:otherwise>
      					</c:choose>
      				</div>
      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>     		
	      		</div>        
      		</c:forEach>
   	    </div>
	</div>
			
			
			
		</div>
	





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>