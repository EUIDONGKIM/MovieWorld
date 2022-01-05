<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.19/cinema/hacademy-cinema.css">
<style>
    *{
        box-sizing: border-box;
    }
    .float-box > div{
        float:left;
        width:50%;
    }
    .float-box::after{
        content:"";
        display: block;
        clear:both;
    }
    .float-box > .result {
        padding:0.5rem;
    }
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.19/cinema/hacademy-cinema.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
        var cinema = new Hacademy.Reservation("#cinema");
        cinema.addBeforeChangeListener(function(seat){
        });
        cinema.addChangeListener(function(seat){
            //this == cinema 앱
        });
        
	});
</script>

<h1>상영관 정보(좌석 클릭 막아야함)</h1>
<h2><a href="${root}/theater/detail?theaterNo=${theaterDto.theaterNo}">${theaterDto.theaterName}</a>점 ${hallDto.getFullName()}</h2>
<h2>이용 가능한 좌석 수 : ${hallDto.hallSeat}</h2>

    <div class="float-box">
        <div>
			<div id="cinema" class="cinema-wrap" data-name="seat">
			<div class="cinema-screen">스크린</div>
			    <div class="cinema-seat-area" data-rowsize="${hallDto.hallRows}" data-colsize="${hallDto.hallCols}" data-rowname="number" data-colname="number" data-mode="client" data-fill="manual" data-seatno="visible" data-choice="multiple">
			    <c:forEach var="seatDto" items="${seatList}">
			        <div class="cinema-seat" data-row="${seatDto.seatRows}" data-col="${seatDto.seatCols}" data-state="${seatDto.seatStatus}"></div>
			    </c:forEach>
			    </div>
			</div>
        </div>
    </div>
    
    <button type="submit">수정</button>
    <button type="submit">삭제</button>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
