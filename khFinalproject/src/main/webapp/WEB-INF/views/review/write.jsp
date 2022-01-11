<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="${path}/resources/css/commons.css" rel="stylesheet" />

<style>
/* .star-rating { */
/* 	display: flex; */
/* 	flex-direction: row-reverse; */
/* 	font-size: 2.25rem; */
/* 	line-height: 2.5rem; */
/* 	justify-content: space-around; */
/* 	padding: 0 0.2em; */
/* 	text-align: center; */
/* 	width: 5em; */
/* } */

/* .star-rating input { */
/* 	display: none; */
/* } */

/* .star-rating label { */
/* 	-webkit-text-fill-color: transparent; */
/* 	/* Will override color (regardless of order) */ */
/* 	-webkit-text-stroke-width: 2.3px; */
/* 	-webkit-text-stroke-color: #2b2a29; */
/* 	cursor: pointer; */
/* } */

/* .star-rating :checked ~ label { */
/* 	-webkit-text-fill-color: gold; */
/* } */

/* .star-rating label:hover, .star-rating label:hover ~ label { */
/* 	-webkit-text-fill-color: #fff58c; */
/* } */

#modal {
	display: none;
	position: relative;
	width: 100%;
	height: 100%;
	z-index: 1;
}

#modal h2 {
	margin: 0;
}

#modal button {
	display: inline-block;
	width: 100px;
	margin-left: calc(100% - 100px - 10px);
}

#modal .modal_content {
	width: 300px;
	margin: 100px auto;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}

#modal .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}

#modal .background{
	15615064315+150+
	156
}
</style>

<script>

document.getElementById("modal_opne_btn").onclick = function() {
    document.getElementById("modal").style.display="block";
}

document.getElementById("modal_close_btn").onclick = function() {
    document.getElementById("modal").style.display="none";
}   
</script>


<div id="root">

	<button type="button" id="modal_opne_btn">모달 창 열기</button>

</div>

<div id="modal">

	<div class="modal_content">
		<h2>모달 창</h2>

		<p>모달 창 입니다.</p>

		<button type="button" id="modal_close_btn">모달 창 닫기</button>

	</div>

	<div class="modal_layer"></div>
</div>




<!-- <h1>관람평 작성</h1> -->
<!-- <form> -->
<!-- 	<div class="container-400 container-center"> -->
<!-- 		<div class="row center"> -->
<!-- 			<label>영화 제목자리~!</label> -->
<!-- 		</div> -->

<!-- 		<div style="display: inline-block; float: right"> -->
<!-- 			<div class="star-rating"> -->
<!-- 				<input type="radio" id="5-stars" name="starPoint" value="5" checked /> -->
<!-- 				<label for="5-stars" class="star">&#9733;</label> <input -->
<!-- 					type="radio" id="4-stars" name="starPoint" value="4" /> <label -->
<!-- 					for="4-stars" class="star">&#9733;</label> <input type="radio" -->
<!-- 					id="3-stars" name="starPoint" value="3" /> <label for="3-stars" -->
<!-- 					class="star">&#9733;</label> <input type="radio" id="2-stars" -->
<!-- 					name="starPoint" value="2" /> <label for="2-stars" class="star">&#9733;</label> -->
<!-- 				<input type="radio" id="1-star" name="starPoint" value="1" /> <label -->
<!-- 					for="1-star" class="star">&#9733;</label> -->
<!-- 			</div> -->

<!-- 			<div class="row"> -->
<!-- 				<textarea style="width: 400px; height: 400px" name="reviewContent" -->
<!-- 					placeholder="실관람평을 남겨주세요." required></textarea> -->

<!-- 			</div> -->

<!-- 			<button type="submit">취소</button> -->
<!-- 			<button type="submit">등록</button> -->

<!-- 		</div> -->
<!-- 	</div> -->
<!-- </form> -->

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>