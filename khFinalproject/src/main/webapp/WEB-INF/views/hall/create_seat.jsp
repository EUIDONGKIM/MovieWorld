<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.13/cinema/hacademy-cinema.css"> -->
<!-- 이미지가 안바껴서 강사님 코드 css에 넣어둠 (허락맡아야함) 현재는 테스트 이미지 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/hacademy-cinema.css">
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
    <script src="${pageContext.request.contextPath}/resources/js/hacademy-cinema.js"></script>
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

<h1> 상영관 생성 </h1>
<h1 align="center">Demo 1 : Manager auto mode</h1>
    <ul>
        <li>관리자 모드에서는 최초에 좌석을 생성하기 위한 명령을 지원</li>
        <li>.cinema-seat-area에 data-mode="manager"로 관리자 모드 설정</li>
        <li>좌석을 우클릭하면 시계 방향으로 회전</li>
        <li>좌석을 선택한 후 Delete 키를 누르면 좌석 삭제</li>
        <li>좌석을 선택한 후 F2 키를 누르면 좌석이 사라지고 공간으로 병합됨</li>
        <li>좌석을 선택한 후 F3 키를 누르면 좌석이 선택 불가로 전환됨</li>
        <li>좌석번호를 표시하고 싶은 경우 .cinema-seat-area에 data-seatno="visible"로 설정</li>
    </ul>
    <div class="float-box">
        <div>
            <form action="${pageContext.request.contextPath}/seat/insert" method="post">
                <div id="cinema" class="cinema-wrap" data-name="seat">
            	<div class="cinema-screen">전면스크린</div>
                    <div class="cinema-seat-area" data-rowsize="5" data-colsize="5" data-mode="manager" data-fill="auto" data-seatno="visible"></div>
                    <%-- <div class="cinema-seat-area" data-rowsize="${hallDto.hallRows }" data-colsize="${hallDto.hallCols }" data-mode="manager" data-fill="auto" data-seatno="visible"></div> --%>
                </div>
        
                <input type="hidden" name="hallNo" value="${hallDto.hallNo}">
                <input type="submit" value="선택">
            </form>
        </div>

        <div class="result">

        </div>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>