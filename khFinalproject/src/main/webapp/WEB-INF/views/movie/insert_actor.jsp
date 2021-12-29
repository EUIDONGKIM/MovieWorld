<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="movieNo" value="${movieNo}"></c:set>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
		
        $("#director").click(function(){
        	var target = '${pageContext.request.contextPath}/movie/insert_popup?actorJob=director';
            window.open(target, "popup", "width=500 , height=500");
        });
        $("#actor").click(function(){
        	var target = '${pageContext.request.contextPath}/movie/insert_popup?actorJob=actor';
            window.open(target, "popup", "width=500 , height=500");
        });
        $("#staff").click(function(){
        	var target = '${pageContext.request.contextPath}/movie/insert_popup?actorJob=staff';
            window.open(target, "popup", "width=500 , height=500");
        });

        $(".btn-director").click(function(){
        	var actorName =  $("#director").val();
        	var actorNo = $("#directorNo").val();
        	
        	if(!actorName || !actorNo) {
				alert("값을 입력하세요!!");        		
        		return;
        	}
        	
			var template = $("#add-role-template").html();
            template = template.replace("{{actorName}}",actorName);
            template = template.replace("{{actorNo}}",actorNo);
            
			$("#result-director").append(template);
            
			addRole(movieNo,actorNo);
			
			$("#director").val("");
			$("#directorNo").val("");
        });
        $(".btn-actor").click(function(){
        	var actorName =  $("#actor").val();
        	var actorNo = $("#actorNo").val();
        	
        	if(!actorName || !actorNo) {
				alert("값을 입력하세요!!");        		
        		return;
        	}
        	
			var template = $("#add-role-template").html();
            template = template.replace("{{actorName}}",actorName);
            template = template.replace("{{actorNo}}",actorNo);
            
			$("#result-actor").append(template);
            
			addRole(movieNo,actorNo);
			
			$("#actor").val("");
			$("#actorNo").val("");
        });
        $(".btn-staff").click(function(){
        	var actorName =  $("#staff").val();
        	var actorNo = $("#staffNo").val();
        	
        	if(!actorName || !actorNo) {
				alert("값을 입력하세요!!");        		
        		return;
        	}
        	
			var template = $("#add-role-template").html();
            template = template.replace("{{actorName}}",actorName);
            template = template.replace("{{actorNo}}",actorNo);
            
			$("#result-staff").append(template);
            
			addRole(movieNo,actorNo);
			
			$("#staff").val("");
			$("#staffNo").val("");
        });
        
		$(".exit-btn").click(function(){
			location.href = "${pageContext.request.contextPath}/movie/list";
			console.log(actorNo);
			console.log(actorName);
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
			console.log(movieNo);
			console.log(videoTitle);
			console.log(videoRoot);
            
            $("input[name=vedioTitle]").val("");
            $("input[name=videoRoot]").val("");

        });

        function addRole(movieNo,actorNo){
            $.ajax({
			url:"${pageContext.request.contextPath}/data/addRole",
			type:"post",
            data : {
				movieNo:movieNo,
                actorNo:actorNo
			},
			success:function(resp){
				console.log("성공", resp);
			},
			error:function(e){
				console.log("실패", e);
			}
		    });
        };

        
        function addVideo(movieNo,videoTitle,videoRoot){
            $.ajax({
			url:"${pageContext.request.contextPath}/data/addVideo",
			type:"post",
            data : {
				movieNo:movieNo,
                videoTitle:videoTitle,
                videoRoot:videoRoot
			},
			success:function(resp){
				console.log("성공", resp);
			},
			error:function(e){
				console.log("실패", e);
			}
		    });
        };

	});
</script>
   
    <template id="add-role-template">
        <div class="row center">
            <label>영화인 번호 : </label>    
            <span>{{actorNo}}</span>
            <label>/ 영화인 : </label>
            <span>{{actorName}}</span>
        </div>
    </template>

    <template id="video-template">
        <div class="row center">
            <label>비디오 명 : </label>    
            <span>{{videoTitle}}</span>
            <label>/ 경로(URL) : </label>
            <span>{{videoRoot}}</span>
        </div>
    </template>
    
    <h1>영화인 검색</h1>

    <h1> 역할 추가(확인용으로 보여주기(템플릿으로) / 실제로 데이터가 추가되지만 리스트를 실시간으로 보여주는것 추후 구현) </h1>
    <br>
	
	<h2> - 감독 - </h2>
	<input type="text" name="directorNo" id="directorNo" readonly>
	<input type="text" name="director" id="director" readonly placeholder="여기를 눌러 감독을 넣으세요">
	<button class="btn-director">감독 추가</button>
	<div id="result-director"></div>
	 <br>
	 
	<h2> - 배우 - </h2>
	<input type="text" name="actorNo" id="actorNo" readonly>
	<input type="text" name="actor" id="actor" readonly placeholder="여기를 눌러 배우를 넣으세요">
	<button class="btn-actor">배우 추가</button>
	<div id="result-actor"></div>
	 <br>
	 
	<h2> - 스태프 - </h2>
	<input type="text" name="staffNo" id="staffNo" readonly>
	<input type="text" name="staff" id="staff" readonly placeholder="여기를 눌러 스태프를 넣으세요">
	<button class="btn-staff">스태프 추가</button>
	<div id="result-staff"></div>
	

    <h1> 비디오 추가(확인용으로 보여주기(템플릿으로) / 실제로 데이터가 추가되지만 리스트를 실시간으로 보여주는것 추후 구현) </h1>

    <div class="row video-item">
        <div class="row center">
            <label>비디오 제목</label>
            <input type="text" name="videoTitle">
        </div>

        <div class="row center">
            <label>비디오 링크(URL)</label>
            <input type="text" name="videoRoot">
        </div>
        <input type="hidden" name="movieNo" value="${movieNo}">
    </div>

    <div class="video-result"></div>
    <button class="video-add-btn">비디오 추가</button>
    
	<button class="exit-btn">추가 완료</button>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>