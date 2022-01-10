<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="direct" value="${lastInfoViewDto != null}"></c:set>
<c:set var="initDto" value="${lastInfoViewDto}"></c:set>
<c:set var="movieNoCheck" value="${movieNo != null}"></c:set>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.19/cinema/hacademy-cinema.css">
<style>
.float-container > .float-item-left:nth-child(1) {
		width:25%;	
		padding:0.5rem;
	}
.float-container > .float-item-left:nth-child(2) {
    width:7%;
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
    width:15%;
    padding:0.5rem;
}
.float-container > .float-item-left:nth-child(6) {
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
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.19/cinema/hacademy-cinema.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
$(function(){
	var memberEmail = '${memberEmail}';
	var memberPoint = '${memberPoint}';
	var usePoint=0;
	console.log(memberEmail);
	var movieNo;
	var movieName;
	var theaterSido;
	var theaterName;
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
	var checkPay;
	
	var movieRuntime;
	var hallType;
	var scheduleTimeDiscountType;
	
	$(".page").hide();
    $(".page").eq(0).show();
	
    var p = 0;
    
	$("input[name=memberPoint]").on("input",function(){
		var point = $(this).val();
		if(parseInt(point)>parseInt(memberPoint)){
			alert("포인트가 부족합니다.");
			$(this).val(parseInt(0));
			return;
		}else{
			usePoint = point;
			console.log("사용 포인트 입력 후 금액",usePoint);
		}
	});
	
	 $(".btn-use-point").click(function(e){

		 var price = $("input[name=total-amount]").val();

		 e.preventDefault();

		 if(usePoint==0){
			 alert("사용할 포인트를 입력해주세요!");
			 return;
		 }
		 $("input[name=use-amount]").val(usePoint);
		 $("input[name=result-amount]").val(
				parseInt(price)-
				usePoint
				 );
	 });
	
	 $(".btn-init-point").click(function(e){
		 console.log("초기화 버튼!");
		 e.preventDefault();
		 usePoint=0;
		 $("input[name=memberPoint]").val('0');
		 $("input[name=use-amount]").val('0');
		 $("input[name=result-amount]").val($("input[name=total-amount]").val());
	 });
	 
    
    $(".btn-next").click(function(e){
        e.preventDefault();

        if(!memberEmail) {
			var confirm = window.confirm("로그인이 필요합니다. 로그인 하시겠습니까?")
        	if(confirm){
        		location.href = "${root}/member/login";
        	}
        	return;
        }
        
		if(!scheduleTimeNo||!hallRows||!hallCols||!scheduleTimeDateTime||ageTotal==0) {
			alert("항목을 선택하세요!");
			return;
		}
		
		var cinema = new Hacademy.Reservation("#cinema");
		
		cinema.addBeforeChangeListener(function(seat){
            if(this.getSelectedCount() == ageTotal){
                alert("인원이 초과하였습니다.")
                return false;//이벤트 진행 차단
            }
        });
		
	    cinema.addChangeListener(function(seat){
	        //this == cinema 앱
	        seatTotal = this.getQueryString();
	        console.log(seatTotal);
	    });

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

	 $(".btn-seat-cancel").click(function(){
		 loadList();
		//강사님 좌석 체크박스 컨트롤 하는 법 및 좌석 체크들 해제하기.
	 });		
			
	 $(".btn-pay-cancel").click(function(){
		 $("#pay-result-show").empty();
		 $("#pay-detail-show").empty();
		 checkPay=null;
		 cancelTempReservation(reservationKey);
		 getReservationKey();
	 });
	
	$(".btn-pay-confirm").click(function(){
		console.log(reservationKey);
		console.log(checkPay);
		var point = parseInt($("input[name=use-amount]").val());
		console.log("사용 포인트?",point);
		
		if(reservationKey&&checkPay){
		var form = $("<form>").attr("action", "${pageContext.request.contextPath}/reservation/confirm")
		.attr("method", "post").addClass("send-form");
		$("body").append(form);
		$("<input type='hidden' name='memberPoint'>").val(point).appendTo(".send-form");
		$("<input type='hidden' name='reservationNo'>").val(reservationKey).appendTo(".send-form");
		form.submit();
		}
		
	});
	
	$(".ageNormal").on("input",function(){
		ageNormal = $(this).val();
		ageTotal = 0;
		ageTotal = parseInt(ageNormal)+parseInt(ageYoung)+parseInt(ageOld);
		$(".ageTotal").val(ageTotal);
		console.log(ageNormal);
		console.log(ageYoung);
		console.log(ageOld);
		console.log(ageTotal);
	}); 
		
	$(".ageYoung").on("input",function(){
		ageYoung = $(this).val();
		ageTotal = 0;
		ageTotal = parseInt(ageNormal)+parseInt(ageYoung)+parseInt(ageOld);
			$(".ageTotal").val(ageTotal);
			console.log(ageNormal);
			console.log(ageYoung);
			console.log(ageOld);
			console.log(ageTotal);
	}); 	
	
	$(".ageOld").on("input",function(){
		ageOld = $(this).val();
		ageTotal = 0;
		ageTotal = parseInt(ageNormal)+parseInt(ageYoung)+parseInt(ageOld);
		$(".ageTotal").val(ageTotal);
		console.log(ageNormal);
		console.log(ageYoung);
		console.log(ageOld);
		console.log(ageTotal);
	});
	
	if(${direct}){
		movieName = '${initDto.movieTitle}';
		theaterName = '${initDto.theaterName}';
		movieRuntime = '${initDto.movieRuntime}';
		movieNo = '${initDto.movieNo}';
		theaterSido = '${initDto.theaterSido}';
		theaterNo = '${initDto.theaterNo}';
		scheduleTimeDateTime = '${initDto.scheduleTimeDateTime}';
		var timedate = scheduleTimeDateTime.substring(0,10);
		scheduleTimeDate = timedate;
		scheduleTimeNo = '${initDto.scheduleTimeNo}';
		hallType = '${initDto.hallType}';
		scheduleTimeDiscountType = '${initDto.scheduleTimeDiscountType}';
		console.log("쳌0",scheduleTimeNo);
		
		
		movieLoadList();
		sidoList(movieNo);
		theaterNoList(movieNo,theaterSido);
		scheduleDateList(movieNo,theaterNo);
		scheduleDateTimeDateList(scheduleTimeDate);
		getHallRowsAndCols(scheduleTimeNo);
		
	}else if(${movieNoCheck}){
		movieNo = '${movieNo}';
		console.log("무비쳌0",movieNo);
		movieLoadList();
		sidoList(movieNo);
	}else{
		loadList();
	}
	
function directChecked(){
	$("input[name=movieNo]").each(function(){
		if($(this).val()==movieNo){
			$(this).prop("checked",true);
		}
	});
	$("input[name=theaterSido]").each(function(){
		if($(this).val()==theaterSido){
			$(this).prop("checked",true);
		}
	});
	$("input[name=theaterNo]").each(function(){
		if($(this).val()==theaterNo){
			$(this).prop("checked",true);
		}
	});
	$("input[name=scheduleTimeDate]").each(function(){
		console.log("쳌1");
		if($(this).val()==scheduleTimeDate){
			$(this).prop("checked",true);
		}
	});
	
	$("input[name=scheduleTimeNo][value='${initDto.scheduleTimeNo}']").prop("checked",true);
	
}	

function loadList(){
	//첫 화면바로 띄워주기
	movieRuntime = null;
	movieNo = null;
	theaterSido = null;
	theaterNo = null;
	scheduleTimeDate = null;
	scheduleTimeDateTime = null;
	scheduleTimeNo = null;
	hallRows = null;
	hallCols = null;
	hallType = null;
	scheduleTimeDiscountType = null;
	seatNames = null;
	seatTotal = null;
	reservationKey = null;
	checkPay = null;
	hallType = null;
	scheduleTimeDiscountType = null;
	usePoint = 0;
	 $(".seat-box").empty();
	 $(".result").empty();
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
	
	var initNo = 0;
	ageNormal=initNo;
	ageYoung=initNo;
	ageOld=initNo;
	ageTotal=initNo;
	$('input[name=ageNormal]').eq(0).prop("checked", true);
	$('input[name=ageYoung]').eq(0).prop("checked", true);
	$('input[name=ageOld]').eq(0).prop("checked", true);
	
	$(".ageTotal").val(initNo);
	
	$(".ageNormal").prop("disabled",true);
	$(".ageYoung").prop("disabled",true);
	$(".ageOld").prop("disabled",true);

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
				template = template.replace("{{runtime}}",resp[i].movieRuntime);

				var tag = $(template);
				tag.find("input[name=movieNo]").on("input",function(){
					movieRuntime = $(this).data("runtime");
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
				template = template.replace("{{runtime}}",resp[i].movieRuntime);

				var tag = $(template);
				tag.find("input[name=movieNo]").on("input",function(){
					movieRuntime = $(this).data("runtime");
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
				template = template.replace("{{name}}",resp[i].theaterName);
				template = template.replace("{{value}}",resp[i].theaterNo);
				var tag = $(template);
				
				tag.find("input[type=radio]").on("input",function(){
					theaterNo = $(this).attr("value");
					theaterName = $(this).data("name");
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
			if(resp.length == 0){
				alert("해당 영화의 상영 정보가 없습니다.!");
				loadList();
			}
			
			directChecked();
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
				template = template.replace("{{name}}",resp[i].theaterName);
				template = template.replace("{{value}}",resp[i].theaterNo);
				
				var tag = $(template);
				
				tag.find("input[type=radio]").on("input",function(){
					theaterNo = $(this).attr("value");
					theaterName = $(this).data("name");
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
			var date = new Date();
			console.log("현재날짜",date);
			var count = 0;

			for(var i = 0 ; i < resp.length ; i++){
				var checkDate = new Date(resp[i]);
				console.log("목록날짜",checkDate);
				console.log(checkDate>=date);
				date1 = new Date(date.getFullYear(),date.getMonth(),date.getDate());
				date2 = new Date(checkDate.getFullYear(),checkDate.getMonth(),checkDate.getDate());
				console.log("현재날짜1",date1);
				console.log("목록날짜2",date2);
				if(date2>=date1){
					
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
				count++;
				}
				
				}
				console.log(count);
				if(count==0){
					$(".schedule-time-date-list").text('해당 날짜의 상영일이 없습니다.');
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
				console.log("잔여좌석!!!!!!!!!!",resp[i].disabledSeat);
				var now = new Date().getTime();
				var date = resp[i].scheduleTimeDateTime;
				console.log("now",now);
				console.log("date",date);
				if(date>now){
				var template = $("#list-template").html();
				template = template.replace("{{key}}","scheduleTimeNo");
				//scheduleTimeDateTime = resp[i].scheduleTimeDateTime.substring(11,16);

				scheduleTimeDateTime = resp[i].scheduleTimeDateTime;
				console.log("scheduleTimeDateTime",scheduleTimeDateTime);
				
				var checkDate = new Date(resp[i].scheduleTimeDateTime);
				var firstTime = checkDate.getHours()+":"+checkDate.getMinutes();
				
				checkDate.setMinutes(checkDate.getMinutes()+movieRuntime);
				var sellCheck = resp[i].hallSeat-resp[i].disabledSeat;
				if(sellCheck==0) sellCheck='매진';
				template = 
				template.replace("{{name}}",resp[i].hallName+"["+resp[i].hallType+"]"+resp[i].scheduleTimeDiscountType + "\n" + firstTime + "~" + checkDate.getHours()+":"+checkDate.getMinutes()+"["+sellCheck+"|"+resp[i].hallSeat+"]");
				template = template.replace("{{scheduleTimeDiscountType}}",resp[i].scheduleTimeDiscountType);
				template = template.replace("{{hallType}}",resp[i].hallName+"["+resp[i].hallType+"]");
				template = template.replace("{{value}}",resp[i].scheduleTimeNo);
				
				var tag = $(template);

				tag.find("input[type=radio]").on("input",function(){
					scheduleTimeNo = $(this).attr("value");
					scheduleTimeDiscountType = $(this).data("scheduleTimeDiscountType");
					
					$(".ageNormal").prop("disabled",false);
					$(".ageYoung").prop("disabled",false);
					$(".ageOld").prop("disabled",false);
					
					
					getHallRowsAndCols(scheduleTimeNo);
				});
				
				$(".schedule-time-date-time-list").append(tag);
				
				}
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
			directChecked();
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
			directChecked();
			getReservationKey();
			$(".seat-box").empty();
			
			var template = $("#seat-list-template").html();
			template = template.replace("{{hallRows}}",hallRows);
			template = template.replace("{{hallCols}}",hallCols);
			template = template.replace("{{scheduleTimeNo}}",scheduleTimeNo);
			
			var tag = $(template);

			tag.find(".btn-pay").click(function(e){
	        	if(seatTotal==null || seatTotal.split("&").length != ageTotal){
	        		return;
	        	}
	            p++;
	            $(".page").hide();
	            $(".page").eq(p).show();
	        });
				
			tag.find(".seat-send-form").submit(function(e){
	        	e.preventDefault();
	        	
	        	if(seatTotal==null ||seatTotal.split("&").length != ageTotal){
	        		alert("인원수를 정확히 선택하세요!");
	        		return;
	        	}
	        	
	        	var seatData = $(".result").text();
				TempReservation(seatTotal,reservationKey,scheduleTimeNo,ageNormal,ageYoung,ageOld);
	        });
			
			for(var i=0 ; i<resp.length ; i++){
				var addDiv = $("<div>").addClass("cinema-seat").attr("data-row", resp[i].seatRows).attr("data-col",resp[i].seatCols)
				.attr("data-state",resp[i].seatStatus).attr("data-direction","up");
				$("<input type='checkbox' name='seat' class='chk-seat' value='"+resp[i].seatRows+"-"+resp[i].seatCols+"' style='display: none;'>").appendTo(addDiv);
				var spanTemplate = $("#span-template").html();
				spanTemplate = spanTemplate.replace("{{row}}",resp[i].seatRows);
				spanTemplate = spanTemplate.replace("{{col}}",resp[i].seatCols);
				addDiv.append(spanTemplate);
				
				
				tag.find(".cinema-seat-area").append(addDiv);
				
			}
			
			$(".seat-box").removeClass("container-1500").removeClass("container-1330")
			.removeClass("container-1200").removeClass("container-1050").removeClass("container-915")
			.removeClass("container-777").removeClass("container-628").removeClass("container-490")
			.removeClass("container-center");
			
			if(hallCols==10){
				$(".seat-box").addClass("container-1500").addClass("container-center");
			}
			if(hallCols==9){
				$(".seat-box").addClass("container-1330").addClass("container-center");
			}
			if(hallCols==8){
				$(".seat-box").addClass("container-1200").addClass("container-center");
			}
			if(hallCols==7){
				$(".seat-box").addClass("container-1050").addClass("container-center");
			}
			if(hallCols==6){
				$(".seat-box").addClass("container-915").addClass("container-center");
			}
			if(hallCols==5){
				$(".seat-box").addClass("container-777").addClass("container-center");
			}
			if(hallCols==4){
				$(".seat-box").addClass("container-628").addClass("container-center");
			}
			if(hallCols==3){
				$(".seat-box").addClass("container-490").addClass("container-center");
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
			directChecked();
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
			getReservation(reservationKey);
			getReservationDetail(reservationKey);
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
			var date = new Date(scheduleTimeDateTime).toString();
			template = template.replace("{{scheduleTimeDateTime}}",date);
			template = template.replace("{{reservationTotalNumber}}",resp.reservationTotalNumber);
			template = template.replace("{{totalAmount}}",resp.totalAmount);
			
			$("input[name=total-amount]").val(resp.totalAmount);
			$("input[name=result-amount]").val(resp.totalAmount);
			
			$("#pay-result-show").append(template);
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
				template = template.replace("{{reservationDetailPrice}}",resp[i].reservationDetailPrice);
				checkPay=1;
				$("#pay-detail-show").append(template);
			}
		},
		error:function(e){
			console.log("실패", e);
		}
	});
}

function cancelTempReservation(reservationKey){
	$.ajax({
		url:"${pageContext.request.contextPath}/data/cancelTempReservation?"+$.param({"reservationNo":reservationKey}),
		type:"delete",
		dataType:"text",
		success:function(resp){
			console.log("성공", resp);
			console.log("삭제????");
		},
		error:function(e){}
	});
}

});
</script>

<h1> 예매 화면 </h1>

<template id="movie-list-template">
	<div>
		<label>
		<input type="radio" name="movieNo" value="{{value}}" data-name="{{name}}" data-runtime="{{runtime}}" data-hallNo="{{hallNo}}" data-hallType="{{hallType}}" data-scheduleTimeDiscountType="{{scheduleTimeDiscountType}}">
		<span>{{grade}} {{name}}</span>		
		</label>
	</div>	
</template>

<template id="list-template">
	<div>
		<label>
		<span>{{name}}</span>
		<input type="radio" name="{{key}}" value="{{value}}" data-name="{{name}}">
		</label>
	</div>	
</template>

<div class="container-1500 container-center page">

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
					<div class="theater-name-list">영화 또는 지역을 먼저 선택하세요.</div>
				</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>날짜</h2></div>
				<div class="flex-container">
					<div class="schedule-time-date-list">
						영화와 지점을 먼저 선택하세요.
					</div>
				</div>
			
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>시간</h2></div>
				<div class="flex-container">
					<div class="schedule-time-date-time-list">상영 날짜를 선택해주세요.</div>
				</div>
		</div>
		
		<div class="float-item-left">
			<div class="row"><h2>인원 선택</h2></div>
				<div class="flex-container">
					<div class="row">
					    <span>[일반]</span>
					    	<input type="radio" name="ageNormal" id="ageNormal-id" value="0" checked>선택
					    	<input type="radio" name="ageNormal" class="ageNormal" value="1">1명
					    	<input type="radio" name="ageNormal" class="ageNormal" value="2">2명
					    	<input type="radio" name="ageNormal" class="ageNormal" value="3">3명
					    </div>
					 </div>
					<div class="flex-container">    
					    <div class="row">
					    <span>[청소년]</span>
					    	<input type="radio" name="ageYoung" id="ageYoung-id" value="0" checked>선택
					    	<input type="radio" name="ageYoung" class="ageYoung" value="1">1명
					    	<input type="radio" name="ageYoung" class="ageYoung" value="2">2명
					    	<input type="radio" name="ageYoung" class="ageYoung" value="3">3명
					    </div>
					  </div>
					<div class="flex-container">   
					    <div class="row">
					    <span>[경로]</span>
					    	<input type="radio" name="ageOld" id="ageOld-id" value="0" checked>선택
					    	<input type="radio" name="ageOld" class="ageOld" value="1">1명
					    	<input type="radio" name="ageOld" class="ageOld" value="2">2명
					    	<input type="radio" name="ageOld" class="ageOld" value="3">3명
			    		</div>
			    	</div>	
			    	<div class="flex-container">  
					    <div class="row">
					    	<span>총 인원</span><input type="number" name="ageTotal" class="ageTotal" value="0" readonly> 
					    </div>	
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

			<div id="cinema" class="cinema-wrap" data-name="seat">
				<div class="cinema-screen"><h3>스크린</h3></div>
					
					<div class="cinema-seat-area" data-rowsize="{{hallRows}}" data-colsize="{{hallCols}}" data-rowname="number" data-colname="number" data-mode="client" data-fill="manual" data-seatno="visible" data-choice="multiple">
						
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

        <div id="seat-send-result"></div>

	
	<div class="row center">
		<button class="btn-prev btn-seat-cancel"><h1>다시 선택하기</h1></button>
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
	<hr>
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
			<span>{{reservationDetailPrice}}</span>
		</div>
	</div>
</template>	
	
	<h1>결제 내역 확인</h1>
	<hr>
	<div id="pay-result-show"></div>
	
	<hr>
	
	<h1>결제 상세 내역 확인</h1>
	<div id="pay-detail-show"></div>
	
	<hr>
	
	<h1>포인트 사용</h1>
	
	<hr>
	
	<div class="row">
		<label>내 현재 포인트</label>
		<span>${memberPoint } 점</span>
	</div>
	
	<div class="row">
		<label>포인트 사용하기</label>
		<input type="number" name="memberPoint" min="1000" value="0" step="100">
	</div>
	
	<div class="row">
		<button class="btn-use-point">포인트 사용</button>
		<button class="btn-init-point">포인트 다시 선택</button>
	</div>
	
	<div class="row">
		<label>최종 결제 금액</label>
		총 금액  :<input type="text" name="total-amount" readonly> -
		포인트 사용 금액  :<input type="text" name="use-amount" value="0" readonly> =
		최종 결제 금액  :<input type="text" name="result-amount" value="0" readonly>
	</div>
	
	<div class="row center">
		<button class="btn-pay-confirm"><h1>결제 진행(카카오 페이)</h1></button>
	</div>
	
	
	<div class="row center">
		<button class="btn-prev btn-pay-cancel"><h1>이전 단계</h1></button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>