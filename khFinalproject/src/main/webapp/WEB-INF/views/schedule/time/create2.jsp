<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		var hallNo;
		var scheduleTimeDateTime;
        $("select[name=scheduleTimeDiscountPrice]").change(function(){
        	$("#send-type-hidden").empty();
        	var type = $(this).find("option:selected").data("type");
        	var template = $("#template-type-hidden").html();
     	   
        	template = template.replace("{{type}}",type);
     	   
        	$("#send-type-hidden").append(template);
        })
        
        $("select[name=hallNo]").change(function(){
        	hallNo = $(this).val();
        });
        $("input[name=scheduleTimeDateTime]").on("input",function(){
        	var scheduleNo = '${totalInfoViewDto.scheduleNo }';
        	scheduleTimeDateTime = $(this).val();
        	var day = scheduleTimeDateTime.substring(0,10);
        	console.log(day);
        	var time = scheduleTimeDateTime.substring(11,16);
        	console.log(time);
        	var scheduleTimefirst = day + " " + time + ":00";
        	console.log(scheduleTimefirst);
        	
        	checkSameTime(hallNo,scheduleTimefirst);
        });
        function checkSameTime(hallNo,scheduleTimefirst){
        	$.ajax({
				url:"${pageContext.request.contextPath}/admin/checkSameTime",
				type:"get",
				data:{
					hallNo:hallNo,
					scheduleTimefirst:scheduleTimefirst
					},
				dataType:"text",
				success:function(resp){
					if(resp=='NNNNN'){
						console.log(resp);					
						alert("해당 상영관에 상영하는 영화가 있습니다. 다른 시간을 선택하세요.");
						$("input[name=scheduleTimeDateTime]").val("");
						return;
					}
					else{
						console.log("성공", resp);
					}
				},
				error:function(e){
					console.log("실패",e);
				}
			});
        }
        
    	$(".cancel-btn").click(function(e){
    		e.preventDefault();
    		self.location = "${root}/theater/detail?theaterNo=${totalInfoViewDto.theaterNo}";
    	});
        
	});
</script>

<template id="template-type-hidden">
	<input type="hidden" name="scheduleTimeDiscountType" value="{{type}}">
</template>

<div class="container-600 mx-auto">
	<div class="row my-3">
		<h1>${totalInfoViewDto.theaterName}점 상영 영화 생성 </h1>
	</div>
	
	<div class="row">
		<label class="form-label">영화명</label>
		<input class="form-control" type="text" value="${totalInfoViewDto.movieTitle}" readonly>
	</div>

	<div class="row">
		<label class="form-label">상영 시작일</label>
		<input class="form-control" type="text" value="${totalInfoViewDto.scheduleStart}" readonly>
	</div>
	
	<div class="row">
		<label class="form-label">상영 종료일</label>
		<input class="form-control" type="text" value="${totalInfoViewDto.scheduleEnd}" readonly>
	</div>

	<form method="post">
	<div class="row">
		<div class="col">
			<input type="hidden" name="scheduleNo" value="${totalInfoViewDto.scheduleNo }">
		</div>
	</div>
	
	<div class="row">
		<label class="form-label">상영관 선택</label>
		<select class="form-select" name="hallNo" required  class="form-control">
			<option value="">상영관 선택</option>
				<c:forEach var="hallDto" items="${hallList}">
					<option value="${hallDto.hallNo}">${hallDto.hallName} / ${hallDto.hallType}</option>
				</c:forEach>
		</select>
	</div>
	
	<div class="row">
		<label class="form-label">상영일/시간 선택</label>
		<input type="datetime-local" name="scheduleTimeDateTime"  min="${totalInfoViewDto.getNowDateToString() }" max="${totalInfoViewDto.getEndDateToString()}"
				pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}" required class="form-control" >
	</div>
	
	<div class="row">
		<label class="form-label">상영 구분</label>
			<select name="scheduleTimeDiscountPrice" required class="form-select">
						<option value="">상영 구분 선택</option>
					<c:forEach var="scheduleTimeDiscountDto" items="${scheduleTimeDiscountList}">
						<option value="${scheduleTimeDiscountDto.scheduleTimeDiscountPrice}" data-type="${scheduleTimeDiscountDto.scheduleTimeDiscountType}">
						${scheduleTimeDiscountDto.scheduleTimeDiscountType}
						</option>
					</c:forEach>
			</select>
	</div>
	
	<div id="send-type-hidden"></div>
	
	<button type="submit" class="btn btn-primary">상영 생성</button>
	<button type="button" class="cancel-btn btn btn-outline-primary">취소</button>
	</form>
</div>


	

	
 

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>