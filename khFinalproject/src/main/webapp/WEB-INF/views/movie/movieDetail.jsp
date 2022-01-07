<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="memberNo" value="${memberNo eq null ? 0: memberNo}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js"></script>
	<style>
	.round.lightblue{
	border: 2px solid #3e82a4;
	color: #3e82a4;
	width: 110px;
	height: 30px;
	}
	canvas{ 
	width: 300px !important; 
	height: 300px !important; 
	} 
	</style>
	<script>
	$(function(){
		var movieNo = '${movieDto.movieNo}';
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByGenderForMovie",
			type:"get",
			data:{movieNo:movieNo},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw1("#countByGenderForMovie", resp);
			},
			error:function(e){}
		});
	});
	$(function(){
		var movieNo = '${movieDto.movieNo}';
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByAgeForMoive",
			type:"get",
			data:{movieNo:movieNo},
			dataType:"json",
			success:function(resp){
				console.log("성공2222", resp);
				
				draw1("#countByAgeForTotal", resp);
			},
			error:function(e){}
		});
	});		
	function draw1(selector, data){//select = 선택자 , data = JSON(ChartTotalVO)
		//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
		var ctx1 = $(selector)[0].getContext("2d");
	
		var textArray = [];//text만 모아둘 배열
		var countArray = [];//count만 모아둘 배열
		
		for(var i=0; i < data.dataset.length; i++){
			textArray.push(data.dataset[i].text);
			countArray.push(data.dataset[i].count);
		}
	
	
		//var myChart = new Chart(펜객체, 차트옵션);
		var myChart = new Chart(ctx1, {
		    type: 'pie', //차트의 유형
		    data: { //차트 데이터
		    	
		    	//하단 제목
		        labels: textArray,
		        datasets: [{
		            label: data.label,//차트 범례
		            data: countArray,//실 데이터(하단 제목과 개수가 일치하도록 구성)
		            backgroundColor: [//배경색상(하단 제목과 개수가 일치하도록 구성)
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [//테두리색상(하단 제목과 개수가 일치하도록 구성)
		                'rgba(255, 99, 132, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1//테두리 두께
		        }]
		    },
		    options: {
		    	responsive: true,
		  		plugins: {
					legend: {
						position: 'top',
					},
		          	title: {
		            	display: true,
		            	text: data.title
		          	}
				}
	      },
		});
	}
	
	//좋아요 기능
	$(function(){
		
		$(".btn-like").click(function(e){
			var movieNo = ${movieDto.movieNo};
			var memberNo = ${memberNo};
			if(memberNo == 0){//로그인 상태가 아니면
				alert("로그인 후 이용가능한 서비스입니다.");
				e.preventDefault();
			}else{
				
				var heartColor =$(".bi").css("color")
				
				if(heartColor == "rgb(0, 0, 0)"){//하트가 비워져 있으면
					insertLike(movieNo, memberNo);
				}
				else{//하트가 채워져 있으면
					deleteLike(movieNo, memberNo);
				}
			}
			
		});
	});
	
	function insertLike(movieNo, memberNo){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/movie/data/insertLike",
			type:"post",
			data:{
				movieNo : movieNo,
				memberNo : memberNo
			},
			success:function(resp){
				console.log("좋아요 성공", resp);
				$(".bi").css("color", "red");

			},
			error:function(e){}
		});
	}
	
	function deleteLike(movieNo, memberNo){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/movie/data/deleteLike?"+$.param({"movieNo":movieNo,"memberNo":memberNo}),
			type:"delete",
			success:function(resp){
				console.log("좋아요 취소 성공", resp);
				$(".bi").css("color", "black");

			},
			error:function(e){
				console.log("취소 실패",e);
			}
		});
	}
	
	</script>
	<div class="container fluid">
		<div class="row">
			<div class="col">
					<h1>✿영화상세✿</h1>
					<hr>
			</div>
				<div class="row">
  					<div class="col-md-2" style="float: none; margin:0 auto;">
  					<img src="${root}/movie/movieImg?moviePhotoNo=${moviePhotoList[0].moviePhotoNo}" width="197px" height="260px">
  					</div>
  					<div class="col col-9">
  						<div class="row">
  							<div class="col-sm">
  								<strong class="inline">${movieDto.movieTitle}</strong>
  								<em class="round lightblue">
  									<span>현재상영중</span>
  								</em>
 								<button type="button" class="btn-like btn btn-sm btn-outline-secondary">
				           				<!-- 좋아요 아이콘 -->
				           			<c:choose>
				           				<c:when test="${myMovieLike}">
											<svg xmlns="http://www.w3.org/2000/svg" style="color:red" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
											  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
											</svg>
										</c:when>
										<c:otherwise>
					               			<svg xmlns="http://www.w3.org/2000/svg" style="color:black" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
											  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
											</svg>
										</c:otherwise>
									</c:choose>보고 싶어요!
           						</button>
  							<p>${movieDto.movieEngTitle}</p>
  							<hr>
  							</div>
  							</div>
  						<div class="row">

  						감독 : 
  							<c:forEach var="totalRoleViewDto" items="${totalRoleViewList}" varStatus="status">
  								<c:if test="${totalRoleViewDto.actorJob == 'director'}" >
  									<a href="${root}/actor/detail?actorNo=${totalRoleViewDto.actorNo}">${totalRoleViewDto.actorName}</a>
  									<c:if test="${not status.last}">,</c:if>
  								</c:if>
  							</c:forEach>
  						/ 
  						배우 : 
  							<c:forEach var="totalRoleViewDto" items="${totalRoleViewList}" varStatus="status">
  								<c:if test="${totalRoleViewDto.actorJob == 'actor' }" >
  									<a href="${root}/actor/detail?actorNo=${totalRoleViewDto.actorNo}">${totalRoleViewDto.actorName}</a>
  									<c:if test="${not status.last}">,</c:if>
  								</c:if>
  							</c:forEach>
  						
						장르 : ${movieDto.movieType} / 기본 : ${movieDto.movieGrade}, ${movieDto.movieRuntime}분, ${movieDto.movieCountry}
						개봉 : ${movieDto.getOpeningDay()}
						</div>
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
     			 		<td><canvas id="countByGenderForMovie" width="400" height="400"></canvas></td>
      					<td><canvas id="countByAgeForTotal" width="400" height="400"></canvas></td>
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
 					<c:forEach var="videoDto" items="${videoList }">
	   					<tr>
	     			 		<td>
	     			 			<iframe width="560" height="315" src="${videoDto.videoRoot}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	     			 			<br>
	     			 			${videoDto.videoTitle}
	     			 		</td>
	  			 		</tr>
 					</c:forEach>  			 		
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
   						<td>
	   						<div class="board d-flex flex-wrap">
		   						<c:forEach var="moviePhotoDto" items="${moviePhotoList}" varStatus="status">
		   							<c:if test="${status.index != 0}">
		   								<img src="${root}/movie/movieImg?moviePhotoNo=${moviePhotoDto.moviePhotoNo}" width="197px" height="260px">
		   							</c:if>
		   						</c:forEach>
	   						</div>
     			 		</td>
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
     			 		<td>${movieDto.movieContent}</td>
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