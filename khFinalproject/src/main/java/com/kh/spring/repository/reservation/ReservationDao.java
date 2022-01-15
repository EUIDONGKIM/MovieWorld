package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.vo.ReservationListVO;

public interface ReservationDao {
	int getSequence();

	void insert(ReservationDto reservationDto);

	ReservationDto get(int reservationNo);

	void updatePrice(int reservationNo, int totalReservationPice);

	boolean remove(int reservationNo);

	void clean();

	void approve(ReservationDto reservationDto);

	void cancel(int reservationNo);
	
	List<ReservationDto> list(int memberNo);
	
	List<ReservationDto> listByPage(int memberNo, int startRow, int endRow);

	int count(String column, String keyword);

	List<ReservationListVO> serach(String column, String keyword, int begin, int end);
	
	List<ReservationDto> paymentCompletedListByScheduleTimeNo(int scheduleTimeNo);
}
