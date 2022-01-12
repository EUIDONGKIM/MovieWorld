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
			
		});
	</script>

	<div class="contianer">
		<div class="row">
			<div class="col">
				<h1>✿무비 검색✿</h1>
				<hr>
			</div>
		</div>
	</div>
	

      <%--for문으로 시작--%>
     
      	<div class="container">
	      	<div class="board d-flex flex-wrap">
      <c:forEach var="movieChartVO" items="${searchVO.list}" varStatus="status">
	      		<div class="board">
	      			<div class="row center">
					    <strong>${movieChartVO.checkStatus }</strong>
	      			</div>
	      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
	      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>	
      				<div class="row">
      					<c:choose>
      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${movieChartVO.movieTitle }</a>
      						</c:when>
      						<c:otherwise>
      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
      						</c:otherwise>
      					</c:choose>
      				</div>
      				<div class="row">예매율 : ${movieChartVO.movieRatio}%</div>
      				<div class="row">평점 : ${movieChartVO.movieStarpoint}점</div>
      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>
      				<div class="row">
      					<a href="${root}/reservation/direct?movieNo=${movieChartVO.movieNo}">예매하기</a>
      				</div>      		
	      		</div>        
      </c:forEach>
      	    </div>
		</div>
		<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center " style="justify-content: center;">
			<c:choose>
				<c:when test="${searchVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${searchVO.isSearch()}">
							<li class="page-item">
								<!-- 검색용 링크 -->
								<a href="${root}/movie/movieSearch?keyword=${searchVO.keyword }&p=${searchVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="${root }/movie/movieSearch?p=${searchVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&lt;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${searchVO.getStartBlock()}" end="${searchVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${searchVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
							<a href="${root}/movie/movieSearch?keyword=${searchVO.keyword }&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="${root }/movie/movieSearch?p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${searchVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${searchVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="${root }/movie/movieSearch?keyword=${searchVO.keyword }&p=${searchVO.getNextBlock()}" class="page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root }/movie/movieSearch?p=${searchVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&gt;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

      