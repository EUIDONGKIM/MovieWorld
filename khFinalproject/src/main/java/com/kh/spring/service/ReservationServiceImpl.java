package com.kh.spring.service;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.member.HistoryDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.SeatDto;
import com.kh.spring.repository.member.GradeDao;
import com.kh.spring.repository.member.HistoryDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.AgeDiscountDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.vo.KakaoPayApproveRequestVO;
import com.kh.spring.vo.KakaoPayApproveResponseVO;
import com.kh.spring.vo.KakaoPayCancelResponseVO;
import com.kh.spring.vo.KakaoPayReadyRequestVO;
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
	@Autowired
	private KakaoPayService kakaoPayService;
	@Autowired
	private GradeDao gradeDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private HistoryDao historyDao;
	@Override
	public void insert(String seatData,int reservationKey ,int scheduleTimeNo, int ageNormal, int ageYoung, int ageOld, int memberNo) {
			//총 인원
			int total = ageNormal + ageYoung + ageOld;
			//임시 예약 테이블 생성.
			ReservationDto reservationDto = new ReservationDto();
			
			ScheduleTimeDto ScheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);
			
			reservationDto.setReservationNo(reservationKey);
			reservationDto.setMemberNo(memberNo);
			reservationDto.setTid(UUID.randomUUID().toString());
			reservationDto.setScheduleTimeNo(scheduleTimeNo);
			reservationDto.setScheduleTimeDateTime(ScheduleTimeDto.getScheduleTimeDateTime());
			reservationDto.setReservationTotalNumber(total);
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
					
			String[] seat = new String[total];
			
			StringTokenizer seatTotal = new StringTokenizer(seatData,"&");
			int count = 0;
			while(seatTotal.hasMoreTokens()) {
				seat[count] = seatTotal.nextToken();
				seat[count] = seat[count].substring(5);
				count++;
			}
			
			for(int i = 0 ; i<total ; i++) {
				StringTokenizer seatRowsCols = new StringTokenizer(seat[i],"-");
				
				int row = Integer.parseInt(seatRowsCols.nextToken());
				int col = Integer.parseInt(seatRowsCols.nextToken());
				int seatNo = seatDao.getSeatNo(hallDto.getHallNo(), row, col);

				ReservationDetailDto reservationDetailDto = new ReservationDetailDto();
				reservationDetailDto.setReservationNo(reservationDto.getReservationNo());
				reservationDetailDto.setScheduleTimeNo(scheduleTimeNo);
				reservationDetailDto.setSeatRows(row);
				reservationDetailDto.setSeatCols(col);
				reservationDetailDto.setSeatNo(seatNo);
				reservationDetailDto.setHallType(hallType);
				reservationDetailDto.setHallPrice(hallPrice);
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
				
				int totalDetailReservationPice = reservationDetailDto.getHallPrice() -
						reservationDetailDto.getAgeDiscountPrice() - reservationDetailDto.getScheduleTimeDiscountPrice();
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
							if(!reservationDetailDto.getReservationDetailStatus().equals("결제취소") && 
								seatDto.getSeatNo() == reservationDetailDto.getSeatNo()) {
								
								reservationVO.setSeatStatus("disabled");
								break;
							}
						}
					}
					reservationVOList.add(reservationVO);
				}
				return reservationVOList;
	}
	
	@Override
	public int getSeatRest(int scheduleTimeNo) {
		//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
				ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);
				List<SeatDto> seatList = seatDao.list(scheduleTimeDto.getHallNo());
				List<ReservationDetailDto> reservationDetailList = reservationDetailDao.list(scheduleTimeNo);
				int count = 0;
				for(SeatDto seatDto : seatList) {

					
					if(!reservationDetailList.isEmpty()) {		
						for(ReservationDetailDto reservationDetailDto : reservationDetailList) {
							if(!reservationDetailDto.getReservationDetailStatus().equals("결제취소") && 
								seatDto.getSeatNo() == reservationDetailDto.getSeatNo()) {
								
								count++;
								break;
							}
						}
					}

				}
				return count;
	}
	

	@Override
	public boolean remove(int reservationNo) {
		boolean main = reservationDao.remove(reservationNo);
		boolean detail = reservationDetailDao.remove(reservationNo);
		
		return main&&detail;
	}


	@Override
	public void clean() {
		reservationDao.clean();
	}


	@Override
	public KakaoPayReadyRequestVO getRequestVO(int reservationNo, int memberPoint,String memberEmail) {
		
		ReservationDto reservationDto = reservationDao.get(reservationNo);
		List<ReservationDetailDto> rList = reservationDetailDao.get(reservationNo);
		
		String item_name = String.valueOf(rList.get(0).getSeatRows())+"행"+
				String.valueOf(rList.get(0).getSeatCols())+"열";

		if(rList.size()>1)
		item_name += " 외 "+(rList.size()-1)+"건";
		
		long total = (long)(reservationDto.getTotalAmount()-memberPoint);
		
		KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
		requestVO.setPartner_order_id(String.valueOf(reservationDto.getReservationNo()));
		requestVO.setPartner_user_id(memberEmail);
		requestVO.setItem_name(item_name);
		requestVO.setQuantity(1);
		requestVO.setTotal_amount(total);
		
		return requestVO;
	}


	@Override
	public int getReservationNo(String partner_order_id, String partner_user_id, String tid,String pg_token, int memberPoint, int memberNo) throws URISyntaxException {
		KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
		requestVO.setTid(tid);
		requestVO.setPartner_order_id(partner_order_id);
		requestVO.setPartner_user_id(partner_user_id);
		requestVO.setPg_token(pg_token);
		
		KakaoPayApproveResponseVO responseVO = kakaoPayService.approve(requestVO);
		
		//결제가 완료된 시점에 update시행
		ReservationDto reservationDto = reservationDao.get(Integer.parseInt(partner_order_id));
		reservationDto.setTid(tid);
		reservationDto.setItemName(responseVO.getItem_name());
		reservationDto.setReservationStatus("결제완료");
		reservationDto.setPointUse(memberPoint);
		
		reservationDao.approve(reservationDto);
		reservationDetailDao.approve(reservationDto.getReservationNo());
		
		//모두 완료되면 해당 회차의 총 인원과 총 금액을 업데이트 시켜준다. / 포인트 사용내역
		ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
		scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
		scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
		scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
		scheduleTimeDao.reservationUpdate(scheduleTimeDto);
		
		memberDao.usePoint(memberNo,memberPoint);
		MemberDto memberDto = memberDao.get2(memberNo);
		HistoryDto historyDto =new HistoryDto();
		//예매시 포인트 사용 
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(memberPoint);
		historyDto.setHistoryMemo("포인트 사용");
		historyDao.insert(historyDto);
		
		int pointPercent = gradeDao.get(memberDto.getMemberGrade());
		
		int pointByPay = ((int)reservationDto.getTotalAmount() - memberPoint) * pointPercent / 100;
		memberDao.returnPoint(memberNo, pointByPay);
		//예매시 포인트 적립
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(pointByPay);
		historyDto.setHistoryMemo("포인트 적립");
		historyDao.insert(historyDto);
		return reservationDto.getReservationNo();
	}


	@Override
	public void cancel(int reservationNo, int memberNo) throws URISyntaxException {
		//(1)
		ReservationDto reservationDto = reservationDao.get(reservationNo);

		//(2) 취소 가능한 금액을 계산해야 한다
		long amount = (reservationDto.getTotalAmount()-reservationDto.getPointUse());

		//(3) 취소 처리를 수행한다
		KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(reservationDto.getTid(), amount);

		//(4) DB를 갱신
		reservationDao.cancel(reservationNo);
		reservationDetailDao.cancel(reservationNo);

		//(5) 상영회차의 금액 변경(통계 차감)
		ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
		scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
		scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
		scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
		scheduleTimeDao.reservationMinusUpdate(scheduleTimeDto);
		
		memberDao.returnPoint(memberNo,reservationDto.getPointUse());
		//예매 취소시 포인트 취소
		HistoryDto historyDto = new HistoryDto();
		MemberDto memberDto = memberDao.get2(memberNo);
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(reservationDto.getPointUse());
		historyDto.setHistoryMemo("포인트 사용 취소");
		historyDao.insert(historyDto);
		
		int pointPercent = gradeDao.get(memberDto.getMemberGrade());
		int pointByPay = ((int)reservationDto.getTotalAmount() - reservationDto.getPointUse()) * pointPercent / 100;
		//예매 취소시 포인트 취소
		memberDao.usePoint(memberNo, pointByPay);
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(pointByPay);
		historyDto.setHistoryMemo("포인트 적립금 취소");
		historyDao.insert(historyDto);

	}


}
