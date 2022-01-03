<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

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
			url:"${pageContext.request.contextPath}/data/countByGenderForMovie",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw1("#countByGenderForMovie", resp);
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
			url:"${pageContext.request.contextPath}/data/countByAgeForTotal",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw1("#countByAgeForTotal", resp);
			},
			error:function(e){}
		});
		
		$.ajax({
			url:"${pageContext.request.contextPath}/data/countByAgeForMoive",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				draw1("#countByAgeForMoive", resp);
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


<h1> 통계 페이지 </h1>






<h1>영화 예매율(예약 건임) 순위</h1> =>통계 view
<canvas id="totalReservation" width="400" height="400"></canvas>

<h1>영화 관람객별 순위</h1> => last info view로 해결
<canvas id="totalPeople" width="400" height="400"></canvas>

<h1>영화 별 매출 순위</h1> => last info view로 해결
<canvas id="totalProfit" width="400" height="400"></canvas>

<h1>전체 영화 성별 예매 순위</h1>
<canvas id="countByGenderForTotal" width="400" height="400"></canvas>

<h1>영화별 성별 예매 순위</h1> =>통계 view
!!현재 movie_no=3을 넣었고 추후에 영화 상세페이지를 통해서 movie_no을 넣어준다.
<canvas id="countByGenderForMovie" width="400" height="400"></canvas>



<h1>영화별 연령 분포</h1> =>통계 view
<canvas id="countByAgeForTotal" width="400" height="400"></canvas>

<h1>각 영화 예매별 연령 분포</h1> =>통계 view
<canvas id="countByAgeForMovie" width="400" height="400"></canvas>


<h1>영화 평점별 순위</h1> =>통계 view

<h1>지점별 예매율(판매율) 순위</h1> =>통계 view


<h1>지점별 영화 매출 현황</h1> => last info view로 해결


<h1>지점별 관람객 현황</h1> => => last info view로 해결


<h1>회원관리</h1>
<h1>등급별 분포도</h1>
<h1>등급별 예매율</h1>
<h1>등급별 포인트 비율</h1>

<h1>한 회원에 대한 통계(예매 년도 등)</h1>


<h1>월별/연도별 가입자 수 통계</h1>





<h1>지점별 스낵 매출 현황</h1>

<h1>지점별 예매 연령층</h1>
<h1>지점별 스낵 구매 연령층</h1>



<h1>매진율(극장 지점별 / 영화별)</h1>

<h1>영화 시/도 별 관람객</h1>

<h1>상영 기간별</h1>
<h1>해외영화 국내 영화 / 영화 관람등급별 / 장르별</h1>
<h1>시간별 영화 순위(조조/심야/일반 등)</h1>
<h1>요일별 / 주말별 영화 관람 추이</h1>

방문자 통계는 세션으로?로그인시 확인해야하는건지?
<h1>사이트 방문자 통계(1일 / 7일 / 30일)</h1>
<h1>일별 박스 오피스</h1>

<h1>상영관 종류(IMAX) 등등에 따른 회원들 선호도</h1>

<h1>지점별 스낵 매출 현황</h1>







<h2>매출액과 총 관람객은 상영회차의 컬럼을 통해서 해결</h2>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>