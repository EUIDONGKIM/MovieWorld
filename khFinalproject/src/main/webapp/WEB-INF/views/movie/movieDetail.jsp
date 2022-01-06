<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<style>
	.round.lightblue{
	border: 2px solid #3e82a4;
	color: #3e82a4;
	}
	</style>
	
	<%--상세페이지 큰 틀 --%>
	<div class="container">
		<%--정보 입력하는 틀 --%>
		<div id="contents">
			<%-- 실컨텐츠 시작 --%>
			<div class="wrap-moive-detail" id="select_main"> <!-- 영화디테일 container -->
				<div class="tit-heading-wrap">
					<h3>영화 상세</h3>
				</div>
				<div class="sect-base-movie"> <!-- 영화 포스터 제목, 예매율, 평점, 감독, 장르 개봉일 box -->
					<div class="box-image"> <!-- main poster -->
						<a href="https://img.cgv.co.kr/Movie/Thumbnail/Poster/000085/85515/85515_1000.jpg"></a>
					</div>
					<div class="box-contents"> <!-- poster옆 영화 상세정보 내용쓰는 box -->
						<div class="title">
							<strong>해피 뉴 이어</strong>
							<em class="round lightblue">
								<span>현재상영중</span>
							</em>
							<p>A YEAR-END MEDLEY</p>
						</div>
						<div class="score">
							<strong class="percent">
								"예매율"
								<span>7.1%</span>
							</strong>
							<div class="starPoint">
								<strong class="rating">
									"평점"
									<span>9점</span>
								</strong>
							</div>
						</div>
						<!-- 감독&배우정보란 -->
						<div class="spec">
							<dl>
								<dt>감독 : &nbsp;</dt>
								<dd>
									<a href="${root}/actor/detail">감독이름</a>
								</dd>
								<dd></dd>
								<dt> &nbsp;/배우 :&nbsp;</dt>
							</dl>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>