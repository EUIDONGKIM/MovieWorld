<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
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
	var grade = '${memberDto.memberGrade}';
	$(function(){
	    $(".select-grade").each(function(){
	        if(grade==$(this).val()){
	            $(this).prop("selected",true);
	        }
	    });
		$("#drop").click(function(e){
			if(window.confirm("정말 탈퇴 시킬껍니까? 후회할퇸데...마음속으로만하라했는뒈......")){
				return true;
			} else{
				return false;
			}

		});
	});
	
	$(function() {
		$("input[name=memberNick]").on("blur", function() {
			var regex = /^[가-힣]{2,17}$/;
			var name = $(this).val();
			$(this).removeClass("success").removeClass("fail");
			if (regex.test(name)) {
				$("input[name=memberNick]").addClass("success");
				nickCheck(name)
				$("#join-btn").prop("disabled",false);
			} else {
				$("input[name=memberNick]").addClass("fail");
				$("#join-btn").prop("disabled",true);
			}
		});
		
		function nickCheck(name){
			$.ajax({
				url:"${pageContext.request.contextPath}/member/nickCheck",
				type : "get",
				dataType : "text",
				data : {
					memberNick : name
				},	
				success:function(resp){
					console.log(resp)
					if(resp=="nonono"){		
						$("input[name=memberNick]").next().text("이미 사용중인 닉네임입니다.");
					}else{				
						$("input[name=memberNick]").next().text("");
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	});
	
</script>
<div class="container-700 container-center">
	
		<h2 class="center">회원 정보 수정</h2>
			<form action="edit" method="post">
			
				<table class="table">
					<tbody>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="memberEmail"
								value="${memberDto.memberEmail}" readonly class="form-control fsize" id="floatingInput"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="memberName"
								value="${memberDto.memberName}" readonly class="form-control fsize" id="floatingInput"></td>
						</tr>
						<c:if test="${!admin}">
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="memberPw" required class="form-control fsize" id="floatingInput"></td>
							</tr>
						</c:if>
						<tr>
							<th>닉네임</th>
							<td><input type="text" name="memberNick" required value="${memberDto.memberNick}" class="form-control fsize" id="floatingInput">
								<span class="success"></span>
	           		 			<span class="fail">2~17자 이내 한글로 작성하세요!</span>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><input type="date" name="memberBirth" required
								value="${memberDto.getMemberBirthDay()}" class="form-control fsize" id="floatingInput"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="tel" name="memberPhone"
								value="${memberDto.memberPhone}" class="form-control fsize" id="floatingInput"></td>
						</tr>
						<%--관리자 등급만 수정가능 구역  --%>
						<c:if test="${admin}">
							<tr>
								<th>회원등급</th>
								 <td>
									<select name="memberGrade" class="form-select" id="exampleSelect1" >
			                                    <option class="select-grade" value="브론즈" >브론즈</option>
			                                    <option class="select-grade" value="실버">실버</option>
			                                    <option class="select-grade" value="다이아">다이아</option>
			                                    <option class="select-grade" value="운영자">운영자</option>
			                                    <option class="select-grade" value="정지">정지</option>
			                        </select>
								 <td>
							</tr>
							
							<tr>
								<th>포인트</th>
								<td><input type="number" name="memberPoint" value="${memberDto.memberPoint}" class="form-control fsize" id="floatingInput"></td>
							</tr>
								
							<tr>
								<th>가입일</th>
								<td><input type="date" name="memberJoin" value="${memberDto.getMemberJoinDay()}" readonly class="form-control fsize" id="floatingInput"></td>
							</tr>
							
								
						</c:if>
				
						<tr>
							<td colspan="2" align="right">
								<input type="submit" value="수정" class="btn btn-info">
							</td>
						</tr>
						<c:if test="${admin}">
						 <tr>
						 	 <td>
								<a href="${root}/admin/memberDrop?memberNo=${memberDto.memberNo}" id="drop" class="btn btn-primary">회원탈퇴</a>
						 	 </td>
						 </tr>
						</c:if>
					</tbody>
				</table>
			
			</form>
</div>

<c:if test="${param.error != null}">
<h4><font color="red">비밀번호가 일치하지 않습니다</font></h4>
</c:if>


