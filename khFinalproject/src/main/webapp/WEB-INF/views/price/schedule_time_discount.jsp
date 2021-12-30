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
			url:"${root}/price/getScheduleTimeDiscountList",
			type:"get",
			dataType:"json",
			success:function(resp){
				
				$(".schedule-time-discount").find("tbody").empty();//내부영역 청소
				
				for(var i=0; i < resp.length; i++){
					var template = $("#scheduleTimeDiscount-template").html();
					
					template = template.replace("{{scheduleTimeDiscountType}}", resp[i].scheduleTimeDiscountType);
					template = template.replace("{{scheduleTimeDiscountPrice}}", resp[i].scheduleTimeDiscountPrice);
					template = template.replace("{{scheduleTimeDiscountNo}}",resp[i].scheduleTimeDiscountNo);
					template = template.replace("{{scheduleTimeDiscountNo}}",resp[i].scheduleTimeDiscountNo);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
						deleteScheduleTimeDiscount($(this).data("schedule-time-discount-no"));
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
	
	function deleteScheduleTimeDiscount(scheduleTimeDiscountNoValue){
		$.ajax({
			url:"${root}/price/deleteScheduleTimeDiscount?"+$.param({"scheduleTimeDiscountNo":scheduleTimeDiscountNoValue}),
			type:"delete",
			dataType:"text",
			success:function(resp){
				console.log("삭제 성공", resp);
				
				loadList();//데이터가 변하면 무조건 갱신
			},
			error:function(e){}
		});
	}
	
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<template id="scheduleTimeDiscount-template">
	<tr>
		<td>{{scheduleTimeDiscountType}}</td>
		<td>{{scheduleTimeDiscountPrice}}</td>
		<td>
			<button class="edit-btn" data-schedule-time-discount-no="{{scheduleTimeDiscountNo}}">수정</button>
			<button class="remove-btn" data-schedule-time-discount-no="{{scheduleTimeDiscountNo}}">삭제</button>
		</td>
	<tr>
</template>

<h1>상영시간대별 할인 금액 관리</h1>
<table class="schedule-time-discount table table-border table-hover">
	<thead>
		<tr>
			<th>상영시간</th>
			<th>할인금액</th>
			<th>메뉴</th>
		</tr>
	</thead>
	<tbody class="result">
	</tbody>
</table>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>