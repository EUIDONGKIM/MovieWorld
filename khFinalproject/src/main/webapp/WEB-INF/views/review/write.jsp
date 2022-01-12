<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="${path}/resources/css/commons.css" rel="stylesheet" />

<title>모달모달</title>

<style>

/* .notice-body{ */
/* 	border: solid 1px; */
/*     border-radius: 12px; */
/*     border-block-color: gray; */
/*     padding: 2; */
/*     padding: 7px; */

/* } */

/*별점 */
.star-rating {
/*   border:solid 1px #ccc; */
  display:flex;
  flex-direction: row-reverse;
  font-size:2.5em;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}
.star-rating input {
  display:none;
}
.star-rating label {
  color:#ccc;
  cursor:pointer;
}
.star-rating :checked ~ label {
  color:#f90;
}
.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}

</style>

<script>

// var myModal = document.getElementById('myModal')
// var myInput = document.getElementById('myInput')

// myModal.addEventListener('shown.bs.modal', function () {
//   myInput.focus()
// })

</script>



<body>

<!-- 	<!-- Button trigger modal -->
<!-- 	<div class="container-700 container-center"> -->
<!-- 		<div class="review_notice"> -->
<!-- 			<div class="notice-body"> -->
<!-- 				<div class="col-9"> -->
<!-- 					<label -->
<!-- 						style="border: solid 1px; border-radius: 12px; border-block-color: gray; padding: 2; padding: 7px;"> -->
<!-- 						[닉네임]님[영화제목]재미있게 보셨나요? 영화의 어떤 점이 좋았는지 이야기해주세요.  -->
<!-- 						관람일 기준 7일 이내 등록시 50p가 적립됩니다. 포인트는 관람평 최대 10편 지급가능합니다. -->
<!-- 					</label> -->
<!-- 				</div> -->
<!-- 				<div class="col-3"> -->
<!-- 					<button type="button" class="btn btn-primary" data-bs-toggle="modal" -->
<!-- 							data-bs-target="#exampleModal">관람평 작성</button> -->
<!-- 				</div> -->
				
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 		</div> -->


		<!-- 테스트 -->
			<!-- Button trigger modal -->
	<div class="container-700 container-center">
		<div class="row">
				<div class="col-10" style="padding: 5px;">
					<label
						style="border: solid 1px; border-radius: 12px; border-block-color: gray; padding: 2; padding: 7px;">
						운영자 님 웨스트 사이드 스토리 재미있게 보셨나요? 영화의 어떤 점이 좋았는지 이야기해주세요. 
						관람일 기준 7일 이내 등록시 50p가 적립됩니다. 포인트는 관람평 최대 10편 지급가능합니다.
					</label>
				</div>
				<div class="col-2" style="padding: 0;">
					<button type="button" class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#exampleModal" style="height: 88px; ">관람평 작성</button>
				</div>
				
				</div>

		</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">웨스트 사이드 스토리</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="row center">
						<div style="display: inline-block; float:center">
							<div class="star-rating">
				    			<input type="radio" id="5-stars" name="starPoint" value="5" checked/>
				    			<label for="5-stars" class="star">&#9733;</label>
				    			<input type="radio" id="4-stars" name="starPoint" value="4" />
				    			<label for="4-stars" class="star">&#9733;</label>
				    			<input type="radio" id="3-stars" name="starPoint" value="3" />
				    			<label for="3-stars" class="star">&#9733;</label>
				    			<input type="radio" id="2-stars" name="starPoint" value="2" />
				    			<label for="2-stars" class="star">&#9733;</label>
				    			<input type="radio" id="1-star" name="starPoint" value="1" />
				    			<label for="1-star" class="star">&#9733;</label>
				  			</div>
		 				</div>
		 				</div>
						<textarea type="text" id="reviewContent" name="reviewContent"
							required rows="4" cols="58" style="resize: none;" placeholder="실관람평을 남겨주세요."></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">등록</button>
					</div>
				</div>
			</div>
		</div>



</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>