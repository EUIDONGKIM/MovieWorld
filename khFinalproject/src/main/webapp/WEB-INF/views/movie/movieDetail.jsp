<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.round.lightblue{
	border: 2px solid #3e82a4;
	color: #3e82a4;
	width: 110px;
	height: 30px;
	}
	</style>
	
	<div class="container fluid">
		<div class="row">
			<div class="col">
					<h1>✿영화상세✿</h1>
					<hr>
			</div>
				<div class="row">
  					<div class="col-md-2" style="float: none; margin:0 auto;">
  					<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px">
  					</div>
  					<div class="col col-9">
  						<div class="row">
  							<div class="col-sm">
  								<strong class="inline">${movieDto.movieTitle}</strong>
  								<em class="round lightblue">
  									<span>현재상영중</span>
  								</em>
  								<button type="button">보고 싶은 영화</button>
  							<p>${movieDto.movieEngTitle}</p>
  							<hr>
  							</div>
  							</div>
  						<div class="row">감독 : 존 왓츠 / 배우 : 톰 홀랜드 ,  젠데이아 콜먼 ,  베네딕트 컴버배치 ,  존 파브로 ,  제이콥 배덜런 ,  마리사 토메이 ,  알프리드 몰리나
													장르 : 액션, 어드벤처, SF / 기본 : 12세 이상, 148분, 미국
													개봉 : 2021.12.15</div>
  					</div>
  				</div>
			</div>
			<br>
				<div class="row">
					<div class="col-md-11" style="float: none; margin:0 auto;">
					${movieDto.movieContent}
					</div>
				</div>
		<br>
		<br>
			<table class="table table-bordered">
 				<thead>
  					 <tr>
      					<th>성별 예매 분포</th>
      					<th>연령별 예매 분포</th>
   					</tr>
 				</thead>
 				<tbody>
   					<tr>
     			 		<td>그래프 자리</td>
      					<td>그래프 자리</td>
  			 		</tr>
				</tbody>
			</table>	
			
			<br>
			<br>
			
			<table class="table table-bordered">
 				<thead>
  					 <tr class="table-active">
      					<th>트레일러</th>
   					</tr>
 				</thead>
 				<tbody>
   					<tr>
     			 		<td>동영상 자리</td>
  			 		</tr>
				</tbody>
			</table>	
			
			<br>
			<br>
			
			<table class="table table-bordered">
 				<thead>
  					 <tr class="table-active">
      					<th>스틸컷</th>
   					</tr>
 				</thead>
 				<tbody>
   					<tr>
     			 		<td>스틸컷이미지</td>
  			 		</tr>
				</tbody>
			</table>	
			
			<br>
			<br>
			
			<table class="table table-bordered">
 				<thead>
  					 <tr class="table-active">
      					<th>1</th>
      					<th>2</th>
   					</tr>
 				</thead>
 				<tbody>
   					<tr>
     			 		<td>관람평</td>
     			 		<td>관람평</td>
  			 		</tr>
  			 		<tr>
     			 		<td>관람평</td>
     			 		<td>관람평</td>
  			 		</tr>
  			 		<tr>
     			 		<td>관람평</td>
     			 		<td>관람평</td>
  			 		</tr>
  			 		<tr>
     			 		<td>관람평</td>
     			 		<td>관람평</td>
  			 		</tr>
				</tbody>
			</table>	
			
	</div>
			
			

	





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>