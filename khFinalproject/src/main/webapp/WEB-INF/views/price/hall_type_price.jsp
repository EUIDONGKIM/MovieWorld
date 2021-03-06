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
			url:"${root}/price/insertHallTypePrice",
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
			url:"${root}/price/getHallTypePriceList",
			type:"get",
			dataType:"json",
			success:function(resp){
				
				$("#result").empty();//내부영역 청소
				
				for(var i=0; i < resp.length; i++){
					var template = $("#hallTypePriceDto-template").html();
					
					template = template.replace("{{hallType}}", resp[i].hallType);
					template = template.replace("{{hallPrice}}", resp[i].hallPrice);
					template = template.replace("{{hallTypeNo}}",resp[i].hallTypeNo);
					template = template.replace("{{hallTypeNo}}",resp[i].hallTypeNo);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
						deleteHallTypePrice($(this).data("hall-type-no"));
					});
					tag.find(".edit-btn").click(function(){
						var hallTypeNo = $(this).data("hall-type-no");
						var hallType = $(this).parent().prev().prev().find(".hall-type").text();
						var hallPrice = $(this).parent().prev().find(".hall-price").text();
						
						var form = $("<form id='edit-form'>");
						form.append("<input type='hidden' name='hallTypeNo' value='"+hallTypeNo+"'>");
						form.append("<div class='cell col-5'><input type='text' class='form-control' name='hallType' value='"+hallType+"'></div>");
						form.append("<div class='cell col-5'><input type='text' class='form-control' name='hallPrice' value='"+hallPrice+"'></div>");
						form.append("<div class='cell col-2 center'><button type='submit' class='btn btn-primary'>수정</button><button type='button' class='btn btn-outline-primary edit-cancel-btn'>취소</button></div>");
						form.append("</form>");
						
						form.find(".edit-cancel-btn").click(function(){
							loadList();							
						});

						form.submit(function(e){
							e.preventDefault();

							var hallTypeNoValue = $("input[name=hallTypeNo]").val();
							var hallTypeValue = $("input[name=hallType]").val();
							var hallPriceValue = $("input[name=hallPrice]").val();
							
							editHallTypePrice(hallTypeNoValue, hallTypeValue, hallPriceValue)
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
	
	function deleteHallTypePrice(hallTypeNoValue){
		$.ajax({
			url:"${root}/price/deleteHallTypePrice?"+$.param({"hallTypeNo":hallTypeNoValue}),
			type:"delete",
			dataType:"text",
			success:function(resp){
				console.log("삭제 성공", resp);
				
				loadList();//데이터가 변하면 무조건 갱신
			},
			error:function(e){}
		});
	}
	
	function editHallTypePrice(hallTypeNoValue, hallTypeValue, hallPriceValue){
		
		$.ajax({
			url:"${root}/price/editHallTypePrice",
			type:"post",
			data : {
				hallTypeNo : hallTypeNoValue,
				hallType : hallTypeValue,
				hallPrice : hallPriceValue
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

<template id="hallTypePriceDto-template">
	<div class="item row">
		<div class="cell col-5"><span class="hall-type">{{hallType}}</span></div>
		<div class="cell col-5"><span class="hall-price">{{hallPrice}}</span></div>
		<div class="cell col-2 center">
			<button class="btn btn-primary edit-btn" data-hall-type-no="{{hallTypeNo}}">수정</button>
			<button class="btn btn-outline-primary remove-btn" data-hall-type-no="{{hallTypeNo}}">삭제</button>
		</div>
	</div>
</template>

<div class="container">
	<div class="row">
		<div class="col">
			<h1>상영관 종류별 금액 관리<button type="button" class="btn btn-primary add-btn">추가</button></h1>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="cell col-5"><strong>상영관 종류</strong></div>
		<div class="cell col-5"><strong>기본 금액</strong></div>
		<div class="cell col-2 center"><strong>관리</strong></div>
	</div>
</div>

<div id="result" class="container">
</div>

<form id="insert-form">
<div id="insert" class="container">
	<div class="row">
		<div class="cell col-5"><input type="text" class="form-control" name="hallType" placeholder="상영관 종류"></div>
		<div class="cell col-5"><input type="text" class="form-control" name="hallPrice" placeholder="기본 금액"></div>
		<div class="cell col-2 center">
			<button type="submit" class="btn btn-primary">등록</button>
			<button type="button" class="btn btn-outline-primary add-cancel-btn">취소</button>
		</div>
	</div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>