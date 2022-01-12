package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.reservation.StatisticsInfoViewDao;
import com.kh.spring.vo.ChartTotalVO;

@RestController
@RequestMapping("/admin/statistics")
public class StatisticsDataController {
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private StatisticsInfoViewDao statisticsInfoViewDao;
	
	@GetMapping("/countPeopleBySido")
	public ChartTotalVO countPeopleBySido() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("지역별 관람객 수 현황");
		vo.setLabel("관람객수");
		vo.setDataset(lastInfoViewDao.countPeopleBySido());
		return vo;
	}
	
	@GetMapping("/countReservationBySido")
	public ChartTotalVO countReservationBySido() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("지역별 예매수 현황");
		vo.setLabel("예매수");
		vo.setDataset(statisticsInfoViewDao.countReservationBySido());
		return vo;
	}
	
	@GetMapping("/countMemberjoinByYear")
	public ChartTotalVO countMemberjoinByYear() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("년도별 가입자수 현황");
		vo.setLabel("가입자수");
		vo.setDataset(memberDao.countMemberjoinByYear());
		return vo;
	}
	
	@GetMapping("/countMemberjoinByYearMonth")
	public ChartTotalVO countMemberjoinByYearMonth() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("월별 가입자수 현황");
		vo.setLabel("가입자수");
		vo.setDataset(memberDao.countMemberjoinByYearMonth());
		return vo;
	}

	@GetMapping("/countByGradeTotal")
	public ChartTotalVO countByGradeTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 인원 현황");
		vo.setLabel("등급");
		vo.setDataset(memberDao.countByGradeTotal());
		return vo;
	}
	
	@GetMapping("/countByGradeReservation")
	public ChartTotalVO countByGradeReservation() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 예매율 현황");
		vo.setLabel("등급");
		vo.setDataset(statisticsInfoViewDao.countByGradeReservation());
		return vo;
	}
	
	@GetMapping("/countByGradePoint")
	public ChartTotalVO countByGradePoint() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 포인트 현황");
		vo.setLabel("등급");
		vo.setDataset(memberDao.countByGradePoint());
		return vo;
	}
	
	@GetMapping("/totalPeopleByTheater")
	public ChartTotalVO totalPeopleByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("인원수에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(lastInfoViewDao.totalPeopleByTheater());
		return vo;
	}
	
	@GetMapping("/totalProfitByTheater")
	public ChartTotalVO totalProfitByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("총 매출에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(lastInfoViewDao.totalProfitByTheater());
		return vo;
	}
	
	@GetMapping("/totalReservationByTheater")
	public ChartTotalVO totalReservationByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("예매수에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(statisticsInfoViewDao.totalReservationByTheater());
		return vo;
	}
	
	@GetMapping("/countByAgeForTotal")
	public ChartTotalVO countByAgeForTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("전체 영화에 따른 연령별 예매");
		vo.setLabel("연령");
		vo.setDataset(statisticsInfoViewDao.countByAgeForTotal());
		return vo;
	}
	
	@GetMapping("/countByGenderForTotal")
	public ChartTotalVO countByGenderForTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("전체 영화에 따른 성별별 예매");
		vo.setLabel("성별");
		vo.setDataset(statisticsInfoViewDao.countByGenderForTotal());
		return vo;
	}

	@GetMapping("/totalProfit")
	public ChartTotalVO totalProfit() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 수익");
		vo.setLabel("수익");
		vo.setDataset(lastInfoViewDao.countByProfit());
		return vo;
	}
	
	@GetMapping("/totalReservation")
	public ChartTotalVO totalReservation() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 예매순위");
		vo.setLabel("예매수");
		vo.setDataset(statisticsInfoViewDao.countByReservation());
		return vo;
	}
	
	@GetMapping("/totalPeople")
	public ChartTotalVO totalPeople() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 총 관람객");
		vo.setLabel("관람객 수");
		vo.setDataset(lastInfoViewDao.countByTotal());
		return vo;
	}
}
