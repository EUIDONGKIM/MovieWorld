<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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


    <label>영화인 선택!</label>
	<form method="get">
		<input type="hidden" name="movieNo" value="${movieNo }">
		<div class="row center">
			<label>직업 선택</label>
				<select name="actorJob">
					<option class="select-job" value="">선택</option>
					<option class="select-job" value="director">감독</option>
					<option class="select-job" value="actor">배우</option>
					<option class="select-job" value="staff">스태프</option>
				</select>
			<label>이름 검색</label>
				<input type="text" name="actorName" value="${PaginationActorVO.actorName}">
				<input type="submit" value="검색">
		</div>
	</form>
	
	<c:forEach var="actorDto" items="${PaginationActorVO.list}">
	     <div class="row">
       		 <label>
            	<input type="radio" name="actorNo" value="${actorDto.actorNo}">
                <span>${actorDto.actorNo} | ${actorDto.actorJob} | ${actorDto.actorName} | ${actorDto.actorNationality}</span>
            </label>
        </div>
	</c:forEach>
	
	<div class="row pagination">
		<!-- 이전 버튼 -->
		<c:choose>
			<c:when test="${PaginationActorVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getPreviousBlock()}">&lt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${PaginationActorVO.getPreviousBlock()}">&lt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${PaginationActorVO.getStartBlock()}" end="${PaginationActorVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${PaginationActorVO.isSearch()}">
					<!-- 검색용 링크 -->
					<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<!-- 목록용 링크 -->
					<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${PaginationActorVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${PaginationActorVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&actorJob=${PaginationActorVO.actorJob}&actorName=${PaginationActorVO.actorName}&p=${PaginationActorVO.getNextBlock()}">&gt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="${root }/movie/admin/insert_popup?movieNo=${movieNo}&p=${PaginationActorVO.getNextBlock()}">&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
	
	<br><br>
<div class="row center">
	<button type="button" class="add-btn">추가</button>
	<button type="button" class="exit-btn">종료</button>
</div>
