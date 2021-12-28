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
		var movieNo;
		var movieName;
		var theaterSido;
		var theaterNo;
		var scheduleTimeDate;
		var scheduleTimeDateTime;
		var scheduleTimeNo;
		var hallRows;
		var hallCols;

		
		var ageNormal=0;
		var ageYoung=0;
		var ageOld=0;
		var ageTotal=0;
		var seatNames;
		var seatTotal;
		
		var reservationKey;
		
		$(".page").hide();
        $(".page").eq(0).show();
		
        var p = 0;
        
        
        $(".btn-next").click(function(e){
            e.preventDefault();
			if(!scheduleTimeNo||!hallRows||!hallCols||!scheduleTimeDateTime) {
				alert("항목을 선택하세요!");
				return;
			}
			
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

	loadList();
	
	function loadList(){
		//첫 화면바로 띄워주기
		movieNo = null;
		theaterSido = null;
		theaterNo = null;
		scheduleTimeDate = null;
		scheduleTimeDateTime = null;
		scheduleTimeNo = null;
		hallRows = null;
		hallCols = null;
		//seat / age 정보 초기화 ?
		$(".movie-list").empty();
		$(".theater-sido-list").empty();
		
		$(".theater-name-list").empty();
		$(".theater-name-list").text('영화 또는 지점을 선택하세요.');
		
		$(".schedule-time-date-list").empty();
		$(".schedule-time-date-list").text('영화와 지점을 먼저 선택하세요.');
		
		$(".schedule-time-date-time-list").empty();
		$(".schedule-time-date-time-list").text('상영 날짜를 선택해주세요.');
		
		$(".seat-box").empty();
		
		movieLoadList();
		sidoLoadList();
	}
	
	$(".btn-init").click(function(e){
		e.preventDefault();
		loadList();
	});
	
	function sidoLoadList(){	
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getSido",
			type:"get",
			dataType : "json",
			success:function(resp){
				$(".theater-sido-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterSido");
					template = template.replace("{{name}}",resp[i].theaterSido);
					template = template.replace("{{value}}",resp[i].theaterSido);
					
					var tag = $(template);
					tag.find("input[name=theaterSido]").on("input",function(){
						theaterSido = $(this).attr("value");
						theaterNameList(theaterSido);
						
						$("input[name=movieNo]").prop("disabled",true);
						$("input[name=theaterSido]").each(function(){				
							if(theaterSido != $(this).val()){
									$(this).prop("disabled",true);
							}
						});
					});
					
					$(".theater-sido-list").append(tag);
				}	
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function movieLoadList(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getMovie",
			type:"get",
			dataType : "json",
			success:function(resp){
				$(".movie-list").empty();
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#movie-list-template").html();
					template = template.replace("{{grade}}",resp[i].movieGrade);
					template = template.replace("{{name}}",resp[i].movieTitle);
					template = template.replace("{{name}}",resp[i].movieTitle);
					template = template.replace("{{value}}",resp[i].movieNo);
					
					var tag = $(template);
					tag.find("input[name=movieNo]").on("input",function(){
						movieNo = $(this).attr("value");	
						movieName = $(this).data("name");
						$("input[name=movieNo]").each(function(){
							if(movieNo != $(this).val()){
									$(this).prop("disabled",true);
							}
						});
						if(!theaterSido){			
							sidoList(movieNo);
							}
					});
					$(".movie-list").append(tag);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function movieSearchList(theaterSido,theaterNo){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal11",
			type:"get",
			data : {
				theaterSido:theaterSido,
				theaterNo:theaterNo
			},
			dataType : "json",
			success:function(resp){
				$(".movie-list").empty();
				if(resp.length > 0){
				for(var i = 0 ; i < resp.length ; i++){
					
					var template = $("#movie-list-template").html();
					template = template.replace("{{grade}}",resp[i].movieGrade);
					template = template.replace("{{name}}",resp[i].movieTitle);
					template = template.replace("{{name}}",resp[i].movieTitle);
					template = template.replace("{{value}}",resp[i].movieNo);
					
					var tag = $(template);
					tag.find("input[name=movieNo]").on("input",function(){
						movieNo = $(this).attr("value");
						movieName = $(this).data("name");
						scheduleDateList(movieNo,theaterNo);
					});
					$(".movie-list").append(tag);
				}
				}else{
					$(".movie-list").text('해당 상영관의 상영 영화가 없습니다.처음부터 다시 해주세요 죄송합니다 ㅠㅠ');
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function theaterNameList(theaterSido){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal",
			type:"get",
			data : {
				theaterSido:theaterSido
			},
			dataType : "json",
			success:function(resp){
				$(".theater-name-list").empty();
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterNo");
					template = template.replace("{{name}}",resp[i].theaterName);
					template = template.replace("{{value}}",resp[i].theaterNo);
					var tag = $(template);
					
					tag.find("input[type=radio]").on("input",function(){
						theaterNo = $(this).attr("value");

						$("input[name=theaterNo]").each(function(){
							if(theaterNo != $(this).val()){
									$(this).prop("disabled",true);
							}
						});
						
						$(".movie-list").show();
						if(!movieNo){
							movieSearchList(theaterSido,theaterNo);
						}				
					});	
					$(".theater-name-list").append(tag);
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});	
	}
	
	function sidoList(movieNo){	
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getTotal1",
			type:"get",
			data : {
				movieNo:movieNo,
			},
			dataType : "json",
			success:function(resp){
				$(".theater-sido-list").empty();
				
				for(var i = 0 ; i < resp.length ; i++){
					var template = $("#list-template").html();
					template = template.replace("{{key}}","theaterSido");
					template = template.replace("{{name}}",resp[i]);
					template = template.replace("{{value}}",resp[i]);
					
					var tag = $(template);
					tag.find("input[name=theaterSido]").on("input",function(){
						theaterSido = $(this).attr("value");
						
						$("input[name=theaterSido]").each(function(){
							if(theaterSido != $(this).val()){
									$(this).prop("disabled",true);
							}
							
						});
						
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
				hallRows = resp.hallRows;
				hallCols = resp.hallCols;
				
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
				getReservationKey();
				$(".seat-box").empty();
				
				var template = $("#seat-list-template").html();
				template = template.replace("{{hallRows}}",hallRows);
				template = template.replace("{{hallCols}}",hallCols);
				template = template.replace("{{scheduleTimeNo}}",scheduleTimeNo);
				
				var tag = $(template);

				tag.find("input[name=ageNormal]").on("input",function(){
					ageNormal = $(this).val();
					$("input[name=ageTotal]")
					.val(parseInt($("input[name=ageNormal]").val())
					+parseInt($("input[name=ageYoung]").val())
					+parseInt($("input[name=ageOld]").val()));
				}); 
					
				tag.find("input[name=ageYoung]").on("input",function(){
					ageYoung = $(this).val();
					$("input[name=ageTotal]")
					.val(parseInt($("input[name=ageNormal]").val())
					+parseInt($("input[name=ageYoung]").val())
					+parseInt($("input[name=ageOld]").val()));
				}); 	
				tag.find("input[name=ageOld]").on("input",function(){
					ageOld = $(this).val();
					$("input[name=ageTotal]")
					.val(parseInt($("input[name=ageNormal]").val())
					+parseInt($("input[name=ageYoung]").val())
					+parseInt($("input[name=ageOld]").val()));
				}); 
				
				tag.find(".btn-pay").click(function(e){
		            p++;
		            $(".page").hide();
		            $(".page").eq(p).show();
		        });
					
				tag.find(".seat-send-form").submit(function(e){
		        	e.preventDefault();
		        	var seatData = $(".result").text();
					TempReservation(seatData,reservationKey,scheduleTimeNo,ageNormal,ageYoung,ageOld);
		        });
				
				for(var i=0 ; i<resp.length ; i++){
					var addDiv = $("<div>").addClass("cinema-seat").attr("data-row", resp[i].seatRows).attr("data-col",resp[i].seatCols)
					.attr("data-state",resp[i].seatStatus).attr("data-direction","up");
					$("<input type='checkbox' name='seat' class='chk-seat' value='"+resp[i].seatRows+"-"+resp[i].seatCols+"' style='display: none;'>").appendTo(addDiv);
					var spanTemplate = $("#span-template").html();
					spanTemplate = spanTemplate.replace("{{row}}",resp[i].seatRows);
					spanTemplate = spanTemplate.replace("{{col}}",resp[i].seatCols);
					addDiv.append(spanTemplate);
					
					addDiv.find(".chk-seat").on("input",function(){
						if(!ageTotal){
							alert("인원수를 선택해주세요!");
							return;
						}
					});
					
					tag.find(".cinema-seat-area").append(addDiv);
					
				}

				$(".seat-box").append(tag);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function getReservationKey(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getReservationKey",
			type:"get",
			dataType : "text",
			success:function(resp){
				console.log("성공 번호 얻어오기.", resp);
				reservationKey = resp;
				console.log("성공 번호 변경.", reservationKey);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	};
	
	function TempReservation(seatData,reservationKey,scheduleTimeNo,ageNormal,ageYoung,ageOld){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/TempReservation",
			type:"post",
			data : {
				seatData:seatData,
				reservationKey:reservationKey,
				scheduleTimeNo:scheduleTimeNo,
				ageNormal:ageNormal,
				ageYoung:ageYoung,
				ageOld:ageOld
			},
			success:function(resp){
				console.log("성공", resp);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	};
	
	
	function getReservation(reservationKey){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getReservation",
			type:"get",
			data : {
				reservationKey:reservationKey
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				var template = $("#reservation-template").html();
				template = template.replace("{{movieName}}",movieName);
				template = template.replace("{{theaterName}}",theaterName);
				template = template.replace("{{scheduleTimeDateTime}}",scheduleTimeDateTime);
				template = template.replace("{{reservationTotalNumber}}",resp.reservationTotalNumber);
				template = template.replace("{{totalAmount}}",reservationTotalNumber.totalAmount);

				$("pay-result-show").append(template);
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function getReservationDetail(reservationKey){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/getReservationDetail",
			type:"get",
			data : {
				reservationKey:reservationKey
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				for(var i = 0 ; i<resp.length ; i++){
					var template = $("#reservation-detail-template").html();
					template = template.replace("{{row}}",resp[i].seatRows);
					template = template.replace("{{col}}",resp[i].seatCols);
					template = template.replace("{{hallType}}",resp[i].hallType);
					template = template.replace("{{ageName}}",resp[i].ageName);
					template = template.replace("{{scheduleTimeDiscountType}}",resp[i].scheduleTimeDiscountType);
					template = template.replace("{{totalPrice}}",resp[i].totalPrice);
				}
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
		<input type="radio" name="movieNo" value="{{value}}" data-name="{{name}}">
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

	<div class="row center">
		<button type="button" class="btn-init"><h1>다시 선택</h1></button>
	</div>
	
	<div class="row float-container">
		
		<div class="float-item-left">
			<div class="row"><h2>영화</h2></div>
				<div class="movie-list">
				</div>
		</div>

		<div class="float-item-left">
			<div class="row"><h2>지역</h2></div>
				<div class="theater-sido-list">
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
		<button class="btn-next"><h1>다음 단계</h1></button>
	</div>
</div>


<div class="page">

<template id="seat-list-template">
	<div class="float-box center">
		<div>
		<form action="${pageContext.request.contextPath}/reservation/insert" method="post" class="seat-send-form">
		
			<span>일반:</span><input type="number" name="ageNormal" value="0" min="0" data-age-no="1">
			<span>청소년:</span><input type="number" name="ageYoung" value="0" min="0" data-age-no="2">
			<span>경로:</span><input type="number" name="ageOld" value="0" min="0" data-age-no="3">  
			<span>총 명:</span><input type="number" name="ageTotal" value="0" min="0" data-age-no="4"> 
			
			<div id="cinema" class="cinema-wrap" data-name="seat">
				<div class="cinema-screen"><h3>스크린</h3></div>
					
					<div class="cinema-seat-area" data-rowsize="{{hallRows}}" data-colsize="{{hallCols}}" data-mode="client" data-fill="manual" data-seatno="visible">
						
					</div>
			</div>
	<input type="hidden" name="scheduleTimeNo" value="{{scheduleTimeNo}}">
	<input type="submit" value="좌석선택 완료!이제 결제하러 가기.." class="btn-pay">
		</div>
		</form>
	</div>
</template>		

<template id="span-template">
<span>{{row}}-{{col}}</span>
</template>
  		 
  		 
  		 
  		 
	<div class="seat-box">
		
	</div>


    <h1 align="center">전송되는 데이터 형태</h1>

    <div class="result">         
    </div>

	
	<div class="row center">
		<button class="btn-prev"><h1>이전 단계</h1></button>
	</div>
</div>


<div class="page">
<template id="reservation-template">
	<div class="row center">
		<div class="row center">
			<label>영화</label>
			<span>{{movieName}}</span>
		</div>
		<div class="row center">
			<label>영화관</label>
			<span>{{theaterName}}</span>
		</div>
		<div class="row center">
			<label>상영시간</label>
			<span>{{scheduleTimeDateTime}}</span>
		</div>
		<div class="row center">
			<label>인원수</label>
			<span>{{reservationTotalNumber}} 명</span>
		</div>
		<div class="row center">
			<label>총 예매 금액</label>
			<span>{{totalAmount}}원</span>
		</div>
	</div>
</template>	

<template id="reservation-detail-template">
	<div class="row center">
		<div class="row center">
			<label>좌석</label>
			<span>{{row}}행{{col}}열</span>
		</div>
		<div class="row center">
			<label>상영관 종류</label>
			<span>{{hallType}}</span>
		</div>
		<div class="row center">
			<label>연령 구분</label>
			<span>{{ageName}}</span>
		</div>
		<div class="row center">
			<label>상영 구분</label>
			<span>{{scheduleTimeDiscountType}}</span>
		</div>
		<div class="row center">
			<label>개별 금액</label>
			<span>{{totalPrice}}</span>
		</div>
	</div>
</template>	

	<h1>결제 내역 확인</h1>
	<div id="pay-result-show"></div>
	
	<hr>
	
	<h1>결제 상세 내역 확인</h1>
	<div id="pay-detail-show"></div>
	
	<div class="row center">
		<button class="btn-pay-confirm"><h1>결제 진행(카카오 페이)</h1></button>
	</div>
	<div class="row center">
		<button class="btn-prev"><h1>이전 단계</h1></button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>