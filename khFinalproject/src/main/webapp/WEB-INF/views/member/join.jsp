<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>회원가입홈페이지</h1>

<form method="post">
    <div class="row">
    	<div class="col">
	    	 <label>아이디(이메일)</label>
			 <input type="email" name="memberEmail" required placeholder="E-mail">
			 <a href=#>인증 팝업(예정)</a>
    	</div> 
    </div>
    
    <div class="row">
    	<div class="col">
	    	 <label>비밀번호</label>
			 <input type="password" name="memberPw" required placeholder="password">
    	</div> 
    </div>

    <div class="row">
    	<div class="col">
	    	 <label>이름</label>
			 <input type="text" name="memberName" required placeholder="이름">
    	</div> 
    </div>

    
    <div class="row">
    	<div class="col">
	    	 <label>닉네임</label>
			 <input type="text" name="memberNick" required placeholder="이름">
    	</div> 
    </div>

    
    <div class="row">
    	<div class="col">
	    	 <label>생년월일</label>
			 <input type="date" name="memberBirth" required >
    	</div> 
    </div> 

    <div class="row">
        <div class="col">
	    	 <label>핸드폰번호</label>
			 <input type="tel" name="memberPhone" required placeholder="핸드폰번호">
    	</div> 
    </div>

    
    <div class="row">
        <div class="col">
	    	<label>성별</label>
			<br>
			<select name="memberGender">
				<option value="남자" selected >남자</option>
				<option value="여자" >여자</option>
			</select>
    	</div> 
    </div>    

 
 
    <div class="row">
        <div class="col">
			 <input type="submit" value="회원가입">
    	</div> 
    </div>  

</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>