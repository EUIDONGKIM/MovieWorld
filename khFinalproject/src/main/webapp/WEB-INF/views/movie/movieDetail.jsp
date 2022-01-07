<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="memberNo" value="${memberNo eq null ? 0: memberNo}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.round.lightblue{
	border: 2px solid #3e82a4;
	color: #3e82a4;
	width: 110px;
	height: 30px;
	}
	</style>
	<script>
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
						console.log(movieNo);
						console.log(memberNo);
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
				url:"${pageContext.request.contextPath}/movie/data/deleteLike",
				type:"post",
				data:{
					movieNo : movieNo,
					memberNo : memberNo
				},
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
  					<%-- <img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"> --%>
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