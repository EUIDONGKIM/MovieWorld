<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>