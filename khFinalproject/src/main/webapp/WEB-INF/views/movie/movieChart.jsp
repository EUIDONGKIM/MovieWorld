<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	
	</style>

	<div class="contianer-1200 container-center"> <!-- moviechart 큰 box -->
		<div class="row">
      		<h1>✿MOVIE CHART✿</h1>
      		<hr />
      		<input type="checkbox" name="release" value="released" /> 현재 상영중
		</div>
		
      <%--한줄 box 시작 --%>
      <div class="row">
      
      <%--for문으로 한줄에 4개 찍기--%>
      
      
      	<div class="container-300">
      		<div class="row center">NO.1</div>
      		<div class="row">
      			<a href="${root}/movie/movieDetail">
      			<img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000085/85515/85515199250_727.jpg" width="100%"></a>
      		</div>
      		<div class="row">
      			<a href="${root}/movie/movieDetail">해피 뉴 이어</a>
      		</div>
      		<div class="row">예매율 : 7.7%</div>
      		<div class="row">평점 : 8점</div>
      		<div class="row">2021.12.15 개봉</div>
      		<div class="row">
      			<a href="${root}/reservation/">예매하기</a>
      		</div>
      	</div>
      	
      	</div>
      	
      </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>