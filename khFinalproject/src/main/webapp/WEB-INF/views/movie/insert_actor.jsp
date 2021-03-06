<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="movieNo" value="${movieNo}"></c:set>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
	#actorNo,
	#directorNo,
	#staffNo{
		display: none;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		var movieNo = '${movieNo}';
		loadDirector();
		loadActor();
		loadStaff();
		loadVideo();
		
        $(".btn-search").click(function(){
        	var target = '${pageContext.request.contextPath}/movie/admin/insert_popup?movieNo='+movieNo;
            window.open(target, "popup", "width=600 , height=600");
        });
        
        
		$(".exit-btn").click(function(){
			var check = confirm("등록을 완료하시겠습니까?");
			if(check){				
			location.href = "${pageContext.request.contextPath}/movie/admin/list";
			}
		});

        $(".video-add-btn").click(function(){
            var movieNo = $("input[name=movieNo]").val();
            var videoTitle = $("input[name=videoTitle]").val();
            var videoRoot = $("input[name=videoRoot]").val();
            
            console.log(videoTitle);
            console.log(videoRoot);

            if(!videoTitle||!videoRoot){
                return;
            }
            var template = $("#video-template").html();
            template = template.replace("{{videoTitle}}",videoTitle);
            template = template.replace("{{videoRoot}}",videoRoot);
            $(".video-result").append(template);
			
            addVideo(movieNo,videoTitle,videoRoot);
            
            $("input[name=videoTitle]").val("");
            $("input[name=videoRoot]").val("");

        });

        function addRole(movieNo,actorNo,actorJob){
            $.ajax({
			url:"${pageContext.request.contextPath}/admin/addRole",
			type:"post",
            data : {
				movieNo:movieNo,
                actorNo:actorNo
			},
			success:function(resp){
				console.log("성공", resp);
				if(actorJob=='director'){
					loadDirector();
				}
				if(actorJob=='actor'){
					loadActor();
				}
				if(actorJob=='staff'){
					loadStaff();
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		    });
        };
        function addVideo(movieNo,videoTitle,videoRoot){
            $.ajax({
			url:"${pageContext.request.contextPath}/admin/addVideo",
			type:"post",
            data : {
				movieNo:movieNo,
                videoTitle:videoTitle,
                videoRoot:videoRoot
			},
			success:function(resp){
				console.log("성공", resp);
				loadVideo();
			},
			error:function(e){
				console.log("실패", e);
			}
		    });
        };
        function loadVideo(){	
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/getVideo",
        		type:"get",
        		data : {
        			movieNo:movieNo
        		},
        		dataType : "json",
        		success:function(resp){
        			$(".video-result").empty();	
        			for(var i = 0 ; i < resp.length ; i++){
        				var template = $("#video-template").html();
        				template = template.replace("{{videoNo}}",resp[i].videoNo);
        				template = template.replace("{{videoNo}}",resp[i].videoNo);
        				template = template.replace("{{videoTitle}}",resp[i].videoTitle);
        				template = template.replace("{{videoRoot}}",resp[i].videoRoot);
        				
        				var tag = $(template);
        				tag.find(".btn-delete-video").on("click",function(e){
        					e.preventDefault();
        					var videoNo = $(this).data("video_no");
        					deleteVideo(videoNo);
        				});
        				$(".video-result").append(tag);
        			}	
        		},
        		error:function(e){
        			console.log("실패", e);
        		}
        	});
        }
        function loadDirector(){	
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/getDirector",
        		type:"get",
        		data : {
        			movieNo:movieNo
        		},
        		dataType : "json",
        		success:function(resp){
        			$("#result-director").empty();	
        			for(var i = 0 ; i < resp.length ; i++){
        				var template = $("#add-role-template").html();
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorName}}",resp[i].actorName);
        				template = template.replace("{{actorEngName}}",resp[i].actorEngName);
        				template = template.replace("{{actorJob}}",resp[i].actorJob);
        				template = template.replace("{{actorNationality}}",resp[i].actorNationality);
        				var birth = resp[i].actorBirth.substring(0,10);
        				template = template.replace("{{actorBirth}}",birth);
        				
        				var tag = $(template);
        				tag.find(".btn-delete").on("click",function(e){
        					e.preventDefault();
        					var actorNo = $(this).data("actor_no");
        					deleteDirector(actorNo);
        				});
        				$("#result-director").append(tag);
        			}	
        		},
        		error:function(e){
        			console.log("실패", e);
        		}
        	});
        }
        function loadActor(){	
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/getActor",
        		type:"get",
        		data : {
        			movieNo:movieNo
        		},
        		dataType : "json",
        		success:function(resp){
        			$("#result-actor").empty();	
        			for(var i = 0 ; i < resp.length ; i++){
        				var template = $("#add-role-template").html();
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorName}}",resp[i].actorName);
        				template = template.replace("{{actorEngName}}",resp[i].actorEngName);
        				template = template.replace("{{actorJob}}",resp[i].actorJob);
        				template = template.replace("{{actorNationality}}",resp[i].actorNationality);
        				var birth = resp[i].actorBirth.substring(0,10);
        				template = template.replace("{{actorBirth}}",birth);
        				
        				var tag = $(template);
        				tag.find(".btn-delete").on("click",function(e){
        					e.preventDefault();
        					var actorNo = $(this).data("actor_no");
        					deleteActor(actorNo);
        				});
        				$("#result-actor").append(tag);
        			}	
        		},
        		error:function(e){
        			console.log("실패", e);
        		}
        	});
        }
        function loadStaff(){	
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/getStaff",
        		type:"get",
        		data : {
        			movieNo:movieNo
        		},
        		dataType : "json",
        		success:function(resp){
        			$("#result-staff").empty();	
        			for(var i = 0 ; i < resp.length ; i++){
        				var template = $("#add-role-template").html();
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorNo}}",resp[i].actorNo);
        				template = template.replace("{{actorName}}",resp[i].actorName);
        				template = template.replace("{{actorEngName}}",resp[i].actorEngName);
        				template = template.replace("{{actorJob}}",resp[i].actorJob);
        				template = template.replace("{{actorNationality}}",resp[i].actorNationality);
        				var birth = resp[i].actorBirth.substring(0,10);
        				template = template.replace("{{actorBirth}}",birth);
        				
        				var tag = $(template);
        				tag.find(".btn-delete").on("click",function(e){
        					e.preventDefault();
        					var actorNo = $(this).data("actor_no");
        					deleteStaff(actorNo);
        				});
        				$("#result-staff").append(tag);
        			}	
        		},
        		error:function(e){
        			console.log("실패", e);
        		}
        	});
        }
        function deleteDirector(actorNo){
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/deleteDirector?"+$.param({"actorNo":actorNo}),
        		type:"delete",
        		dataType:"text",
        		success:function(resp){
        			console.log("성공", resp);
        			loadDirector();
        		},
        		error:function(e){}
        	});
        }
        function deleteActor(actorNo){
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/deleteActor?"+$.param({"actorNo":actorNo}),
        		type:"delete",
        		dataType:"text",
        		success:function(resp){
        			console.log("성공", resp);
        			loadActor();
        		},
        		error:function(e){}
        	});
        }
        function deleteStaff(actorNo){
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/deleteStaff?"+$.param({"actorNo":actorNo}),
        		type:"delete",
        		dataType:"text",
        		success:function(resp){
        			console.log("성공", resp);
        			loadStaff();
        		},
        		error:function(e){}
        	});
        }
        function deleteVideo(videoNo){
        	$.ajax({
        		url:"${pageContext.request.contextPath}/admin/deleteVideo?"+$.param({"videoNo":videoNo}),
        		type:"delete",
        		dataType:"text",
        		success:function(resp){
        			console.log("성공", resp);
        			loadVideo();
        		},
        		error:function(e){}
        	});
        }
        
	});
</script>
   <%-- 현재 template으로 되어있어서, 추가할 때 확인용으로 달아두신거, (추가가 실패해도 추가가 뜨도록 되어있음, db에서 실패되어도),,에이작스를 쓰면 --%>
    <template id="add-role-template"> 
	     <div class="col-auto">
			<div class="card text-center" style="width: 18rem;">
			  <div class="card-body">
			    <h5 class="card-title">영화인 번호 : {{actorNo}}</h5>
			    <h6 class="card-subtitle mb-2 text-muted">영화인 : {{actorName}}</h6>
				<p class="card-text">영어이름 : {{actorEngName}}</p>
				<p class="card-text">영화인 분류: {{actorJob}}</p>
			    <p class="card-text">국적 : {{actorNationality}}</p>
				<p class="card-text">출생일 : {{actorBirth}}</p>
			  </div>
			  <div class="card-body">
			  	<button class="btn-delete" data-actor_no="{{actorNo}}">삭제</button>
			  </div>
			</div>
		</div>
    </template>

    <template id="video-template">
    	<div class="col-auto">
			<div class="card text-center" style="width: 18rem;">
			  <div class="card-body">
			    <h5 class="card-title">비디오 번호 : {{videoNo}}</h5>
			    <h6 class="card-subtitle mb-2 text-muted">비디오 명 : {{videoTitle}}</h6>
				<p class="card-text">경로(URL) : {{videoRoot}}</p>
			  </div>
			  <div class="card-body">
			  	<button class="btn-delete-video" data-video_no="{{videoNo}}">삭제</button>
			  </div>
			</div>
		</div>
    </template>
    
    
    <!--  여기부터 디자인 시 작 -->
    <div class="container-600 container-center">
		<div class="row">
	    	<button class="btn-search"><strong>영화인 검색 및 추가</strong></button>
		</div>
    
	<hr>
    <strong>역할 추가</strong>
    <hr>
	<strong class="center"> 감독 </strong>
	<input type="text" name="directorNo" id="directorNo" readonly>
	<div id="result-director" class="row g-3 align-items-center"></div>
	 <hr>
	 
	<strong class="center"> 배우 </strong>
	<input type="text" name="actorNo" id="actorNo" readonly>
	<div id="result-actor" class="row g-3 align-items-center"></div>
	 <hr>
	 
	<strong class="center"> 스태프 </strong>
	<input type="text" name="staffNo" id="staffNo" readonly>
	<div id="result-staff" class="row g-3 align-items-center"></div>
	<hr>

   <strong> 비디오 추가 </strong>

    <div class="row video-item">
        <div class="row">
            <label>비디오 제목</label>
            <input type="text" name="videoTitle">
        </div>

        <div class="row">
            <label>비디오 링크(URL) : </label>
            <input type="text" name="videoRoot">
        </div>
        <input type="hidden" name="movieNo" value="${movieNo}">
    </div>
	<div class="row center">
    	<button class="video-add-btn">비디오 추가</button>
	</div>
   		 <div class="video-result row g-3 align-items-center"></div>
 <hr>   
	<div class="row center">
		<button class="exit-btn">추가 완료</button>
	</div>
	
</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>