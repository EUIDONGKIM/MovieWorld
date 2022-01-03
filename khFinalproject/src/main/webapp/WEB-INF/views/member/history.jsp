<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		var page = 1;
		var size = 5;
		
		$(".more-btn").click(function(){
			loadData(page, size);
			page++;
		});
		
		//더보기 버튼을 강제 1회 클릭(트리거)
		$(".more-btn").click();
		
		//내부적으로 사용할 함수 (외부에서는 호출 불가)
		function loadData(pageValue, sizeValue){
			$.ajax({
				url:"${pageContext.request.contextPath}/member/historyMore",
				type:"get",
				data:{
					page : pageValue,
					size : sizeValue
				},
				dataType:"json",
				success:function(resp){
					console.log("성공", resp);
					
					//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
					if(resp.length < sizeValue){
						$(".more-btn").remove();
					}
					
				
					//데이터 출력
					
					for(var i=0; i < resp.length; i++){
						var html = "<h2>"+"[시간:]"+resp[i].historyTime+":[적립금]"+resp[i].historyAmount+":[메모]"+resp[i].historyMemo+"</h2>";
						
						$("#result").append(html);
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	});
	
	
</script>
<div class="container-1200 container-center">
	<div class="row center">
	 	<div class="col ">
	 		<h1>사용가능하신 포인트는  ["${point}"] 포인트 입니다</h1>
	 	</div>
	</div>
<!-- 	<table class="table"> -->
<!-- 		<thead> -->
<!-- 			<tr> -->
<!-- 				<td>일시</td> -->
<!-- 				<td>포인트</td> -->
<!-- 				<td>메모</td> -->
<!-- 			</tr> -->
<!-- 		</thead> -->
<%-- 		<c:forEach var="historyDto" items="${list}"> --%>
<!-- 			<tbody> -->
<!-- 				<tr> -->
<%-- 					<td>${historyDto.historyTime}</td> --%>
<%-- 					<td>${historyDto.historyAmount}</td> --%>
<%-- 					<td id="memo">${historyDto.historyMemo}</td> --%>
<!-- 				</tr> -->
<!-- 			</tbody> -->
<%-- 		</c:forEach> --%>
<!-- 	</table> -->
	<div class="row center">
		<div class="fol">
			<div id="result"></div>
		</div>
	</div>
	
	<div class="row center">
		<div class="col">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>