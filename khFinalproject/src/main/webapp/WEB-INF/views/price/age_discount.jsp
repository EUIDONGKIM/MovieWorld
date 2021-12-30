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
			url:"${root}/price/getAgeDiscountList",
			type:"get",
			dataType:"json",
			success:function(resp){
				
				$(".age-discount").find("tbody").empty();//내부영역 청소
				
				for(var i=0; i < resp.length; i++){
					var template = $("#ageDiscount-template").html();
					
					template = template.replace("{{ageName}}", resp[i].ageName);
					template = template.replace("{{ageDiscountPrice}}", resp[i].ageDiscountPrice);
					template = template.replace("{{ageNo}}",resp[i].ageNo);
					template = template.replace("{{ageNo}}",resp[i].ageNo);
					
// 					버튼에 onclick을 작성할 경우
// 					$("#result").append(template);
					
// 					버튼에 class와 data-exam-id를 두고 이벤트를 jquery에서 부여하는 경우
					var tag = $(template);//template은 글자니까 jQuery로 감싸서 생성을 시키고
					tag.find(".remove-btn").click(function(){//tag에서 .remove-btn을 찾아서 클릭 이벤트 지정하고
						deleteAgeDiscount($(this).data("age-no"));
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
	}
	
	function deleteAgeDiscount(ageNoValue){
		$.ajax({
			url:"${root}/price/deleteAgeDiscount?"+$.param({"ageNo":ageNoValue}),
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

<template id="ageDiscount-template">
	<tr>
		<td>{{ageName}}</td>
		<td>{{ageDiscountPrice}}</td>
		<td>
			<button class="edit-btn" data-age-no="{{ageNo}}">수정</button>
			<button class="remove-btn" data-age-no="{{ageNo}}">삭제</button>
		</td>
	<tr>
</template>

<h1>연령대별 할인 금액 관리</h1>
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