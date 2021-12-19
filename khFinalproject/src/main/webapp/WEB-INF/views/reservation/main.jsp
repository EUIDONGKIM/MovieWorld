<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.float-container > .float-item-left:nth-child(1) {
		width:25%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(2) {
    width:15%;
    padding:0.5rem;
}
.float-container > .float-item-left:nth-child(3) {
		width:15%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(4) {
    width:10%;
    padding:0.5rem;
}
.float-container > .float-item-left:nth-child(5) {
    width:30%;
    padding:0.5rem;
}
.flex-container {
    display: flex;
    flex-direction: column;
}

</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	
	movieList();
	
	function changeTimeList(date){
		var movieNo = $("input:checkbox[name='movieNo']:checked").val();
		var theaterNo = $("input:checkbox[name='theaterNo']:checked").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal5",
			type:"get",
			data : {
				theaterNo:theaterNo,
				movieNo:movieNo,
				date:date
			},
			dataType : "json",
			success:function(resp){
				$(".schedule-time-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					//해당 극장과 해당 영화의 날짜에 대해서 모든 상영관에 있는 모든 영화 시간들이 나온다
					//상영 회차의 프라이머키를 연결하여서, 2번째 뷰를 통해서 좌석 예매를 한다.
					var tag = $("<button>")
					.attr("data-schedule_time_no",resp[i].scheduleTimeNo);

					
					tag.on("click",function(){
						//상영 회차의 프라이머 키로 2번째 뷰를 통해서 좌석으로 고르고
						//회원과 연계하여 예매해주면 된다.
						
						//이후의 좌석관련은 강사님 화면으로 처리하여 좌석 처리 후 선택된 좌석 반환
						//(active)컨테인 되어있음 좌석수를 계산하여 count(-값)해주는 SQL 메소드 생성
						
						
						//토글을 통해서 한화면에 숨겨진 것으로 불러와준다.
					});
					
					var show = $("<span>")
					.text(resp[i].hallName);
					var show1 = $("<span>")
					.text(resp[i].scheduleTimeTime);
					var show2 = $("<span>")
					.text(resp[i].scheduleTimeDiscountType);
					
					tag.append(show).append(show1).append(show2);
					$(".schedule-time-list").append(tag);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function changeDateList(theaterNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal4",
			type:"get",
			data : {
				theaterNo:theaterNo,
				movieNo:movieNo,
			},
			dataType : "json",
			success:function(resp){
				$(".schedule-date-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					//상영번호들을 얻을 수 있다. => 여러개있는 상영 번호들로부터 날짜들(상영일)을 뽑아내야함

					var tag = $("<button>")
					.attr("data-schedule_time_date",resp[i].scheduleTimeDate);
					
					tag.on("click",function(){
						var date = $(this).data("schedule_time_date");
						changeTimeList(resp[i].scheduleTimeDate);
					});
					
					var show = $("<span>")
					.text(resp[i].scheduleTimeDate);
					
					tag.append(show);
					$(".schedule-date-list").append(tag);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function changeTheaterNameList(theaterSido){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal3",
			type:"get",
			data : {
				theaterSido:theaterSido
			},
			dataType : "json",
			success:function(resp){
				$(".theater-name-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template2 = $("#theater-name-list-template").html();
					template2 = template2.replace("{{name}}",resp[i].theaterName);
					template2 = template2.replace("{{value}}",resp[i].theaterNo);

					var tag = $(template2);
					tag.find("input[type=checkbox]").on("input",function(){
						//하나만 체크가 남도록 설정하기 추후에
						var theaterNo = $(this).attr("value");
						changeDateList(theaterNo);
					});
					
					$(".theater-name-list").append(template2);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function changeSidoList(movieNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal2",
			type:"get",
			data : {
				movieNo:movieNo
			},
			dataType : "json",
			success:function(resp){
				$(".theater-sido-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template2 = $("#theater-sido-list-template").html();
					template2 = template2.replace("{{name}}",resp[i].theaterSido);
					template2 = template2.replace("{{value}}",resp[i].theaterNo);

					var tag = $(template2);
					tag.find("input[type=checkbox]").on("input",function(){
						//하나만 체크가 남도록 설정하기 추후에
						var theaterSido = $(this).attr("value");
						changeTheaterNameList(theaterSido);
					});
					
					$(".theater-sido-list").append(template2);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function movieList(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal1",
			type:"get",
// 			data : {
// 				hallNo:hallNo
// 			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".movie-list").empty();
				$(".theater-sido-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template1 = $("#movie-list-template").html();
					template1 = template1.replace("{{name}}",resp[i].movieTitle);
					template1 = template1.replace("{{value}}",resp[i].movieNo);
					template1 = template1.replace("{{grade}}",resp[i].movieGrade);
					
					var tag = $(template1);
					tag.find("input[type=checkbox]").on("input",function(){
						//하나만 체크가 남도록 설정하기 추후에
						var movieNo = $(this).attr("value");
						changeSidoList(movieNo);
					});
					
					$(".movie-list").append(template1);
					
					var template2 = $("#theater-sido-list-template").html();
					template2 = template2.replace("{{name}}",resp[i].theaterSido);
					template2 = template2.replace("{{value}}",resp[i].theaterSido);

					$(".theater-sido-list").append(template2);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
		
	}
	
// 	$(".movie-ckb").on("input",function(){
// 				movieNo,hallNo
// 	});
	

});
</script>

<h1> 예매 화면 </h1>

<template id="movie-list-template">
	<div>
		<label>
		<span>{{grade}} {{name}}</span>		
		<input type="checkbox" class="movie-ckb" name="moveiNo" value="{{value}}">
		</label>
	</div>	
</template>

<template id="theater-sido-list-template">
	<div>
		<label>
		<span>{{name}}</span>
		<input type="checkbox" class="theater-sido-ckb" name="theaterSido" value="{{value}}">
		</label>
	</div>	
</template>

<template id="theater-name-list-template">
	<div>
		<label>
		<span>{{name}}</span>
		<input type="checkbox" class="theater-name-ckb" name="theaterNo" value="{{value}}">
		</label>
	</div>	
</template>

영화와 극장은 서로 다르게 뿌려준다.
// 영화로 부터 순차적으로 고를 수 있게 진행(이후화면 노터치 / 현재 고를 순서만 터치)
<div class="container-900 container-center">
	<div class="row float-container">
		
		<div class="float-item-left">
			<div class="row"><h2>영화</h2></div>
				<div class="flex-container">
					<div class="movie-list"></div>
				</div>
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>극장(시도)</h2></div>
				<div class="flex-container">
					<div class="theater-sido-list"></div>
				</div>
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>극장(명)</h2></div>
				<div class="flex-container">
					<div class="theater-name-list"></div>
				</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>날짜</h2></div>
				<div class="flex-container">
					<div class="schedule-date-list"></div>
				</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>시간</h2></div>
				<div class="flex-container">
					<div class="schedule-time-list"></div>
				</div>
		</div>
		
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>