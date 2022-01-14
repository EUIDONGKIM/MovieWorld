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
					<div class="col-md-2" style="float: none; margin:0 auto;">
  					<img src="${root}/actor/actorImg?actorPhotoNo=${actorPhotoNo}" width="197px" height="260px">
  					</div>
  					
  					<div class="col col-9">
  						<div class="row">
  							<div class="col-sm">
  								<strong class="inline">${actorDto.actorName }(${actorDto.actorEngName })</strong>
  							<hr>
  							</div>
  							</div>
  						<div class="row">
  						<p>출생일 : ${fn:substring(actorDto.actorBirth,0,10) }</p>
  						<p>직업 : ${actorDto.actorJob }</p>
  						<p>국적 : ${actorDto.actorNationality }</p>
													</div>
  					</div>

  				</div>
			<br>
			<hr>
			<div class="row"><strong>필모그래피</strong></div>
	<div class="container">
     	<div class="board d-flex flex-wrap">
      		<c:forEach var="movieChartVO" items="${movieList}">
	      		<div class="board">
	      			<div class="row"> 
	      		  		<a style="padding:0 0" href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
	      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>
	      			</div>
      						
      				<div class="row">
      					<c:choose>
      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
      							<a style="padding:0 0" href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${movieChartVO.movieTitle }</a>
      						</c:when>
      						<c:otherwise>
      							<a style="padding:0 0" href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
      						</c:otherwise>
      					</c:choose>
      				</div>
      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>     		
	      		</div>        
      		</c:forEach>
   	    </div>
	</div>
			
			
			</div>
		</div>
	





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>