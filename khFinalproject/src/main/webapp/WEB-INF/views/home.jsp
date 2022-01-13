<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <style>
        .container{
            width: 800px; 
            margin: 0 auto;
        }
        .album{
            width: 1000px;  
            height: 400px; 
            overflow: hidden;
            margin-right: 60px;
        }
        .images{
            position: relative;
            display: flex;
            height: 250px;
            
        }
        
        .please, .please:active, .please:focus{
            border : none;
            background-color: white;
        }

        .prev{
            float: left;

        }
        .next{
            float: right;

        }
        .img{
            margin-right: 10px;
        }
        
        .btn{
            margin-top: 120px;
        }

    </style>
<h1> 홈 화면 </h1>
<!-- 슬라이드배너 -->
<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${pageContext.request.contextPath}/resources/image/benner/benner2.jpg" class="d-block w-100" height="400px">
      <div class="carousel-caption d-none d-md-block">
        <h5>커다란 스크린</h5>
        <p>강남 영화보조로오세요.</p>
      </div>
    </div>
    <div class="carousel-item">
     <img src="${pageContext.request.contextPath}/resources/image/benner/benner1.png" class="d-block w-100" height="400px">
      <div class="carousel-caption d-none d-md-block">
        <h5>영화보조</h5>
        <p>저희와 함께하는 즐거운 크크루삥뽕</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/resources/image/benner/benner3.jpg" class="d-block w-100" height="400px">
      <div class="carousel-caption d-none d-md-block">
        <h5>영화보조</h5>
        <p>온라인 영화 예매사이트</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<br>
<div class="row right">
	<a href="${root }/movie/movieChart" class="btn btn-outline-info">전체 보기</a>
</div>
<hr>

		<h1>현재 상영작</h1>

<hr>

	<div class="container-1200 container-center">

          <div class="row">

                <div class="col-1">
                    <div class="btn">
                        <button class="please previous">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-left-square" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm11.5 5.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
							</svg>
                        </button>  <!--이전 버튼에 들어갈 문구를 작성해주세요-->
                    </div>
                </div>



                <div class="col-10">
                    <div class="album">
                        <div class="images">
                            <c:forEach var="movieChartVO" items="${nowList}">
					      		<div class="img">
					      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
					      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>
				      						
				      				<div class="row">
				      					<c:choose>
				      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
				      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${movieChartVO.movieTitle }</a>
				      						</c:when>
				      						<c:otherwise>
				      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
				      						</c:otherwise>
				      					</c:choose>
				      				</div>
				      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>     		
					      		</div>        
				      		</c:forEach>
                                    <!--슬라이드에 넣길 원하는 이미지 수만큼 img 코드를 추가해주세요-->
                                
                        </div>
                    </div>
                </div>




                 
                <div class="col-1">
                    <div class="btn">
                        <button class="please next">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-right-square" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm4.5 5.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
							</svg>
                        </button>    <!--다음 버튼에 들어갈 문구를 작성해주세요-->
                    </div>
                </div>
                    



            </div>
        </div>
<hr>

				<h1>개봉 예정작</h1>

<hr>
        
        <div class="container-1200 container-center">

          <div class="row">

                <div class="col-1">
                    <div class="btn">
                        <button class="please previous">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-left-square" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm11.5 5.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
							</svg>
                        </button>  <!--이전 버튼에 들어갈 문구를 작성해주세요-->
                    </div>
                </div>



                <div class="col-10">
                    <div class="album">
                        <div class="images">
                            <c:forEach var="movieChartVO" items="${soonList}">
					      		<div class="img">
					      		  		<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">
					      				<img src="${root}/movie/movieImg?moviePhotoNo=${movieChartVO.moviePhotoNo}" width="197px" height="260px"></a>
				      						
				      				<div class="row">
				      					<c:choose>
				      						<c:when test="${fn:length(movieChartVO.movieTitle) < 12}">
				      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${movieChartVO.movieTitle }</a>
				      						</c:when>
				      						<c:otherwise>
				      							<a href="${root}/movie/movieDetail?movieNo=${movieChartVO.movieNo}">${fn:substring(movieChartVO.movieTitle,0,12) }...</a>
				      						</c:otherwise>
				      					</c:choose>
				      				</div>
				      				<div class="row">${fn:substring(movieChartVO.movieOpening,0,10) } 개봉</div>     		
					      		</div>        
				      		</c:forEach>
                                    <!--슬라이드에 넣길 원하는 이미지 수만큼 img 코드를 추가해주세요-->
                                
                        </div>
                    </div>
                </div>




                 
                <div class="col-1">
                    <div class="btn">
                        <button class="please next">
                    	     <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-right-square" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm4.5 5.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
							</svg>
                        </button>    <!--다음 버튼에 들어갈 문구를 작성해주세요-->
                    </div>
                </div>
                    



            </div>
        </div>
        
        <script>
            let imageIndex = 0;
            let postion = 0;
            const IMAGE_WIDTH = 500;  // css에서 설정한 width 값과 동일하게 맞춰주세요
            const btnPrevious = document.querySelector(".previous")
            const btnNext = document.querySelector(".next")
            const images = document.querySelector(".images")
            
            function previous(){
        if(imageIndex > 0){
            btnNext.removeAttribute("disabled")
            postion += IMAGE_WIDTH;
            images.style.transform = 'translateX('+postion+'px)';
            imageIndex = imageIndex - 1;
        }
        if(imageIndex == 0){
            btnPrevious.setAttribute('disabled', 'true')
        }
        }
        function next(){
        if(imageIndex < 3){
            btnPrevious.removeAttribute("disabled")
            postion -= IMAGE_WIDTH;
            images.style.transform = 'translateX('+postion+'px)';
            imageIndex = imageIndex + 1;
        }
        if(imageIndex == 3){
            btnNext.setAttribute('disabled', 'true')
        }
        }
        
        function init(){
        btnPrevious.setAttribute('disabled', 'true')
        btnPrevious.addEventListener("click", previous)
        btnNext.addEventListener("click", next)
        }
        
        init();

    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>