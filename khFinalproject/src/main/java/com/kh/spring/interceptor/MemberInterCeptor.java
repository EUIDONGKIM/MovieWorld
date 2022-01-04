package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class MemberInterCeptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//세션에서 회원아이디를 가져온다
		log.debug("★멤버 인터셉터 실행★");
		String memberEmail=(String)request.getSession().getAttribute("ses");
		String referer = request.getHeader("Referer");
//		log.debug("이전 url...={}",referer);
		boolean login = memberEmail != null;
		
		if(login) {
			
			return true;
		}else {
//			System.out.println("회원이 아닌데 접근한다잉 차단!");
//			response.sendError(401);
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
	
	}
}
