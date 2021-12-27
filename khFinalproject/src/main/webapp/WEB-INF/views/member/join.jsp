<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
       .form-input.fail {
            border-color: red;
         }
        span.success {
            color:red;
            display: none;
        }
        span.fail {
            color:red;
            display: none;
        }
        .form-input.success ~ span.success { 
            display:block;
        }
        .form-input.fail ~ span.fail {
            display: block;
        }
</style>
<script>
//이메일 정규표현식
$(function() {
	$("input[name=memberEmail]").on("input",function() {
		var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		var email = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(email)) {
			$("input[name=memberEmail]").addClass("success");
		} else {
			$("input[name=memberEmail]").addClass("fail");
		}
	});
});
//비밀번호 정규표현식
$(function() {
	$("input[name=memberPw]").on("input", function() {
		var regex = /^[A-Za-z0-9!@#$\s_-]{8,16}$/;
		var pw = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(pw)) {
			$("input[name=memberPw]").addClass("success");
		} else {
			$("input[name=memberPw]").addClass("fail");
		}
	});
});
//비밀번호 확인
$(function(){
	$("input[name=memberPw2]").on("blur",function(){
		var pwInput = $("input[name=memberPw]").val();
		var pw2Input = $("input[name=memberPw2]").val();
		$(this).removeClass("success").removeClass("fail");
		if (pwInput.length > 0 && pwInput == pw2Input) {
			$("input[name=memberPw2]").addClass("success");
		} else {
			$("input[name=memberPw2]").addClass("fail");
		}
	});
});
//이름 정규표현식
$(function() {
	$("input[name=name]").on("input", function() {
		var regex = /^[가-힣]{2,17}$/;
		var name = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(name)) {
			$("input[name=memberName]").addClass("success");
		} else {
			$("input[name=memberName]").addClass("fail");
		}
	});
});
//닉네임 정규표현식
$(function() {
	$("input[name=name]").on("input", function() {
		var regex = /^[가-힣]{2,17}$/;
		var name = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(name)) {
			$("input[name=nickName]").addClass("success");
		} else {
			$("input[name=nickName]").addClass("fail");
		}
	});
});
//전화번호 정규표현식
$(function() {
	$("input[name=memberPhone]").on("input", function() {
		var regex = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
		var phone = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(phone)) {
			$("input[name=memberPhone]").addClass("success");
		} else {
			$("input[name=memberPhone]").addClass("fail");
		}
	});
});
//생년월일 정규표현식
$(function() {$("input[name=memberBirth]").on("input",function() {
	var regex = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
	var birth = $(this).val();
	$(this).removeClass("success").removeClass("fail");
	if (regex.test(birth)) {
		$("input[name=memberBirth]").addClass("success");
	} else {
		$("input[name=memberBirth]").addClass("fail");
	}
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
				 <input type="email" name="memberEmail" required placeholder="E-mail" class="form-input" id="id">
				 <span class="success"></span>
           		 <span class="fail">이메일 형식이 올바르지 않습니다.</span>
				 <input type="submit" value="이메일 인증" class="form-btn">
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
				 <input type="password" name="memberPw" required placeholder="password" class="form-input" id="pw">
				 <span class="success"></span>
           		 <span class="fail">8~16자 이내 영문,숫자,특수문자로 작성하세요!</span>
	    	</div> 
	    </div>
	    
	    <div class="row">
	      <div class="col">
			<label for="memberPw2">비밀번호 확인</label>
			<input type="password" name="memberPw2" required class="form-input" id="memberPw2">
			<span class="success"></span>
            <span class="fail">비밀번호가 일치하지 않습니다.</span>
	      </div>
		</div>
	
	    <div class="row">
	    	<div class="col">
		    	 <label>이름</label>
				 <input type="text" name="memberName" required placeholder="이름" class="form-input" id="name">
				 <span class="success"></span>
           		 <span class="fail">2~17자 이내 한글로 작성하세요!</span>
	    	</div> 
	    </div>
	
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>닉네임</label>
				 <input type="text" name="memberNick" required placeholder="이름" class="form-input" id="nickName">
				 <span class="success"></span>
           		 <span class="fail">2~17자 이내 한글로 작성하세요!</span>
	    	</div> 
	    </div>
	
	    
	    <div class="row">
	    	<div class="col">
		    	 <label>생년월일</label>
				 <input type="date" name="memberBirth" required  class="form-input" id="birth">
				 <span class="success"></span>
                 <span class="fail">생년월일 형식이 올바르지 않습니다.</span>
	    	</div> 
	    </div> 
	
	    <div class="row">
	        <div class="col">
		    	 <label>핸드폰번호</label>
				 <input type="tel" name="memberPhone" required placeholder="010-0000-0000" class="form-input">
				 <span class="success"></span>
        	     <span class="fail">(-)포함  11자리로 작성하세요!</span>
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