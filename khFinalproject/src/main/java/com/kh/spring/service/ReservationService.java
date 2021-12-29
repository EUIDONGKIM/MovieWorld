package com.kh.spring.service;

import java.util.List;

import com.kh.spring.vo.ReservationVO;

public interface ReservationService {

	void insert(String seatData,int reservationKey , int scheduleTimeNo, int ageNormal, int ageYoung, int ageOld, int memberNo);

	List<ReservationVO> getSeatVOList(int scheduleTimeNo);

	boolean remove(int reservationNo);

	void clean();

}
