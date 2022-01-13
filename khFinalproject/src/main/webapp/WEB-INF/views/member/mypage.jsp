<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <style>
        .b{
            border:1px solid black;
        }
        
        .fsize{
         font-size:  20px;
        }
        
     </style>
     
     <script>
     $(function(){
//     	$(".noatag").prop("disabled",true);
    	 //기본 전송 이벤트 방지
    	$(".atag1").on("click",function(e){
    		e.preventDefault();
    		
    		var url = $(this).attr("href");
    		
    		
    		$.ajax({
    			url:url,
    			success:function(resp){
    				$("#page2").empty();
    				$("#page3").empty();
    				$("#page4").empty();
    				$("#page1").html(resp);
    			}
    		});
    	});
    	$(".atag2").on("click",function(e){
    		e.preventDefault();
    		
    		var url = $(this).attr("href");
    		
    		
    		$.ajax({
    			url:url,
    			success:function(resp){
    				$("#page1").empty();
    				$("#page3").empty();
    				$("#page4").empty();
    				$("#page2").html(resp);
    			}
    		});
    	});
    	$(".atag3").on("click",function(e){
    		e.preventDefault();
    		
    		var url = $(this).attr("href");
    		
    		
    		$.ajax({
    			url:url,
    			success:function(resp){
    				$("#page2").empty();
    				$("#page1").empty();
    				$("#page4").empty();
    				$("#page3").html(resp);
    			}
    		});
    	});
    	
    	$(".atag4").on("click",function(e){
    		e.preventDefault();
    		
    		var url = $(this).attr("href");
    		
    		
    		$.ajax({
    			url:url,
    			success:function(resp){
    				$("#page2").empty();
    				$("#page1").empty();
    				$("#page3").empty();
    				$("#page4").html(resp);
    			}
    		});
    	});
     });
     </script>
<c:set var="root"   value="${pageContext.request.contextPath}"></c:set>
<c:set var="bronze" value="${memberDto.memberGrade eq '브론즈' }"></c:set>
<c:set var="silver" value="${memberDto.memberGrade eq '실버' }"></c:set>
<c:set var="gold"   value="${memberDto.memberGrade eq '골드' }"></c:set>
<c:set var="admin"  value="${memberDto.memberGrade eq '운영자' }"></c:set>

<body>
    <div class="container-fluid" style="background-color: #EEEEEE">
        <div class="row">
            <div class="col-md-12 b">
        		<div class="row">
        			<c:if test="${bronze}">
        				<div class="col-2">
        					<img src="${root}/resources/image/브론즈.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${silver}">
        				<div class="col-2">
        					<img src="${root}/resources/image/실버.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${gold}">
        				<div class="col-2">
        					<img src="${root}/resources/image/골드.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${admin}">
        				<div class="col-2">
        					<img src="${root}/resources/image/플레티넘.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<div class="col-6">
        				<div class="row">
        					<div class="col" style="font-size:30px">
        					${memberDto.memberName} 회원님
        					</div>
        				</div>
        				<hr>
        				<div class="row">
        					<div class="col">
        					회원님의 등급은 ${memberDto.memberGrade} 입니다
        					</div>
        				</div>
        				
        				<div class="row">
        					<div class="col">
        						회원님의 포인트는 ${memberDto.memberPoint} 입니다
        					</div>
        				</div>
        				
        				<div class="row">
        					<div class="col">
        						회원님의 마지막 로그인은 ${memberDto.memberLogin} 입니다
        					</div>
        				</div>
        			</div>
        		</div>
            </div>
        </div>
    </div>
   
   
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 b">

                  <div class="list-group">
                    <a class="list-group-item list-group-item-action "   disabled style="text-align: center;">MY PAGE</a>
                    <br>
                    <a  class="list-group-item list-group-item-action active" style="text-align: center;">회원정보수정</a>
                    <a href="edit" class=" list-group-item list-group-item-action atag1">회원정보수정하러가기</a>
                    <a href="quit" class="list-group-item list-group-item-action  atag2">회원탈퇴하기</a>
                    <a href="changePw" class=" list-group-item list-group-item-action atag3">비밀번호변경</a>
					<br>
					<a class="list-group-item list-group-item-action active" style="text-align: center;">이용내역</a>
                    <a href="${root}/board/userWriteList" class="list-group-item list-group-item-action atag1">내가 작성한 게시글보기</a>
                    <a href="history" class="list-group-item list-group-item-action atag2">포인트 적립/사용</a>
                    <a href="ReservationHistoryList" class="list-group-item list-group-item-action atag3">내가 관람한 영화</a>
                    <a href="movieLikeList" class="list-group-item list-group-item-action atag4">내가 보고 싶은 영화</a>

                
                  </div>
            </div>
            <div class="col-md-10 b" style="height: auto">
			
                	<div id="page1">
				
                </div>
                
  				  <div id="page2">
				
                </div>
                
					<div id="page3">
				
                </div>
                
  					<div id="page4">
				
                </div>
                
             </div>
        </div>

    </div>
</body>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</html>