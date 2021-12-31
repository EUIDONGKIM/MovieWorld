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
			dataType:"json",
			success:function(resp){
				
				$(".hall-type-price").find("tbody").empty();//내부영역 청소
				
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
					});
					$(".hall-type-price").find("tbody").append(tag);//추가!
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
	
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<template id="hallTypePriceDto-template">
	<tr>
		<td>{{hallType}}</td>
		<td>{{hallPrice}}</td>
		<td>
			<button class="edit-btn" data-hall-type-no="{{hallTypeNo}}">수정</button>
			<button class="remove-btn" data-hall-type-no="{{hallTypeNo}}">삭제</button>
		</td>
	<tr>
</template>

<h1>상영관 종류별 금액 관리</h1>

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
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>