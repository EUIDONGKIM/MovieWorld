package com.kh.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.spring.repository.member.CertificationDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private CertificationDao certificationDao;
	@Autowired
	private ReservationService reservationService;
	
	@Scheduled(cron = "0 0 0 * * *")//매 일마다
	@Override
	public void execute() {
		log.debug("DB 삭제를 진행합니다.");
		certificationDao.clean();
	}
	
	@Scheduled(cron = "0 */10 * * * *")//10분마다
	@Override
	public void resetTempReservation() {
		log.debug("임시 예매 DB 삭제를 진행합니다.");
		reservationService.clean();
	}
	
}
