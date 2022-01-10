<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="${path}/resources/css/commons.css" rel="stylesheet"/>

<style>
.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
}
 
.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}
</style>

<script>
</script>

<%-- 모달로 띄워주기 --%>
<div class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">영화제목란</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>관람평작성란</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>






<h1> 관람평 작성 </h1>
<form> 
	<div class="container-400 container-center">
		<div class="row center">
			<label>영화 제목자리~!</label>
		</div>
		
		<div style="display: inline-block; float:right">
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
		
		<div class="row">
			<textarea
				style="width:400px; height:400px"
				name="reviewContent"
				placeholder="실관람평을 남겨주세요."
				required
			></textarea>
		
		</div>
		
		<button type="submit">취소</button>
		<button type="submit">등록</button>

	</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>