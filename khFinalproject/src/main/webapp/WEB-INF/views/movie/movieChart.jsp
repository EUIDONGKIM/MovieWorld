<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.item {
   display: flex;
   flex-direction: column;
   flex: 1 1 1 1 25%;
   flex-basis :auto;
	}
	table{
	padding:  0 0 21px 21px
	}
	</style>

	<div class="contianer-1200 container-center">
		<div class="row">
      		<h1>✿MOVIE CHART✿</h1>
      		<hr />
      		<input type="checkbox" name="release" value="released" /> 현재 상영중
		</div>
		
      <div class="row flex-container">
      	<%--for문으로 예매율 순으로 찍어주기.... --%>
      </div>
      
      <div class="row">
      
      	<div class="container-300">
      		<div class="row">NO.1</div>
      		<div class="row">
      			<img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000085/85515/85515199250_727.jpg" width="100%">
      		</div>
      		<div class="row">영화제목</div>
      		<div class="row left">예매율</div>
      		
      		<div class="row">개봉일</div>
      		<div class="row">
      			<a href="${root}/reservation/main">예매</a>
      		</div>
      	</div>
      	
      </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>