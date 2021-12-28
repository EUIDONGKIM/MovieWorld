package com.kh.spring.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.SeatDto;
import com.kh.spring.repository.reservation.AgeDiscountDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.vo.ReservationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	private ReservationDao reservationDao;
	@Autowired
	private ReservationDetailDao reservationDetailDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private HallTypePriceDao hallTypePriceDao;
	@Autowired
	private AgeDiscountDao ageDiscountDao;
	@Autowired
	private SeatDao seatDao;
	
	
	@Override
	public void insert(String seatData,int reservationKey ,int scheduleTimeNo, int ageNormal, int ageYoung, int ageOld, int memberNo) {

			//임시 예약 테이블 생성.
			ReservationDto reservationDto = new ReservationDto();
			
			ScheduleTimeDto ScheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);
			
			reservationDto.setReservationNo(reservationKey);
			reservationDto.setMemberNo(memberNo);
			reservationDto.setTid(UUID.randomUUID().toString());
			reservationDto.setScheduleTimeNo(scheduleTimeNo);
			reservationDto.setScheduleTimeDateTime(ScheduleTimeDto.getScheduleTimeDateTime());
			reservationDto.setReservationStatus("미결제");
			//임시 예약 테이블 등록
			reservationDao.insert(reservationDto);
			//결제 전에 사용자간의 중복 예매를 방지하기 위해서 카카오 결제 전에 선 insert 시행
			
			//추후에 금액 산정 후 넣는다..
			int totalReservationPice = 0;
			
			//좌석 번호 받는 방법. => 홀번호와 좌석 행, 열 번호로 좌석번호를 알아 낼 수 있다.(데이터가 몇개 없으니까 이방법으로..)
			//상영관 종류 및 연령 등 DAO로 불러오기. 추가하기
			//초기 상태는 미결제
			HallDto hallDto = hallDao.get(ScheduleTimeDto.getHallNo());
			String hallType = hallDto.getHallType();
			int hallPrice = hallTypePriceDao.getPrice(hallType);
					
			int total = ageNormal + ageYoung + ageOld;
			String[] seat = new String[total];
			
			StringTokenizer seatTotal = new StringTokenizer(seatData,"&");
			int count = 0;
			while(seatTotal.hasMoreTokens()) {
				seat[count] = seatTotal.nextToken();
				seat[count] = seat[count].substring(5);
				log.debug("행열{}",seat[count]);
				count++;
			}
			
			for(int i = 0 ; i<total ; i++) {
				StringTokenizer seatRowsCols = new StringTokenizer(seat[i],"-");
				
				int row = Integer.parseInt(seatRowsCols.nextToken());
				int col = Integer.parseInt(seatRowsCols.nextToken());
				log.debug("행{}",row);
				log.debug("열{}",col);
				int seatNo = seatDao.getSeatNo(hallDto.getHallNo(), row, col);
				log.debug("좌석 번호{}",seatNo);
				ReservationDetailDto reservationDetailDto = new ReservationDetailDto();
				reservationDetailDto.setReservationNo(reservationDto.getReservationNo());
				reservationDetailDto.setScheduleTimeNo(scheduleTimeNo);
				reservationDetailDto.setSeatRows(row);
				reservationDetailDto.setSeatCols(col);
				reservationDetailDto.setHallType(hallType);
				if(ageNormal > 0) {
					int ageDicountPrice = ageDiscountDao.getPrice("일반");	
					reservationDetailDto.setAgeName("일반");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageNormal--;
				}else if(ageYoung>0) {
					int ageDicountPrice = ageDiscountDao.getPrice("청소년");
					reservationDetailDto.setAgeName("청소년");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageYoung--;	
				}else if(ageOld>0) {
					int ageDicountPrice = ageDiscountDao.getPrice("경로");
					reservationDetailDto.setAgeName("경로");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageOld--;
				}
				reservationDetailDto.setScheduleTimeDiscountType(ScheduleTimeDto.getScheduleTimeDiscountType());
				reservationDetailDto.setScheduleTimeDiscountPrice(ScheduleTimeDto.getScheduleTimeDiscountPrice());
				reservationDetailDto.setReservationDetailStatus("미결제");
				
				int totalDetailReservationPice = reservationDetailDto.getHallPrice() +
						reservationDetailDto.getAgeDiscountPrice() + reservationDetailDto.getScheduleTimeDiscountPrice();
				reservationDetailDto.setReservationDetailPrice(totalDetailReservationPice);
				
				totalReservationPice += totalDetailReservationPice;
				
				reservationDetailDao.insert(reservationDetailDto);
			}
			
			reservationDao.updatePrice(reservationDto.getReservationNo(),totalReservationPice);
			//상세의 각각 금액 => 기본금 - 연령 할인금 - 상영 할인금
	}


	@Override
	public List<ReservationVO> getSeatVOList(int scheduleTimeNo) {
		//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
				ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);

				List<SeatDto> seatList = seatDao.list(scheduleTimeDto.getHallNo());
				List<ReservationDetailDto> reservationDetailList = reservationDetailDao.list(scheduleTimeNo);

				List<ReservationVO> reservationVOList = new ArrayList<>();
				
				for(SeatDto seatDto : seatList) {
					ReservationVO reservationVO = new ReservationVO();
					
					reservationVO.setSeatNo(seatDto.getSeatNo());
					reservationVO.setSeatRows(seatDto.getSeatRows());
					reservationVO.setSeatCols(seatDto.getSeatCols());
					reservationVO.setSeatStatus(seatDto.getSeatStatus());
					
					if(!reservationDetailList.isEmpty()) {		
						for(ReservationDetailDto reservationDetailDto : reservationDetailList) {
							if(seatDto.getSeatNo() == reservationDetailDto.getSeatNo()) {
								reservationVO.setSeatStatus("disabled");
								break;
							}
						}
					}
					reservationVOList.add(reservationVO);
				}
				return reservationVOList;
	}


}
