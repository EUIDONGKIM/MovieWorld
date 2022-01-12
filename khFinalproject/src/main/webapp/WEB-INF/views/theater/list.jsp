<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.b {
		border : 1px solid black;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		var deleteResult = "${deleteResult}";
		if(deleteResult){
			alert("삭제가 완료되었습니다.");
		}
		
		$(".city").click(function(){
			
			var cityValue = $(this).text();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/data/getTheaters?city="+cityValue,
				type:"get",
				dataType:"json",
				success:function(resp){
					console.log("성공",resp)
					//$(".result").remove();
					$(".result").empty();
					
					for(var i = 0 ; i < resp.length ; i++){
						//여기 고쳐야함
						var html = 
 						"<div class='col-3 p-1'>"+
							"<a class='btn btn btn-outline-primary w-100' href='detail?theaterNo="+resp[i].theaterNo+"'>"+resp[i].theaterName+"</a>"+
 						"</div>"	
						$(".result").append(html);
					}
					
				},
				error:function(e){
					console.log(" 실패",e);
				}
			});
		});
	});
</script>


<div class="container">
	<div class="row my-3">
		<h1>전체 극장</h1>
	</div>
	
	<hr> 
	
	<div class="row">
		<c:forEach var="theaterCityVO" items="${cityList}">
			 <div class="col-3 p-1">
				<a class="city btn btn btn-outline-primary w-100" role="button" data-city="${theaterCityVO.theaterSido}">${theaterCityVO.theaterSido}</a>
			 </div>
		</c:forEach>
	</div>

	<hr>

	<div class="result row">
	
	</div>
	

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>