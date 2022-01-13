<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">
<jsp:include page="/WEB-INF/views/template/designcode.jsp"></jsp:include>
 
    <script>

        $(function(){
        	var movieNo = ${movieNo};
			var actorJob = '${PaginationActorVO.actorJob}';
			
			$(".select-job").each(function(){
				if(actorJob == $(this).val()){
					 $(this).prop("selected",true);
				}
			});
			
			
            $(".add-btn").click(function(){
            	var check = $("input[name=actorNo]").val();
            	if(!check){
                	alert("값을 선택하세요!");
                	return;
                }
            	
            	$("input[name=actorNo]").each(function(){
            		if($(this).prop("checked")){
            			var check = $(this).val();
            			addRole(movieNo,check);
            		}
            	
            	});

                opener.document.location.reload();

        		//self.close();
                //window.close();
            });
			
            $(".exit-btn").click(function(){
            	window.close();
            });
            
            
            function addRole(movieNo,actorNo){
                $.ajax({
    			url:"${pageContext.request.contextPath}/admin/addRole",
    			type:"post",
                data : {
    				movieNo:movieNo,
                    actorNo:actorNo
    			},
    			success:function(resp){
    				alert("값이 들어갔습니다!");
    				console.log("성공", resp);
    			},
    			error:function(e){
    				alert("해당 영화에 이미 추가된 영화인입니다!");
    				console.log("실패", e);
    			}
    		    });
            };
            
        });

    </script>


   <div class="contaier-600 container-center">
   	<br>
   	<div class="row center">
   		 <h4>영화인 선택!</h4>
   	</div>
   	<!-- 검색창 -->
<div class="row">
		<div class="col-3" style="padding-left: 40px">
			<input type="hidden" name="movieNo" value="${movieNo }">
				
			<select name="actorJob"  class="form-select">
				<option class="select-job" value="">선택</option>
				<option class="select-job" value="director">감독</option>
				<option class="select-job" value="actor">배우</option>
				<option class="select-job" value="staff">스태프</option>
			</select>
		</div>
		<div class="col-7" style="padding-left: 0px">
			<form method="get" class="d-flex">
				
				<input type="text" name="actorName" value="${PaginationActorVO.actorName}" class="form-control" placeholder="이름검색">
				
				<input type="submit" value="검색" class="btn btn-info my-2 my-sm-0">
				
			</form>
		</div>
		<div class="col-2">
		</div>
	</div>
	<!-- 검색창끝 -->
	
	<c:forEach var="actorDto" items="${PaginationActorVO.list}">
	     <div class="row">
       		 <label>
            	<input type="radio" name="actorNo" value="${actorDto.actorNo}" class="form-check-input">
                <span>${actorDto.actorNo} | ${actorDto.actorJob} | ${actorDto.actorName} | ${actorDto.actorNationality}</span>
            </label>
        </div>
	</c:forEach>
	
	<!-- 페이지네이션 자리  -->
	<div class="row">
		<div class="col">
		</div>
		<div class="col outline">
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-sm" style="justify-content: center;">
			<c:choose>
				<c:when test="${PaginationActorVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${PaginationActorVO.isSearch()}">
							<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
	<%-- 						<a href="main?p=${boardSearchVO.getPreviousBlock()}">&lt;</a> --%>
							<li class="page-item">
							<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${PaginationActorVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&lt;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${PaginationActorVO.getStartBlock()}" end="${PaginationActorVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${PaginationActorVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${PaginationActorVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
							<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getNextBlock()}" class="page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${PaginationActorVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
						<li class="page-item"><a class="page-link">&gt;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
	
	</div>
	

	<div class="row">
		<div class="col">
		<button type="button" class="add-btn btn btn-outline-info">추가</button>
		<button type="button" class="exit-btn btn btn-outline-info">종료</button>
		</div>
	</div>
   </div>
