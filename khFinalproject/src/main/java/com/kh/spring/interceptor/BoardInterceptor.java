package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.vo.BoardSearchVO;

	public class BoardInterceptor implements HandlerInterceptor {
		
		@Autowired
		private ReservationDao reservaitonDao;
		
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String memberGrade = (String)request.getSession().getAttribute("grade");
		
		boolean isMember = memberGrade != null;
		boolean isAdmin = isMember && memberGrade.equals("운영자");
		
		int boardTypeName = Integer.parseInt(request.getParameter("boardTypeName"));
		boolean checkMember = boardTypeName == 4 || boardTypeName == 5;
			
		if(isAdmin) {
			return true;
		}else if(isMember){
			if(checkMember) {
				return true;
			}else {
				response.sendError(403);
				return false;
			}
		}else {
			response.sendError(401);
			return false;
		}
	}
}
