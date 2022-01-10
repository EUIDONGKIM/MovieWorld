<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
	<style>
	.container{
	padding:30px;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	$(function(){
		var page = 1;
		var size = 5;
		
		$(".more-btn").click(function(){
			loadData(page, size);
			page++;
		});
		
		//더보기 버튼을 강제 1회 클릭(트리거)
		$(".more-btn").click();
		
		//내부적으로 사용할 함수 (외부에서는 호출 불가)
		function loadData(pageValue, sizeValue){
			$.ajax({
				url:"${root}/member/movieLikeListMore",
				type:"get",
				data:{
					page : pageValue,
					size : sizeValue
				},
				dataType:"json",
				success:function(resp){
					console.log("성공", resp);

					//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
					if(resp.length < sizeValue){
						$(".more-btn").remove();
					}
					
					//데이터 출력
					
					for(var i=0; i < resp.length; i++){
						
						var html = "<div class='container fluid'>"+
										"<div class='row'>"+
											"<div class='col-md-2' style='float: none; margin:0 auto;'>"+
												"<a href='${root}/movie/movieDetail?movieNo="+resp[i].movieNo+"'>"+
														"<img src='${root}/movie/movieImg?moviePhotoNo="+resp[i].moviePhotoNo+"' width='197px' height='260px'>"+
												"</a>"+
											"</div>"+
											"<div class='col col-9'>"+
												"<div class='row'>"+
													"<h4><strong><a href='${root}/movie/movieDetail?movieNo="+resp[i].movieNo+"'>"+resp[i].movieTitle+"</a></strong></h4><p>"+resp[i].movieEngTitle+"</p>"+
												"</div>"+
												"<hr>"+
												"<div class='row'>"+
												"<p>장르 : "+resp[i].movieType+"</p>"+
												"<p>기본 : "+resp[i].movieGrade+", "+resp[i].movieRuntime+"분, "+resp[i].movieCountry+"</p>"+
												"<p>개봉 : "+resp[i].getOpeningDay+"</p>"+
												"</div>"+
											"</div>"+
										"</div>"+
									"</div>";
						
						$("#result").append(html);
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	});
</script>
	<div class="row">
		<div class="col">
			<h1 class="center">내가 보고 싶은 영화 (${count})건</h1>
		</div>
	</div>

<div id="result"></div>


<div class="container">
	<div class="row center">
		<div class="col">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
</div>
