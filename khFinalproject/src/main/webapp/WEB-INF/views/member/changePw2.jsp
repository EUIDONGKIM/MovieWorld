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
                 
        span.check-success {
            color:red;
            display:block;
        }
        span.check-fail {
            color:red;
            display:block;
        }
        .form-input.success ~ span.success { 
            display:block;
        }
        .form-input.fail ~ span.fail {
            display: block;
        }
        

</style>
<script>
$(function() {
	$("input[name=changePw]").on("blur", function() {
		var regex = /^[A-Za-z-0-9!@#$\s_-]{8,16}$/;
		var pw = $(this).val();
		$(this).removeClass("success").removeClass("fail");
		if (regex.test(pw)) {
			$("input[name=changePw]").addClass("success");
			$("#chnage-btn").prop("disabled",false);
		
		} else {
			$("input[name=changePw]").addClass("fail");
			$("input[name=changePw]").next().text("8~16자 이내 영문,숫자,특수문자[!@#$\s_-]로 작성하세요!").css("color","red");
			$("#chnage-btn").prop("disabled",true);
			
		},
});
</script>


<div class="container-500 container-center">
		<div class="row center">
			<h2>비밀번호 변경</h2>
		</div>
		<form action="changePw" method="post">
			<div class="row">
					<label>현재 비밀번호</label>
					<input type="password" name="memberPw" required class="form-control fsize" id="floatingInput">
			</div>
			
			<div class="row">
					<label>바꿀 비밀번호</label>
					<input type="password" name="changePw" required class="form-control fsize" id="floatingInput">
					<span class="success"></span>
	           		<span class="fail"></span>
			</div>
			
			<div class="row">		
					<input type="submit" value="비밀번호 변경" class="btn btn-info" id="chnage-btn">
			</div>
		</form>
		<c:if test="${param.error != null}">
		<div class="row center">
			<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
		</div>
		</c:if>
		
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
