<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                 
        .form-control.success ~ span.success { 
            display:block;
        }
        .form-control.fail ~ span.fail {
            display: block;
        }
        

</style>
<script>
$(function() {
	var pass;
	$("input[name=changePw]").on("blur", function() {
		var regex = /^[A-Za-z-0-9!@#$\s_-]{8,16}$/;
		var pw = $(this).val(); //changePw
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(pw)) {
			$("input[name=changePw]").addClass("success");
			$("#change-btn").prop("disabled",false);
		} else {
			$("#change-btn").prop("disabled",true);	
			$("input[name=changePw]").addClass("fail");
		}
	});
	$("input[name=memberPw]").on("blur", function() {
		var pw = $(this).val();
		if(pw != ''){			
		pwCheck(pw);

		}
		
		$(this).removeClass("success").removeClass("fail");
		
	});
	$("#send-form").submit(function(e){
		//e.preventDefault();
		var origin = $("input[name=memberPw]").val();
		var change = $("input[name=changePw]").val();
		
		
		if(!origin || !change){
			alert("값을 입력하세요 제발 ㅠ");
			$("input[name=memberPw]").val("");
			$("input[name=changePw]").val("");
			e.preventDefault();
			return;
		}else if(pass != 'pass'){
			alert("원래 비밀번호를 다시 확인.");
			$("input[name=memberPw]").val("");
			$("input[name=changePw]").val("");
			e.preventDefault();
			return;
		}
		
		
		
	});
	//현재 비밀번호랑 일치하는지
	function pwCheck(to){
        $.ajax({
			url:"${pageContext.request.contextPath}/member/pwCheck",
			type:"get",
        data : {
				to:to,
			},   
       dataType : "text",  
		success:function(resp){
			console.log("통신성공", resp);
			if(resp == 'gogo'){
				console.log("비밀번호 변경을 진행하세요!");
				pass='pass';
			}else{
				$("#userPw").addClass("fail");
				$("#change-btn").prop("disabled",true);	
				pass='fail';
			}
			
		},
		error:function(e){
			console.log("실패", e);
		}
    });
        
	}
	
});

</script>


<div class="container-500 container-center">
		<div class="row center">
			<h2>비밀번호 변경</h2>
		</div>
		<form action="changePw" method="post" id="send-form">
			<div class="row">
					<label>현재 비밀번호</label>
					<input type="password" name="memberPw" required class="form-control fsize" id="userPw">
					<span class="success"></span>
	           		<span class="fail">현재 비밀번호가 일치하지 않습니다</span>
			</div>
			
			<div class="row">
					<label>바꿀 비밀번호</label>
					<input type="password" name="changePw" required class="form-control fsize" id="floatingInput">
					<span class="success"></span>
	           		<span class="fail">8~16자 이내 영문,숫자,특수문자[!@#$\s_-]로 작성하세요!</span>
			</div>
			
			<div class="row">		
					<input type="submit" value="비밀번호 변경"  disabled class="btn btn-info" id="change-btn">
			</div>
		</form>
		<c:if test="${param.error != null}">
		<div class="row center">
			<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
		</div>
		</c:if>
		
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
