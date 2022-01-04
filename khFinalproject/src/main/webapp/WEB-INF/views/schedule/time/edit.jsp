<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		var hallFirst = ${lastInfoViewDto.hallNo };
		var scheduleTimeDiscountPriceFirst = ${lastInfoViewDto.scheduleTimeDiscountPrice };
		
        $("select[name=scheduleTimeDiscountPrice]").change(function(){
        	$("#send-type-hidden").empty();
        	var type = $(this).find("option:selected").data("type");
        	var template = $("#template-type-hidden").html();
     	   
        	template = template.replace("{{type}}",type);
     	   
        	$("#send-type-hidden").append(template);
        })
        
        $(".hall-select").each(function(){
        	if($(this).val() == hallFirst){
        		$(this).prop("selected",true);
        	}
        });
        
        $(".price-select").each(function(){
        	if($(this).val() == scheduleTimeDiscountPriceFirst){
        		$(this).prop("selected",true);
        		
	        	$("#send-type-hidden").empty();
	        	var type = $("select[name=scheduleTimeDiscountPrice]").find("option:selected").data("type");
	        	var template = $("#template-type-hidden").html();
	     	   
	        	template = template.replace("{{type}}",type);
	     	   
	        	$("#send-type-hidden").append(template);
	        	
        	}
        	
        });
        
//         $("input[namescheduleTimeDateTime]").on("input",function(){
//         	console.log("데이트 값",$(this).val());
//         });
        
	});
</script>

<template id="template-type-hidden">
	<input type="hidden" name="scheduleTimeDiscountType" value="{{type}}">
</template>

<h1> 상영 영화 생성 </h1>
<h2>영화명 :${lastInfoViewDto.movieTitle }</h2>
<h2>극장명 :${lastInfoViewDto.theaterName } </h2>
<h2>상영 시작일 :${lastInfoViewDto.scheduleStart } </h2>
<h2>상영 종료일 :${lastInfoViewDto.scheduleEnd } </h2>
<form method="post">
	<input type="hidden" name="scheduleTimeNo" value="${lastInfoViewDto.scheduleTimeNo }">
	
	<div class="row">
		<label>상영관 선택</label>
		<select name="hallNo" required>
			<option value="">상영관 선택</option>
				<c:forEach var="hallDto" items="${hallList}">
					<option class="hall-select" value="${hallDto.hallNo}">${hallDto.hallName} / ${hallDto.hallType}</option>
				</c:forEach>
		</select>
	</div>
	
 	<div class="row">
		<label>상영일/시간 선택</label>
		<input type="datetime-local" name="scheduleTimeDateTime" value="${lastInfoViewDto.getDateToString() }"
		min="${lastInfoViewDto.getNowDateToString() }" max="${lastInfoViewDto.getEndDateToString()}"
		pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}" required>
	</div>
	
	
	<div class="row">
		<label>상영 구분</label>
		<select name="scheduleTimeDiscountPrice" required>
					<option value="">상영 구분 선택</option>
				<c:forEach var="scheduleTimeDiscountDto" items="${scheduleTimeDiscountList}">
					<option class="price-select" value="${scheduleTimeDiscountDto.scheduleTimeDiscountPrice}" data-type="${scheduleTimeDiscountDto.scheduleTimeDiscountType}">
					${scheduleTimeDiscountDto.scheduleTimeDiscountType}
					</option>
				</c:forEach>
		</select>
	</div>
	
	<div id="send-type-hidden"></div>
	
	<button type="submit">상영 수정</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>