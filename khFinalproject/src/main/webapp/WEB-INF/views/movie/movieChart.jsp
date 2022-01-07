<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<style>
	.board{
	padding:20px;
	}
	</style>
	<script>
		$(function(){
			var nowMovie = ${nowMovie};
			var income = '${order}';
			
			if(nowMovie==1){
				$(".chk-now-movie").prop("checked",true);
			}
			
			$(".chk-now-movie").click(function(){
				console.log("확인!");
				if($(this).prop("checked")){
					console.log("체크!");
					location.href = "${root}/movie/movieChart?nowMovie=1";
				}else{
					console.log("비체크!");
					location.href = "${root}/movie/movieChart?nowMovie=0";
				}
				
			});
			
			
			$(".order").change(function(){ 
				var order = parseInt($(this).val());
				location.href = '${root}/movie/movieChart?nowMovie=1&order='+parseInt($(this).val());
			});
			
			$(".select-order").each(function(){
				if(income==$(this).val()){
					$(this).prop("selected",true);
				}
			});
			
		});
	</script>

	<div class="contianer">
		<div class="row">
			<div class="col">
				<h1>✿무비 차트✿</h1>
				<hr>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col col-10">
			<label>
				<input class="chk-now-movie" type="checkbox" name="nowMovie">
				<span>현재 상영작</span>
			</label>
		</div>
		<div class="col">
			<select class="btn float-right order">
				<option class="select-order" value="0">예매율순</option>
				<option class="select-order" value="1">평점순</option>
				<option class="select-order" value="2">관람객순</option>
			</select>
		</div>
	</div>
	

      <%--for문으로 시작--%>
     
      	<div class="container">

      	
	      	<div class="board d-flex flex-wrap">
      <c:forEach var="movieChartVO" items="${list}" varStatus="status">
	      		<div class="board">
	      			<div class="row center">
					    <strong>NO.${status.index}</strong>
	      			</div>
	      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
	      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>	
      				<div class="row">
      					<c:choose>
      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${movieChartVO.movieTitle }</a>
      						</c:when>
      						<c:otherwise>
      							<a href="${root}/movie/movieDetail">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
      						</c:otherwise>
      					</c:choose>
      				</div>
      				<div class="row">예매율 : ${movieChartVO.movieRatio}%</div>
      				<div class="row">평점 : ${movieChartVO.movieStarpoint}점</div>
      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>
      				<div class="row">
      					<a href="${root}/reservation/">예매하기</a>
      				</div>      		
	      		</div>        
      </c:forEach>
      	    </div>
		</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

      