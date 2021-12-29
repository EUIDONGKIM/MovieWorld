<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		loadList();		
	});
		
	function loadList(){
		
		$.ajax({
			url:"${root}/price/getHallTypePriceList",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				//resp에 들어있는 데이터들을 #examdto-template에 넣어서 추가
				
				$("#result").empty();//내부영역 청소
				//$("#result").html("");
				//$("#result").text("");
				
				for(var i=0; i < resp.length; i++){
					var template = $("#hallTypePriceDto-template").html();
					
					template = template.replace("{{hallType}}", resp[i].hallType);
					template = template.replace("{{hallPrice}}", resp[i].hallPrice);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
					});
					tag.find(".edit-btn").click(function(){
					});
					$(".hall-type-price").find("tbody").append(tag);//추가!
				}
			},
			error:function(e){
				console.log(e);
			}
		});
		$.ajax({
			url:"${root}/price/getAgeDiscountList",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				//resp에 들어있는 데이터들을 #examdto-template에 넣어서 추가
				
				$("#result").empty();//내부영역 청소
				//$("#result").html("");
				//$("#result").text("");
				
				for(var i=0; i < resp.length; i++){
					var template = $("#ageDiscount-template").html();
					
					template = template.replace("{{ageName}}", resp[i].ageName);
					template = template.replace("{{ageDiscountPrice}}", resp[i].ageDiscountPrice);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
					});
					tag.find(".edit-btn").click(function(){
					});
					$(".age-discount").find("tbody").append(tag);//추가!
				}
			},
			error:function(e){
				console.log(e);
			}
		});
		$.ajax({
			url:"${root}/price/getScheduleTimeDiscountList",
			type:"get",
			//data:{},
			dataType:"json",
			success:function(resp){
				//resp에 들어있는 데이터들을 #examdto-template에 넣어서 추가
				
				$("#result").empty();//내부영역 청소
				//$("#result").html("");
				//$("#result").text("");
				
				for(var i=0; i < resp.length; i++){
					var template = $("#scheduleTimeDiscount-template").html();
					
					template = template.replace("{{scheduleTimeDiscountType}}", resp[i].scheduleTimeDiscountType);
					template = template.replace("{{scheduleTimeDiscountPrice}}", resp[i].scheduleTimeDiscountPrice);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
					});
					tag.find(".edit-btn").click(function(){
					});
					$(".schedule-time-discount").find("tbody").append(tag);//추가!
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	

		
		
		
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<template id="hallTypePriceDto-template">
	<tr>
		<td>{{hallType}}</td>
		<td>{{hallPrice}}</td>
		<td>
			<button class="edit-btn" data-exam-id="{{hallTypeNo}}">수정</button>
			<button class="remove-btn" data-exam-id="{{hallTypeNo}}">삭제</button>
		</td>
	<tr>
</template>
<template id="scheduleTimeDiscount-template">
	<tr>
		<td>{{scheduleTimeDiscountType}}</td>
		<td>{{scheduleTimeDiscountPrice}}</td>
		<td>
			<button class="edit-btn" data-exam-id="{{scheduleTimeDiscountNo}}">수정</button>
			<button class="remove-btn" data-exam-id="{{scheduleTimeDiscountNo}}">삭제</button>
		</td>
	<tr>
</template>
<template id="ageDiscount-template">
	<tr>
		<td>{{ageName}}</td>
		<td>{{ageDiscountPrice}}</td>
		<td>
			<button class="edit-btn" data-exam-id="{{ageNo}}">수정</button>
			<button class="remove-btn" data-exam-id="{{ageNo}}">삭제</button>
		</td>
	<tr>
</template>

<h1>상영관 금액 <button type="button">추가</button></h1>

<table class="hall-type-price table table-border table-hover">
	<thead>
		<tr>
			<th>상영관 종류</th>
			<th>금액</th>
			<th>메뉴</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<hr>
<h1>상영시간별 할인금액 <button type="button">추가</button></h1>
<table class="schedule-time-discount table table-border table-hover">
	<thead>
		<tr>
			<th>상영시간</th>
			<th>할인금액</th>
			<th>메뉴</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<hr>
<h1>연령대별 할인금액 <button type="button">추가</button></h1>
<table class="age-discount table table-border table-hover">
	<thead>
		<tr>
			<th>구분</th>
			<th>할인금액</th>
			<th>메뉴</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>