<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		$(".city").click(function(){
			var cityValue = $(this).text();
			console.log(cityValue);
			
			$.ajax({
				url:"${pageContext.request.contextPath}/data/getTheaters?city="+cityValue,
				type:"get",
				dataType:"json",
				success:function(resp){
					console.log("성공",resp)
					for(var i = 0 ; i < resp.length ; i++){
						var html = "<h3><a hfer=\"/theater?theaterNo=\""+resp[i].theaterNo+">"+resp[i].theaterName+"</a></h3>" 
						$(".result").append();
					}
				},
				error:function(e){
					console.log("실패",e);
				}
			});
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 목록</h1>

<c:forEach var="theaterCityVO" items="${cityList }">
	<a class="city" data-city="${theaterCityVO.theaterSido}">
		${theaterCityVO.theaterSido}
	</a>
</c:forEach>

<hr>

<div class="result">
	<h3><a hfer="/theater?theaterNo="+resp.theaterNo>resp.theaterName</a></h3>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>