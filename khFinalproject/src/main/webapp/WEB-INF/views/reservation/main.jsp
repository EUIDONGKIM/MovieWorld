<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.16/cinema/hacademy-cinema.css">
<style>
.float-container > .float-item-left:nth-child(1) {
		width:35%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(2) {
    width:10%;
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
    width:25%;
    padding:0.5rem;
}
.flex-container {
    display: flex;
    flex-direction: column;
}
</style>

<style>
    *{
        box-sizing: border-box;
    }
    .float-box > div{
        float:left;
        width:50%;
    }
    .float-box::after{
        content:"";
        display: block;
        clear:both;
    }
    .float-box > .result {
        padding:0.5rem;
    }
    .cinema-seat,
    .cinema-space{
    width: 70px !important;
    height: 70px !important;
    }

</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.16/cinema/hacademy-cinema.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	//상영 번호를 얻은 순간부터 다른 뷰로 사용하기.
		$(".page").hide();
        $(".page").eq(0).show();
		
        var p = 0;
        
        $(".btn-next").click(function(e){
            e.preventDefault();


                var cinema = new Hacademy.Reservation("#cinema");
                cinema.addChangeListener(function(seat){
                    print(this);
                });
                print(cinema);
                function print(app){
                    document.querySelector(".result").textContent = app.getQueryString();
                }


            p++;
            $(".page").hide();
            $(".page").eq(p).show();
        });
		
		 $(".btn-prev").click(function(e){
             e.preventDefault();

             p--;
             $(".page").hide();
             $(".page").eq(p).show();
         });
		var movieNo;
		var theaterSido;
		var theaterNo;
		var scheduleTimeDate;
		var scheduleTimeDateTime;
		var scheduleTimeNo;
		var hallRows;
		var hallCols;
	
	$("input[name=theaterSido]").on("input",function(){
		theaterSido = $(this).val();
		theaterNameList(theaterSido);
		loadList();
	});
	$("input:radio[name=theaterSido]").eq(0).attr("checked", true);
	theaterNameList($("input:radio[name=theaterSido]").val());
	

	
	$("input[name=movieNo]").on("input",function(){
		movieNo = $(this).val();
		movieList(movieNo);
	});
	
	function theaterNameList(theaterSido){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal",
			type:"get",
			data : {
				theaterSido:theaterSido
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".theater-name-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterNo");
					template = template.replace("{{name}}",resp[i].theaterName);
					template = template.replace("{{value}}",resp[i].theaterNo);
					
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						theaterNo = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						//추후에 한번에 검색 처리(다중 검색)하는 로직으로 만들어보기...!!
					});
					
					$(".theater-name-list").append(tag);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
		
	}
	
	function movieList(movieNo){	
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal1",
			type:"get",
			data : {
				movieNo:movieNo,
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".theater-sido-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterSido");
					template = template.replace("{{name}}",resp[i]);
					template = template.replace("{{value}}",resp[i]);
					
					var tag = $(template);
					tag.find("input[name=theaterSido]").on("input",function(){
						theaterSido = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						
						theaterNoList(movieNo,theaterSido);
						
					});
					
					$(".theater-sido-list").append(tag);
				}	
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function theaterNoList(movieNo,theaterSido){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal2",
			type:"get",
			data : {
				movieNo:movieNo,
				theaterSido:theaterSido
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".theater-name-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterNo");
					template = template.replace("{{name}}",resp[i].theaterName);
					template = template.replace("{{value}}",resp[i].theaterNo);
					
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						theaterNo = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						
						scheduleDateList(movieNo,theaterNo);
					});
					
					$(".theater-name-list").append(tag);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
		
	}
	
	function scheduleDateList(movieNo,theaterNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal3",
			type:"get",
			data : {
				movieNo:movieNo,
				theaterNo:theaterNo
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".schedule-time-date-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","scheduleTimeDate");
					template = template.replace("{{name}}",resp[i]);
					template = template.replace("{{value}}",resp[i]);
					
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						scheduleTimeDate = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						console.log(scheduleTimeNo);
						
						scheduleDateTimeDateList(scheduleTimeDate);
					});
					
					$(".schedule-time-date-list").append(tag);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	
	function scheduleDateTimeDateList(scheduleTimeDate){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal4",
			type:"get",
			data : {
				movieNo:movieNo,
				theaterNo:theaterNo,
				scheduleTimeDate:scheduleTimeDate
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".schedule-time-date-time-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","scheduleTimeNo");
					scheduleTimeDateTime = resp[i].scheduleTimeDateTime.substring(11);
					
					template = template.replace("{{name}}",scheduleTimeDateTime);
					template = template.replace("{{value}}",resp[i].scheduleTimeNo);
					
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						scheduleTimeNo = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						console.log(scheduleTimeNo);
						
						
					});
					
					$(".schedule-time-date-time-list").append(tag);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function scheduleDateTimeDateList(scheduleTimeDate){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal4",
			type:"get",
			data : {
				movieNo:movieNo,
				theaterNo:theaterNo,
				scheduleTimeDate:scheduleTimeDate
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
				$(".schedule-time-date-time-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","scheduleTimeNo");
					scheduleTimeDateTime = resp[i].scheduleTimeDateTime.substring(11);
					
					template = template.replace("{{name}}",scheduleTimeDateTime);
					template = template.replace("{{value}}",resp[i].scheduleTimeNo);
					
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						scheduleTimeNo = $(this).attr("value");
						
						console.log(movieNo);
						console.log(theaterSido);
						console.log(theaterNo);
						console.log(scheduleTimeDate);
						console.log(scheduleTimeDateTime);
						console.log(scheduleTimeNo);
						
						getHallRowsAndCols(scheduleTimeNo);
					});
					
					$(".schedule-time-date-time-list").append(tag);
				}
				
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function getHallRowsAndCols(scheduleTimeNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal5",
			type:"get",
			data : {
				scheduleTimeNo:scheduleTimeNo
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				hallRows = resp.hallRows;
				hallCols = resp.hallCols;
				
				console.log(movieNo);
				console.log(theaterSido);
				console.log(theaterNo);
				console.log(scheduleTimeDate);
				console.log(scheduleTimeDateTime);
				console.log(scheduleTimeNo);
				console.log(hallRows);
				console.log(hallCols);
				getSeat(scheduleTimeNo);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}

	function getSeat(scheduleTimeNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/seat",
			type:"get",
			data : {
				scheduleTimeNo:scheduleTimeNo
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				var template = $("#seat-list-template").html();
				template = template.replace("{{hallRows}}",hallRows);
				template = template.replace("{{hallCols}}",hallCols);
				template = template.replace("{{scheduleTimeNo}}",scheduleTimeNo);
				
				var tag = $(template);

				for(var i=0 ; i<resp.length ; i++){
					var addDiv = $("<div>").addClass("cinema-seat").attr("data-row", resp[i].seatRows).attr("data-col",resp[i].seatCols)
					.attr("data-state",resp[i].seatStatus).attr("data-direction","up");
					$("<input type='checkbox' name='seat' value='"+resp[i].seatRows+"-"+resp[i].seatCols+"' style='display: none;'>").appendTo(addDiv);
					var spanTemplate = $("#span-template").html();
					spanTemplate = spanTemplate.replace("{{row}}",resp[i].seatRows);
					spanTemplate = spanTemplate.replace("{{col}}",resp[i].seatCols);
					addDiv.append(spanTemplate);

					tag.find(".cinema-seat-area").append(addDiv);
				}

				$(".seat-box").append(tag);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	
	
});
</script>

<h1> 예매 화면 </h1>

<template id="movie-list-template">
	<div>
		<label>
		<input type="radio" name="moveiNo" value="{{value}}">
		<span>{{grade}} {{name}}</span>		
		</label>
	</div>	
</template>

<template id="list-template">
	<div>
		<label>
		<span>{{name}}</span>
		<input type="radio" name="{{key}}" value="{{value}}">
		</label>
	</div>	
</template>



<div class="container-1000 container-center page">
// 영화로 부터 순차적으로 고를 수 있게 진행(이후화면 노터치 / 현재 고를 순서만 터치)
	<div class="row float-container">
		
		<div class="float-item-left">
			<div class="row"><h2>영화</h2></div>
				<div class="movie-list">
						<c:forEach var="movieCountVO" items="${movieCountVOList}">
						<div class="flex-container">
							<label>
								<input type="radio" name="movieNo" value="${movieCountVO.movieNo }">
								<span>${movieCountVO.movieGrade } ${movieCountVO.movieTitle }</span>
							</label>
						</div>
						</c:forEach>
				</div>
		</div>

		<div class="float-item-left">
			<div class="row"><h2>지역</h2></div>
				<div class="theater-sido-list">
						<c:forEach var="theaterCityVO" items="${theaterCityVOList}">
						<div class="flex-container">
							<label>
								<input type="radio" name="theaterSido" value="${theaterCityVO.theaterSido }">
								<span>${theaterCityVO.theaterSido }</span>
							</label>
						</div>
						</c:forEach>
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
					<div class="schedule-time-date-list">
						<c:forEach var="date" items="${dateList}">
						<div class="flex-container">
							<label>
								<input type="radio" name="scheduleTimeDate" value="${date}">
								<span>${date}</span>
							</label>
						</div>
						</c:forEach>
					</div>
				</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>시간</h2></div>
				<div class="flex-container">
					<div class="schedule-time-date-time-list"></div>
				</div>
		</div>
		
	</div>
	
	<div class="row center">
		<button class="btn btn-next">다음 단계</button>
	</div>
</div>


<div class="page">

<template id="seat-list-template">
	<div class="float-box">
		<div>
		<form action="${pageContext.request.contextPath}/reservation/insert" method="post">
			<div id="cinema" class="cinema-wrap" data-name="seat">
				<div class="cinema-screen">상단 구조물 또는 제목 영역</div>
					
					<div class="cinema-seat-area" data-rowsize="{{hallRows}}" data-colsize="{{hallCols}}" data-mode="client" data-fill="manual" data-seatno="visible">
						
					</div>
			</div>
	<input type="hidden" name="scheduleTimeNo" value="{{scheduleTimeNo}}">
	<input type="submit" value="선택">
		</div>
		</form>
	</div>
</template>		

<template id="span-template">
<span>{{row}}-{{col}}</span>
</template>
  		 
	<div class="seat-box"></div>


    <h2 align="center">전송되는 데이터 형태</h2>

    <div class="result">         
    </div>

	
	<div class="row center">
		<button class="btn btn-prev">이전 단계</button>
		<button class="submit">제출</button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>