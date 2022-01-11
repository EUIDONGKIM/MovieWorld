package com.kh.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.repository.reservation.ReservationDao;

	public class SameInterceptor implements HandlerInterceptor {
		
		@Autowired
		private ReservationDao reservaitonDao;
		
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int memberNo = (int)request.getSession().getAttribute("memberNo");
		
		int reservationNo = Integer.parseInt(request.getParameter("reservationNo"));
		String memberGrade = (String)request.getSession().getAttribute("grade");
		
		ReservationDto reservationDto = reservaitonDao.get(reservationNo);
		
		boolean isSame = memberNo == reservationDto.getMemberNo();
		
		if(isSame||memberGrade.equals("운영자")) {
			return true;
		}else {
			response.sendError(403);
			return false;
		}
	}
}
