<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.13/cinema/hacademy-cinema.css">
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
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.13/cinema/hacademy-cinema.js"></script>
    <script>
        window.addEventListener("load", function(){
            var cinema = new Hacademy.Reservation("#cinema");
            cinema.addChangeListener(function(seat){
                print(this);
            });
            
            print(cinema);
            
            function print(app){
                document.querySelector(".result").textContent = app.getQueryString();
            }
        });
    </script>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1 align="center">Demo 3 : Client manual mode</h1>
    <ul>
        <li>관리자 모드에서 만들어진 좌석을 표시하고 선택하는 경우</li>
        <li>.cinema-seat-area에 data-mode="client"로 설정하거나 미작성 시 사용자 모드 설정</li>
        <li>.cinema-seat-area에 data-fill="manual"로 설정하여 수동 모드 설정</li>
        <li>좌석번호를 표시하고 싶은 경우 .cinema-seat-area에 data-seatno="visible"로 설정</li>
        <li>좌석에 상태에 맞게 data-state, data-direction 등을 설정해야 함(데이터베이스에 저장된 값을 불러와야함)</li>
        <li>좌석번호는 현재 임의의 수정이 불가</li>
        <li>좌석 열 수를 벗어나는 좌석은 삭제됨</li>
        <li>좌석 칸 수를 벗어나는 좌석은 삭제됨</li>
    </ul>
    <div class="float-box">
        <div>
            <form action="${pageContext.request.contextPath}/test" method="post">

		                <div id="cinema" class="cinema-wrap" data-name="seat">
		                    <div class="cinema-screen">상단 구조물 또는 제목 영역</div>
		    				<div class="cinema-seat-area" data-rowsize="${reservationInfoViewDto.hallRows}" data-colsize="${reservationInfoViewDto.hallCols }" data-mode="client" data-fill="manual"" data-seatno="visible">
						    <c:forEach var="seatDto" items="${seatList}">
						        <div class="cinema-seat" data-row="${seatDto.seatRows }" data-col="${seatDto.seatCols }" data-state="${seatDto.seatStatus }"></div>
						    </c:forEach>
						</div>
                    </div>
                </div>
        
                <input type="submit" value="선택">
            </form> 
        </div>

        <h2 align="center">전송되는 데이터 형태</h2>

        <div class="result">
            
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>