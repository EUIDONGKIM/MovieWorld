package com.kh.spring.service;

import java.net.URISyntaxException;
import java.util.List;

import com.kh.spring.vo.KakaoPayReadyRequestVO;
import com.kh.spring.vo.ReservationVO;

public interface ReservationService {

	void insert(String seatData,int reservationKey , int scheduleTimeNo, int ageNormal, int ageYoung, int ageOld, int memberNo);

	List<ReservationVO> getSeatVOList(int scheduleTimeNo);

	boolean remove(int reservationNo);
	int getSeatRest(int scheduleTimeNo);
	void clean();

	KakaoPayReadyRequestVO getRequestVO(int reservationNo, int memberPoint, String memberEmail);

	int getReservationNo(String partner_order_id, String partner_user_id, String tid, String pg_token, int memberPoint, int memberNo) throws URISyntaxException;

	void cancel(int reservationNo, int memberNo) throws URISyntaxException;

}
