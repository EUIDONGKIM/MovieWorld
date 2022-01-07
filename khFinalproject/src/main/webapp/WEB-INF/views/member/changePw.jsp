<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jquey cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- sha1 암호화 cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

<script>
// 	// form이 전송되면 input[type=password]가 자동 암호화되도록 설정
$(function(){
	$("form").submit(function(e){
		e.preventDefault();//form 기본 전송 이벤트 방지
	
		//this == form
		//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
		$(this).find("input[type=password]").each(function(){
			//this == 입력창
			var origin = $(this).val();
			console.log(origin);
			var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
			var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
			$(this).val(encrypt);
		});
		
		this.submit();//form 전송 지시
	});
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
			</div>
			
			<div class="row">		
					<input type="submit" value="비밀번호 변경" class="btn btn-info">
			</div>
		</form>
		<c:if test="${param.error != null}">
		<div class="row center">
			<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
		</div>
		</c:if>
		
	</div>

