<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
$(function(){
	$("button").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/send/",
			type:"post",
			dataType:"text",
			success:function(resp){
				console.log("성공",resp);
//					$("#result").html(resp);
				$("#result").append(resp);
			},
			error:function(e){
				console.log("실패",e);
//					alert("통신실패");
			}
		});
	});
});
</script>

<div class="container-800 container-center">

	<div class="row center">
	  <h1>회원가입홈페이지</h1>
	</div>
	<form method="post">
	    <div class="row">
	    	<div class="col">
		    	 <label>아이디(이메일)</label>
				 <input type="email" name="memberEmail" required placeholder="E-mail" class="form-input" id="userinput_email">
				 <button id="email" type="button">이메일인증</button>
	    	</div> 
	    </div>
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>인증번호</label>
				 <input type="number" name="serial" disabled  required placeholder="인증번호" class="form-input" id="userinput_email2">
				 
	    	</div> 
	    </div>
        
	   
	    <div class="row">
	    	<div class="col">
		    	 <label>비밀번호</label>
				 <input type="password" name="memberPw" required placeholder="password" class="form-input">
	    	</div> 
	    </div>
	
	    <div class="row">
	    	<div class="col">
		    	 <label>이름</label>
				 <input type="text" name="memberName" required placeholder="이름" class="form-input">
	    	</div> 
	    </div>
	
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>닉네임</label>
				 <input type="text" name="memberNick" required placeholder="이름" class="form-input">
	    	</div> 
	    </div>
	
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>생년월일</label>
				 <input type="date" name="memberBirth" required  class="form-input">
	    	</div> 
	    </div> 
	
	    <div class="row">
	        <div class="col">
		    	 <label>핸드폰번호</label>
				 <input type="tel" name="memberPhone" required placeholder="010-0000-0000" class="form-input">
	    	</div> 
	    </div>
	
	    
		<div class="row">
			<div class="col">
				<label>성별</label>
				<input type="radio" name="memberGender" value="남자"  checked> 남자
				<input type="radio" name="memberGender" value="여자"  > 여자
			</div>
		</div>
	
	 
	 
	    <div class="row">
	        <div class="col">
				 <input type="submit" value="회원가입" class="form-btn">
	    	</div> 
	    </div>  
	
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>