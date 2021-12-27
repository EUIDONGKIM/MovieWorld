<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){

        $("input[name=actorName]").focus(function(){
            window.open("insert_actor_propup.jsp", "popup", "width=500 , height=500");
        });


		$(".role-add-btn").click(function(){
            var movieNo = $("input[name=movieNo]").val();
            var roleType = $("select[name=roleType]").val();
            var actorNo = $("input[name=actorNo]").val();
            var actorName = $("input[name=actorName]").val();
            var rollName = $("input[name=rollName]").val();

            if(!roleType||!actorNo||!rollName){
                return;
            }

			var template = $("#add-role-template").html();
            template = template.replace("{{roleType}}",roleType);
            template = template.replace("{{actorNo}}",actorNo);
            template = template.replace("{{roleName}}",roleName);

			$(".role-result").append(template);
            
            $("select[name=roleType]").val("");
            $("input[name=actorNo]").val("");
            $("input[name=actorName]").val("");
            $("input[name=roleName]").val("");
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

            $("input[name=vedioTitle]").val("");
            $("input[name=videoRoot]").val("");

        });

        function addRole(movieNo,roleType,actorNo,roleName){
            $.ajax({
			url:"${pageContext.request.contextPath}/data/addRole",
			type:"post",
            data : {
				movieNo:movieNo,
                roleType:roleType,
                actorNo:actorNo,
                roleName:roleName
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
            <label>역할 : </label>    
            <span>{{roleType}}</span>
            <label>/ 영화인 : </label>
            <span>{{actorNo}}</span>
            <label>/ 역이름 : </label>
            <span>{{roleName}}</span>
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
    

    <h1> 역할 추가 </h1>

    <div class="row role-item">
        <label>역할 선택</label>
        <select name="roleType" class="form-input form-inline">
            <option value="">역할 선택</option>
            <option>감독</option>
            <option>스태프</option>
            <option>배우</option>
        </select>
        
        <label>영화인 선택</label>
        <input type="text" name="actorName" id="actorName" class="form-input form-inline" readonly>
        <input type="hidden" name="actorNo" id="actorNo">

        <label>역이름</label>
        <input type="text" name="roleName" class="form-input form-inline">
        <input type="hidden" name="movieNo" value="${movieNo}">
    </div>

    <div class="role-result"></div>
    <button class="role-add-btn">역할 추가</button>
    

    <h1> 비디오 추가 </h1>

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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>