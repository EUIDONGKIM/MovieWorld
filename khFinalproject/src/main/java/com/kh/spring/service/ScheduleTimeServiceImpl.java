package com.kh.spring.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.repository.schedule.ScheduleDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.vo.HallByScheduleTimeVO;
import com.kh.spring.vo.ShowRealTimeVO;

@Service
public class ScheduleTimeServiceImpl implements ScheduleTimeService{
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private ScheduleDao scheduleDao;
	@Override
	public List<ShowRealTimeVO> getList(int movieNo, int theaterNo, String scheduleTimeDate) {
		int scheduleNo = scheduleDao.getByMovieTheater(movieNo,theaterNo);

		List<ShowRealTimeVO> list = new ArrayList<>();
		List<HallByScheduleTimeVO> tempList = scheduleTimeDao.listByDate(scheduleNo,scheduleTimeDate);
		

		for(HallByScheduleTimeVO vo : tempList) {
			ShowRealTimeVO showRealTimeVO = new ShowRealTimeVO();
			
			showRealTimeVO.setHallNo(vo.getHallNo());
			showRealTimeVO.setHallType(vo.getHallType());
			showRealTimeVO.setHallName(vo.getHallName());
			showRealTimeVO.setHallSeat(vo.getHallSeat());
			showRealTimeVO.setScheduleTimeNo(vo.getScheduleTimeNo());
			showRealTimeVO.setScheduleNo(vo.getScheduleNo());
			showRealTimeVO.setScheduleTimeDateTime(vo.getScheduleTimeDateTime());
			showRealTimeVO.setScheduleTimeDiscountType(vo.getScheduleTimeDiscountType());
			
			int disabledSeat = reservationService.getSeatRest(vo.getScheduleTimeNo());
			showRealTimeVO.setDisabledSeat(disabledSeat);
			
			list.add(showRealTimeVO);
		}
		return list;
	}

}
