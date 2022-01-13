<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	width: 600px !important; 
	height: 400px !important; 
	} 
	.show-off{
	display: none;
	}
	.red-like{
	color: red;
	}
	
	/*별점 */
	.content-box {
	  box-sizing: content-box;
	  /* Total width: 160px + (2 * 20px) + (2 * 8px) = 216px
	     Total height: 80px + (2 * 20px) + (2 * 8px) = 136px
	     Content box width: 160px
	     Content box height: 80px */
	}
	
	.star-rating {
	/*   border:solid 1px #ccc; */
	  display:flex;
	  flex-direction: row-reverse;
	  font-size:2.5em;
	  justify-content:space-around;
	  padding:0 5.7em;
	  text-align:center;
	  width:6em;
	}
	.star-rating input {
	  display:none;
	}
	.star-rating label {
	  color:#ccc;
	  cursor:pointer;
	}
	.star-rating :checked ~ label {
	  color:#f90;
	}
	.star-rating label:hover,
	.star-rating label:hover ~ label {
	  color:#fc0;
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
		    type: 'bar', //차트의 유형
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
	
	$(function(){
		loadReply();

		var page = 1;
		var size = 3;
		
		$("#more-btn").click(function(){
			loadPeopleReply(page, size);
			page++;
		});
		
		//더보기 버튼을 강제 1회 클릭(트리거)
		$("#more-btn").click();
		
		//$(".edit-cancel-btn").click();
		$(".send-reply").submit(function(e){
			e.preventDefault();
			var reviewContent = $("#reviewContent").val();
			var reviewStarpoint = $("input[name=starPoint]").val();
			var movieNo = '${movieDto.movieNo}';
			var memberNo = '${memberNo}';
			if(memberNo == '0'){
				alert("로그인 후 작성 가능합니다.");
				$("#reviewContent").val("");
				$("#reviewStarpoint").val("");
				return;
			}
			if(!reviewContent || !reviewStarpoint){
				alert("내용을 작성해주세요.");
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/data/watchedCheck",
				type:"get",
				data:{
					movieNo:movieNo,
					memberNo:memberNo
					},
				dataType:"text",
				success:function(resp){
					if(resp=='NNNNA'){
						console.log(resp);					
						alert("해당 영화의 리뷰를 이미 작성하셨습니다.");
						$("#reviewContent").val("");
						$("#reviewStarpoint").val("");
						return;
					}else if(resp=='NNNNN'){
						console.log(resp);
						alert("해당 영화 관람 후 작성이 가능합니다.");
						$("#reviewContent").val("");
						$("#reviewStarpoint").val("");
						return;
					}else{
						replyInsert(reviewContent,reviewStarpoint,movieNo,memberNo);
						console.log("성공", resp);
					}
				},
				error:function(e){
					console.log("실패",e);
				}
			});
		
		});

	});

	
	function replyInsert(reviewContent,reviewStarpoint,movieNo,memberNo){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/member/replyInsert",
			type:"post",
			data:{
				reviewContent:reviewContent,
				reviewStarpoint:reviewStarpoint,
				movieNo:movieNo,
				memberNo:memberNo
				},
			success:function(resp){
				console.log("성공", resp);
				alert("성공적으로 추가되었습니다.");
				$("#reviewContent").val("");
				$("#reviewStarpoint").val("");
				$(".btn-close").click();
				loadReply();
			},
			error:function(e){
				alert("이미 리뷰를 등록하셨습니다.");
				$("#reviewContent").val("");
				$("#reviewStarpoint").val("");
				console.log("실패",e);
			}
		});
	}
	
	function loadReply(){
		var movieNo = '${movieDto.movieNo}';
		var memberNo = '${memberNo}';
		$.ajax({
			url:"${pageContext.request.contextPath}/member/loadReply",
			type:"get",
			data:{
				movieNo : movieNo,
			},
			dataType : "json",
			success:function(resp){
				console.log("내 평점 성공", resp);
				$(".reply-items").empty();
				for(var i = 0 ; i < resp.length ; i++){
				if('${memberNo}' == resp[i].memberNo){
					var template = $("#template-reply").html();
					template = template.replace("{{memberNick}}",resp[i].memberNick);
					template = template.replace("{{reviewStarpoint}}",resp[i].reviewStarpoint);
					template = template.replace("{{reviewDate}}",resp[i].reviewDate);
					template = template.replace("{{reviewContent}}",resp[i].reviewContent);
					template = template.replace("{{reviewLike}}",resp[i].reviewLike);
					template = template.replace("{{memberNo}}",resp[i].memberNo);
					template = template.replace("{{movieNo}}",resp[i].movieNo);
					template = template.replace("{{memberNo}}",resp[i].memberNo);
					template = template.replace("{{movieNo}}",resp[i].movieNo);
					template = template.replace("{{reviewStarpoint}}",resp[i].reviewStarpoint);
					template = template.replace("{{reviewDate}}",resp[i].reviewDate);
					template = template.replace("{{reviewContent}}",resp[i].reviewContent);
					template = template.replace("{{reviewLike}}",resp[i].reviewLike);
					template = template.replace("{{reviewLikePlus}}",parseInt(resp[i].reviewLike)+1);

					var tag = $(template);
					tag.find(".edit-btn").click(function(){
						$(this).parents("tr.view-row").hide();
						$(this).parents("tr.view-row").next("tr.edit-row").show();
					});
					tag.find(".edit-cancel-btn").click(function(){
						$(this).parents("tr.edit-row").hide();
						$(this).parents("tr.edit-row").prev("tr.view-row").show();
					});
					
					
					tag.find(".btn-edit-reply").click(function(e){
						e.preventDefault();
						var movieNo = $(this).data("movie_no");
						var memberNo = $(this).data("member_no");
						var reviewStarpoint = $(this).parents("tr.edit-row").find("input[name=reviewStarpoint]").val();
						var reviewContent = $(this).parents("tr.edit-row").find("input[name=reviewContent]").val();
						console.log("movieNo", movieNo);
						console.log("memberNo", memberNo);
						console.log("reviewStarpoint", reviewStarpoint);
						console.log("reviewContent", reviewContent);
						
						if(!reviewContent || !reviewStarpoint || !memberNo || !movieNo){
							return;
						}
						updateReply(reviewContent,reviewStarpoint,movieNo,memberNo);
					});
					tag.find(".delete-btn").click(function(e){
						e.preventDefault();
						var movieNo = $(this).data("movie_no");
						var memberNo = $(this).data("member_no");
						deleteReply(movieNo,memberNo);
					});
					tag.find(".reply-like").click(function(e){
						e.preventDefault();
						var movieNo = $(this).next().next().data("movie_no");
						var memberNo = $(this).next().next().data("member_no");
						
						console.log("movieNo", movieNo);
						console.log("memberNo", memberNo);
						if('${memberNo}'=='0'){
							alert("로그인 후 가능합니다.");
							return;
						}
						addReplylike(movieNo,memberNo);
						$(this).hide();
						$(this).prev().show();
					});
					$(".reply-items").append(tag);
				}
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	function loadPeopleReply(page, size){
		var movieNo = '${movieDto.movieNo}';
		var memberNo = '${memberNo}';
		$.ajax({
			url:"${pageContext.request.contextPath}/data/loadPeopleReply",
			type:"get",
			data:{
				movieNo : movieNo,
				page:page,
				size:size
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
					if(resp.length < size){
						$("#more-btn").remove();
					}
				for(var i = 0 ; i < resp.length ; i++){

				if('${memberNo}' != resp[i].memberNo){
					var template = $("#template-reply-not").html();
					template = template.replace("{{memberNick}}",resp[i].memberNick);
					template = template.replace("{{reviewStarpoint}}",resp[i].reviewStarpoint);
					template = template.replace("{{reviewDate}}",resp[i].reviewDate);
					template = template.replace("{{reviewContent}}",resp[i].reviewContent);
					template = template.replace("{{reviewLike}}",resp[i].reviewLike);
					template = template.replace("{{memberNo}}",resp[i].memberNo);
					template = template.replace("{{movieNo}}",resp[i].movieNo);
					template = template.replace("{{reviewLikePlus}}",parseInt(resp[i].reviewLike)+1);
					var tag = $(template);
					tag.find(".reply-like").click(function(e){
						e.preventDefault();
						var movieNo = $(this).data("movie_no");
						var memberNo = $(this).data("member_no");
						console.log("movieNo", movieNo);
						console.log("memberNo", memberNo);
						if('${memberNo}'=='0'){
							alert("로그인 후 가능합니다.");
							return;
						}
						addReplylike(movieNo,memberNo);
						$(this).hide();
						$(this).next().show();
					});
					$(".reply-people-items").append(tag);
				}
				
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function deleteReply(movieNo,memberNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/self/deleteReply?"+$.param({"movieNo":movieNo,"memberNo":memberNo}),
			type:"delete",
			dataType:"text",
			success:function(resp){
				console.log("성공", resp);
				alert("리뷰 삭제가 완료되었습니다.");
				loadReply();
			},
			error:function(e){}
		});
	}
	
	function addReplylike(movieNo,memberNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/member/addReplylike",
			type:"post",
			data:{
				movieNo:movieNo,
				memberNo:memberNo
				},
			success:function(resp){
				console.log("댓글 좋아요 성공", resp);
				//loadReply();
			},
			error:function(e){
				console.log("수정 실패",e);
			}
		});
	}
	
	function updateReply(reviewContent,reviewStarpoint,movieNo,memberNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/self/replyUpdate",
			type:"post",
			data:{
				reviewContent:reviewContent,
				reviewStarpoint:reviewStarpoint,
				movieNo:movieNo,
				memberNo:memberNo
				},
			success:function(resp){
				console.log("수정 성공", resp);
				alert("리뷰 수정이 완료되었습니다.");
				loadReply();
			},
			error:function(e){
				console.log("수정 실패",e);
			}
		});
	}
	</script>
	
	
<template id="template-reply">
	<tr class="view-row">
		<td>{{memberNick}}</td>
		<td>{{reviewStarpoint}}</td>
		<td>{{reviewDate}}</td>
		<td>{{reviewContent}}</td>
		<td>
			<button class="reply-already-like" style="color: red;display: none;">♡좋아요({{reviewLikePlus}})</button>
			<button class="reply-like">♡좋아요({{reviewLike}})</button>
			<button class="edit-btn">수정</button>
			<button class="delete-btn" data-movie_no="{{movieNo}}" data-member_no="{{memberNo}}">삭제</button>
		</td>
	</tr>
	<tr class="edit-row" style="display: none;">
				<td><span>별점 : </span><input type="number" class="reviewStarpoint" name="reviewStarpoint" required min="0" max="5" value="{{reviewStarpoint}}"></td>
				<td><span>내용 : </span><input type="text" class="reviewContent" name="reviewContent" required value="{{reviewContent}}"></td>
				<td>
					<input type="submit" class="btn-edit-reply" data-movie_no="{{movieNo}}" data-member_no="{{memberNo}}" value="완료">
					<button type="button" class="edit-cancel-btn">취소</button>
				</td>
	</tr>
</template>	
<template id="template-reply-not">
	<tr class="view-row">
		<td>{{memberNick}}</td>
		<td>{{reviewStarpoint}}</td>
		<td>{{reviewDate}}</td>
		<td>{{reviewContent}}</td>
		<td>
			<button class="reply-like" data-movie_no="{{movieNo}}" data-member_no="{{memberNo}}">♡좋아요({{reviewLike}})</button>
			<button class="reply-already-like" style="color: red;display: none;">♡좋아요({{reviewLikePlus}})</button>
		</td>
	</tr>
</template>		
	
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
  									<span>${showStatus }</span>
  								</em>
 								<button type="button" class="btn-like btn btn-sm btn-outline-secondary" style="margin: 10px;">
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
			
			<!-- 트레일러 동영상 -->
		<div class="container center" style="width: 1000px;">
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

			<!-- 스틸컷 이미지 -->
			<table class="table table-bordered">
 				<thead>
  					 <tr class="table-active">
      					<th>스틸컷</th>
   					</tr>
 				</thead>
 				<tbody>
 				
   					<tr>
   						<td>
		   					<div id="carouselExampleControls" class="carousel carousel-dark slide" data-bs-ride="carousel">
								<div class="carousel-inner">
								    <c:forEach var="moviePhotoDto" items="${moviePhotoList}" varStatus="status">
			   							<c:if test="${status.index != 0}">						
											<div class="carousel-item ${status.index == 1 ? 'active' : ''	 }">
				   								<img src="${root}/movie/movieImg?moviePhotoNo=${moviePhotoDto.moviePhotoNo}" style="margin:0 auto" width="197px" height="260px" class="d-block" alt="...">
											</div>		   								
			   							</c:if>
			   						</c:forEach>
								</div>
								<button class="carousel-control-prev" type="button"
									data-bs-target="#carouselExampleControls" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button"
									data-bs-target="#carouselExampleControls" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Next</span>
								</button>
							</div>		
     			 		</td>
  			 		</tr>
  			 		
				</tbody>
			</table>	
			
			<br>
			<br>
	</div>

	<%-- 모달로 띄워주기 --%>

	<!--Modal Button -->
	<!-- Button trigger modal -->
	<div class="container-1000 container-center">
		<div class="row">
				<div class="col-10 center" >
					<label
						style="border: solid 1px; border-radius: 12px; border-color: gray;  padding: 20px;">
						 ${movieDto.movieTitle}재미있게 보셨나요? 
						영화의 어떤 점이 좋았는지 이야기해주세요. 
					</label>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#exampleModal" style="height: 66px; padding:9px;">관람평 작성</button>
				</div>
				
				</div>

		<!-- Modal -->
						<form class="send-reply">
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">${movieDto.movieTitle}</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="content-box">


							<div class="star-rating" >
				    			<input type="radio" id="5-stars" name="starPoint" value="5" checked/>
				    			<label for="5-stars" class="star">&#9733;</label>
				    			<input type="radio" id="4-stars" name="starPoint" value="4" />
				    			<label for="4-stars" class="star">&#9733;</label>
				    			<input type="radio" id="3-stars" name="starPoint" value="3" />
				    			<label for="3-stars" class="star">&#9733;</label>
				    			<input type="radio" id="2-stars" name="starPoint" value="2" />
				    			<label for="2-stars" class="star">&#9733;</label>
				    			<input type="radio" id="1-star" name="starPoint" value="1" />
				    			<label for="1-star" class="star">&#9733;</label>
				  			</div>
		 				
		 				</div>
						<textarea type="text" id="reviewContent" name="reviewContent"
							required rows="4" cols="58" style="resize: none; margin-top:15px; width:95%;" placeholder="실관람평을 남겨주세요."></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</div>
			</div>
		</div>
						</form>
			
				<table class="table">
					<thead class="reply-items">
					</thead>
					
					<tbody class="reply-people-items">
					</tbody>
				</table>
				
				<button class="btn btn-primary" id="more-btn">더보기</button>
			</div>
				
		</div>
			

			
			

	





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>