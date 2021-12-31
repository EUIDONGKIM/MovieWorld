<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>상품등록</h1>
<form method="post">
		 <div class="row">
	    	<div class="col">
		    	 <label>상품 종류</label>
				 <input type="text" name="productType" required placeholder="상품 종류" class="form-input" id="type">
	    	</div> 
	     </div>
		
		 <div class="row">
	    	<div class="col">
		    	 <label>상품 이름</label>
				 <input type="text" name="productName" required placeholder="상품 이름" class="form-input" id="name">
	    	</div> 
	    </div>
	    
		<div class="row">
	    	<div class="col">
		    	 <label>상품 가격</label>
				 <input type="number" name="productPrice" required placeholder="상품 가격" class="form-input" id="price">
	    	</div> 
	    </div>
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>원산지</label>
				 <input type="text" name="productOrigin" required placeholder="원산지" class="form-input" id="origin">
	    	</div> 
	    </div>
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>상품 소개</label>
				 <input type="text" name="productIntro" required placeholder="상품 소개" class="form-input" id="Intro">
	    	</div> 
	    </div>
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>상품 내용</label>
				 <input type="text" name="productContent" required placeholder="상품 내용" class="form-input" id="Intro">
	    	</div> 
	    </div>
	    
	     <div class="row">
	        <div class="col">
				 <input type="submit" value="상품 등록" class="form-btn">
	    	</div> 
	    </div>  
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    