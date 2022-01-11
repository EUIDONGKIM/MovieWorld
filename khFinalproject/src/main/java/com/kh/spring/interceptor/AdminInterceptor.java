package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

	public class AdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String memberGrade = (String)request.getSession().getAttribute("grade");
		
		boolean isLogin = memberGrade != null;
		boolean isAdmin = isLogin && memberGrade.equals("운영자"); 
		
		if(isAdmin) {
			return true;
		}else {
			response.sendError(403);
			return false;
		}
	}
}
