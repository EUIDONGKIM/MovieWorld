package com.kh.spring.service;

import java.util.List;

import com.kh.spring.vo.ShowRealTimeVO;

public interface ScheduleTimeService {

	List<ShowRealTimeVO> getList(int movieNo, int theaterNo, String scheduleTimeDate);

}
