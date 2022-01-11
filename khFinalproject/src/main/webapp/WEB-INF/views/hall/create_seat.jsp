<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.17/cinema/hacademy-cinema.css">
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
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.17/cinema/hacademy-cinema.js"></script>
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

<h1> 좌석 설정 </h1>
    <ul>
        <li>좌석을 선택한 후 Delete 키를 누르면 좌석 삭제</li>
        <li>좌석을 선택한 후 F2 키를 누르면 좌석이 사라지고 공간으로 병합됨</li>
        <li>좌석을 선택한 후 F3 키를 누르면 좌석이 선택 불가로 전환됨</li>
        <li>좌석번호를 표시하고 싶은 경우 .cinema-seat-area에 data-seatno="visible"로 설정</li>
    </ul>
    <div class="float-box">
        <div>
            <form action="${pageContext.request.contextPath}/seat/admin/insert" method="post">
                <div id="cinema" class="cinema-wrap" data-name="seat">
            	<div class="cinema-screen">전면스크린</div>
                    <div class="cinema-seat-area" data-rowsize="${hallDto.hallRows}" data-colsize="${hallDto.hallCols}" data-mode="manager" data-fill="auto" data-seatno="visible"></div>
                    <%-- <div class="cinema-seat-area" data-rowsize="${hallDto.hallRows }" data-colsize="${hallDto.hallCols }" data-mode="manager" data-fill="auto" data-seatno="visible"></div> --%>
                </div>
        
                <input type="hidden" name="hallNo" value="${hallDto.hallNo}">
                <input type="submit" value="좌석 등록">
            </form>
        </div>

        <div class="result">

        </div>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>