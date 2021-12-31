package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class MemberInterCeptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//세션에서 회원아이디를 가져온다
		String memberEmail=(String)request.getSession().getAttribute("ses");
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
