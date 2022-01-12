<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<style>
	.cell { 
		display:table-cell; 
		border-bottom:1px solid #DDD; 
		border-top:1px solid #DDD; 
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
	loadList();
	
	$("#insert").hide();
	
	$(".add-btn").click(function(){
		$("#insert").show();
	});
	$(".add-cancel-btn").click(function(){
		$("#insert").hide();
	});
	
	//#insert-form이 전송되면 전송 못하게 막고 ajax로 insert
	$("#insert-form").submit(function(e){
		//this == #insert-form
		e.preventDefault();
		
		var dataValue = $(this).serialize();
		
		$.ajax({
			url:"${root}/price/insertScheduleTimeDiscount",
			type:"post",
			data : dataValue,
			//dataType 없음
			success:function(resp){
				console.log("추가 성공", resp);
				
				//주의 : this 는 form이 아니다(this는 함수를 기준으로 계산)
				//jQuery는 reset() 명령이 없어서 get(0)으로 javascript 객체로 변경
				//$("#insert-form").get(0).reset();
				$("#insert-form")[0].reset();
				
				//성공하면 목록 갱신
				$("#insert").hide();
				loadList();
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	});
	


});
		
	function loadList(){
		$.ajax({
			url:"${root}/price/getScheduleTimeDiscountList",
			type:"get",
			dataType:"json",
			success:function(resp){
				
				$("#result").empty();//내부영역 청소
				
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
						var scheduleTimeDiscountNo = $(this).data("schedule-time-discount-no");
						var scheduleTimeDiscountType = $(this).parent().prev().prev().find(".schedule-time-discount-type").text();
						var scheduleTimeDiscountPrice = $(this).parent().prev().find(".schedule-time-discount-price").text();
						
						var form = $("<form id='edit-form'>");
						form.append("<input type='hidden' name='scheduleTimeDiscountNo' value='"+scheduleTimeDiscountNo+"'>");
						form.append("<div class='cell col-5'><input type='text' class='form-control' name='scheduleTimeDiscountType' value='"+scheduleTimeDiscountType+"'></div>");
						form.append("<div class='cell col-5'><input type='text' class='form-control' name='scheduleTimeDiscountPrice' value='"+scheduleTimeDiscountPrice+"'></div>");
						form.append("<div class='cell col-2 center'><button type='submit' class='btn btn-primary'>수정</button><button type='button' class='btn btn-outline-primary edit-cancel-btn'>취소</button></div>");
						form.append("</form>");
						
						form.find(".edit-cancel-btn").click(function(){
							loadList();							
						});
						
						form.submit(function(e){
							e.preventDefault();

							var scheduleTimeDiscountNoValue = $("input[name=scheduleTimeDiscountNo]").val();
							var scheduleTimeDiscountTypeValue = $("input[name=scheduleTimeDiscountType]").val();
							var scheduleTimeDiscountPriceValue = $("input[name=scheduleTimeDiscountPrice]").val();
							
							editScheduleTimeDiscount(scheduleTimeDiscountNoValue, scheduleTimeDiscountTypeValue, scheduleTimeDiscountPriceValue);
						});
						
						var div = $(this).parent().parent();
						div.html(form);
					});
					$("#result").append(tag);//추가!
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
	
	function editScheduleTimeDiscount(scheduleTimeDiscountNoValue, scheduleTimeDiscountTypeValue, scheduleTimeDiscountPriceValue){
		
		$.ajax({
			url:"${root}/price/editScheduleTimeDiscount",
			type:"post",
			data : {
				scheduleTimeDiscountNo : scheduleTimeDiscountNoValue,
				scheduleTimeDiscountType : scheduleTimeDiscountTypeValue,
				scheduleTimeDiscountPrice : scheduleTimeDiscountPriceValue
			},
			//dataType 없음
			success:function(resp){
				console.log("수정 성공", resp);
				
				//성공하면 목록 갱신
				loadList();
			},
			error:function(e){
				console.log("수정 실패", e);
			}
		});
	}
	
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<template id="scheduleTimeDiscount-template">
	<div class="item row">
		<div class="cell col-5"><span class="schedule-time-discount-type">{{scheduleTimeDiscountType}}</span></div>
		<div class="cell col-5"><span class="schedule-time-discount-price">{{scheduleTimeDiscountPrice}}</span></div>
		<div class="cell col-2 center">
			<button class="btn btn-primary edit-btn" data-schedule-time-discount-no="{{scheduleTimeDiscountNo}}">수정</button>
			<button class="btn btn-outline-primary remove-btn" data-schedule-time-discount-no="{{scheduleTimeDiscountNo}}">삭제</button>
		</div>
	</div>
</template>


<div class="container">
	<div class="row">
		<div class="col">
			<h1>상영시간대별 할인 금액 관리<button type="button" class="btn btn-primary add-btn">추가</button></h1>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="cell col-5"><strong>상영시간</strong></div>
		<div class="cell col-5"><strong>할인 금액</strong></div>
		<div class="cell col-2 center"><strong>관리</strong></div>
	</div>
</div>

<div id="result" class="container">
</div>

<form id="insert-form">
<div id="insert" class="container">
	<div class="row">
		<div class="cell col-5"><input type="text" class="form-control" name="scheduleTimeDiscountType" placeholder="상영시간"></div>
		<div class="cell col-5"><input type="text" class="form-control" name="scheduleTimeDiscountPrice" placeholder="할인 금액"></div>
		<div class="cell col-2 center">
			<button type="submit" class="btn btn-primary">등록</button>
			<button type="button" class="btn btn-outline-primary add-cancel-btn">취소</button>
		</div>
	</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>