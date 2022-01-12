package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;


	public class SelfInterceptor implements HandlerInterceptor {
		
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int memberNo = (int)request.getSession().getAttribute("memberNo");
		int checkNo = Integer.parseInt(request.getParameter("memberNo"));
		
		String memberGrade = (String)request.getSession().getAttribute("grade");
		
		boolean isSame = memberNo == checkNo;
		
		if(isSame||memberGrade.equals("운영자")) {
			return true;
		}else {
			response.sendError(403);
			return false;
		}
	}
}
