<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<style>
canvas{ 
width: 900px !important; 
height: 900px !important; 
} 
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>

	$(function(){
		//시작하자마자 통계자료를 불러와서 화면에 출력
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalReservation",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw("#totalReservation", resp);
			},
			error:function(e){}
		});
		
	});

	$(function(){
		//시작하자마자 통계자료를 불러와서 화면에 출력
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalPeople",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw("#totalPeople", resp);
			},
			error:function(e){}
		});
		
	});
	
	$(function(){
		//시작하자마자 통계자료를 불러와서 화면에 출력
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalProfit",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw("#totalProfit", resp);
			},
			error:function(e){}
		});
		
	});
	

	
	$(function(){
		//시작하자마자 통계자료를 불러와서 화면에 출력
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByGenderForTotal",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw1("#countByGenderForTotal", resp);
			},
			error:function(e){}
		});
		
	});
	
	$(function(){
		//시작하자마자 통계자료를 불러와서 화면에 출력
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalReservationByTheater",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#totalReservationByTheater", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalProfitByTheater",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#totalProfitByTheater", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/totalPeopleByTheater",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#totalPeopleByTheater", resp);
			},
			error:function(e){}
		});
	});
	
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByAgeForTotal",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countByAgeForTotal", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByGradeTotal",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countByGradeTotal", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByGradeReservation",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countByGradeReservation", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByGradePoint",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countByGradePoint", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countMemberjoinByYear",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countMemberjoinByYear", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countMemberjoinByYearMonth",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countMemberjoinByYearMonth", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countPeopleBySido",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countPeoPleBySido", resp);
			},
			error:function(e){}
		});
	});
	
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countReservationBySido",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw2("#countReservationBySido", resp);
			},
			error:function(e){}
		});
	});
	
	function draw(selector, data){//select = 선택자 , data = JSON(ChartTotalVO)
		//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
		var ctx = $(selector)[0].getContext("2d");
	
		var textArray = [];//text만 모아둘 배열
		var countArray = [];//count만 모아둘 배열
		
		for(var i=0; i < data.dataset.length; i++){
			textArray.push(data.dataset[i].text);
			countArray.push(data.dataset[i].count);
		}
	
	
		//var myChart = new Chart(펜객체, 차트옵션);
		var myChart = new Chart(ctx, {
		    type: 'line', //차트의 유형
		    data: { //차트 데이터
		    	
		    	//하단 제목
		        labels: textArray,
		        datasets: [{
		            label: data.label,//차트 범례
		            data: countArray,//실 데이터(하단 제목과 개수가 일치하도록 구성)
		            backgroundColor: 'rgb(255, 99, 132)',
		            borderColor: 'rgb(255, 99, 132)',
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
	
	function draw1(selector, data){//select = 선택자 , data = JSON(ChartTotalVO)
		//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
		var ctx = $(selector)[0].getContext("2d");
	
		var textArray = [];//text만 모아둘 배열
		var countArray = [];//count만 모아둘 배열
		
		for(var i=0; i < data.dataset.length; i++){
			textArray.push(data.dataset[i].text);
			countArray.push(data.dataset[i].count);
		}
	
	
		//var myChart = new Chart(펜객체, 차트옵션);
		var myChart = new Chart(ctx, {
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
	
	function draw2(selector, data){//select = 선택자 , data = JSON(ChartTotalVO)
		//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
		var ctx = $(selector)[0].getContext("2d");
	
		var textArray = [];//text만 모아둘 배열
		var countArray = [];//count만 모아둘 배열
		
		for(var i=0; i < data.dataset.length; i++){
			textArray.push(data.dataset[i].text);
			countArray.push(data.dataset[i].count);
		}
	
	
		//var myChart = new Chart(펜객체, 차트옵션);
		var myChart = new Chart(ctx, {
		    type: 'bar', //차트의 유형
		    data: { //차트 데이터
		    	
		    	//하단 제목
		        labels: textArray,
		        datasets: [{
		            label: data.label,//차트 범례
		            data: countArray,//실 데이터(하단 제목과 개수가 일치하도록 구성)
		            backgroundColor: 'rgb(255, 99, 132)',
		            borderColor: 'rgb(255, 99, 132)',
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
</script>



<div class="container-1200 container-center">
	<div class="row center">
		<h1> 통계 페이지 </h1>
	</div>
	<div class="row ">
			<h1>[영화별 예매율 순위]</h1>
			<canvas id="totalReservation" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
			<h1>[영화별 관람객별 순위]</h1>
			<canvas id="totalPeople" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
			<h1>[영화별 매출 순위]</h1>
			<canvas id="totalProfit" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[전체 영화별 성별 예매 순위]</h1>
		<canvas id="countByGenderForTotal" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[전체 영화별 연령 분포]</h1>
		<canvas id="countByAgeForTotal" width="400" height="400"></canvas>
	</div>
	<hr>
	<hr>
	<div class="row">
		<h1>[지점별 예매율(판매율) 순위]</h1>
		<canvas id="totalReservationByTheater" width="400" height="400"></canvas>
	</div>

	<div class="row">
		<h1>[지점별 영화 매출 현황]</h1>
		<canvas id="totalProfitByTheater" width="400" height="400"></canvas>
	</div>
	<hr>
	<hr>
	<div class="row">
		<h1>✿ 회원관리 ✿</h1>
	</div>
	
	<div class="row">
		<h1>[등급별 분포도]</h1>
		<canvas id="countByGradeTotal" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[등급별 예매율]</h1>
		<canvas id="countByGradeReservation" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[등급별 포인트 비율]</h1>
		<canvas id="countByGradePoint" width="400" height="400"></canvas>
	</div>
	<hr>
	<hr>
	<div class="row">
		<h1>[연도별 가입자 수 통계]</h1>
		<canvas id="countMemberjoinByYear" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[연도별 월별 가입자 수 통계]</h1>
		<canvas id="countMemberjoinByYearMonth" width="400" height="400"></canvas>
	</div>
	<hr>
	<hr>
	<div class="row">
		<h1>[영화 시도 별 예매순]</h1>
		<canvas id="countReservationBySido" width="400" height="400"></canvas>
	</div>
	
	<div class="row">
		<h1>[영화 시도 별 관람객]</h1>
		<canvas id="countPeoPleBySido" width="400" height="400"></canvas>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>