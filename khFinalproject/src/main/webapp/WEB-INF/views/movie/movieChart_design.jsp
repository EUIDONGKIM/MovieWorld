<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.box-image{
	}
	.rank{
	}
	.image{
	}
	.icon-grade{
	}
	.box-contents{
	}
	.movieTitle{
	}
	.score{
	}
	.txt-info{
	}
	.like{
	}
	
	</style>

	<div class="contianer-400 container-center">
		<div class="row">
      		<h1>✿MOVIE CHART✿</h1>
      		<hr />
      		<input type="checkbox" name="release" value="released" /> 현재 상영중
		</div>
	</div>

      <ol>
      <%--
      		for문으로 예매율 순으로 찍어주기(나머지는 더보기로 순위 밖 모든 상영 영화들을 찍어주면됨!)
      		<li>여기는 rank부터 contents box까지 하나의 box!
      		이걸 한줄에 4개씩, 4줄을 찍어주면됨
      	--%>
      	<li>
     	 <%--box-image : rank, poster image, movieDetail --%>
      		<div class="box-image">
      			<strong class="rank">No.1</strong>
      				<a href="/movie/movieDetail">
      					<span class="image">
      						<img src="#" alt="해피 뉴 이어 포스터" onerror="errorImage(this)">
      						<span class="icon-grade grade-12"> 12세 이상</span>
      					</span>
      				</a>
      				<%--<span class="screenType"></span>--%>
      			</div>
      			
      			<%--box-contents : movieTitle, 예매율score, 평점starPoint, opening개봉일, 예매하기버튼 --%>
      			<div class="box-contents">
      				<a href="/moive/movieDetail">
      					<strong class="movieTitle">해피 뉴 이어</strong>
      				</a>
      				<div class="score">
      					<strong class="percent">
      						"예매율"
      						<span>7.7%</span>
      					</strong>
      				</div>
      				<span class="txt-info">
      					<strong>
      						" 2021.12.29 "
      						<span>개봉</span>
      					</strong>
      				</span>
      				<span class="like">
      					<a class="link-reservation" href="/reservation/main">예매</a>
      				</span>
      			</div>
      		</li>
      			
      				
   </ol>
   
   
    
   
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>