package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

	public class SameInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int memberNo = (int)request.getSession().getAttribute("memberNo");
		String checkMemberNo = request.getParameter("memberNo");
		boolean isSame = memberNo == Integer.parseInt(checkMemberNo);
		
		if(isSame) {
			return true;
		}else {
			response.sendError(403);
			return false;
		}
	}
}
