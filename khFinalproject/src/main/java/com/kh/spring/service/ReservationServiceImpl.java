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
import com.kh.spring.vo.PaginationVO;
import com.kh.spring.vo.ReservationListVO;
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
			//??? ??????
			int total = ageNormal + ageYoung + ageOld;
			//?????? ?????? ????????? ??????.
			ReservationDto reservationDto = new ReservationDto();
			
			ScheduleTimeDto ScheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);
			
			reservationDto.setReservationNo(reservationKey);
			reservationDto.setMemberNo(memberNo);
			reservationDto.setTid(UUID.randomUUID().toString());
			reservationDto.setScheduleTimeNo(scheduleTimeNo);
			reservationDto.setScheduleTimeDateTime(ScheduleTimeDto.getScheduleTimeDateTime());
			reservationDto.setReservationTotalNumber(total);
			reservationDto.setReservationStatus("?????????");
			//?????? ?????? ????????? ??????
			reservationDao.insert(reservationDto);
			//?????? ?????? ??????????????? ?????? ????????? ???????????? ????????? ????????? ?????? ?????? ??? insert ??????
			
			//????????? ?????? ?????? ??? ?????????..
			int totalReservationPice = 0;
			
			//?????? ?????? ?????? ??????. => ???????????? ?????? ???, ??? ????????? ??????????????? ?????? ??? ??? ??????.(???????????? ?????? ???????????? ???????????????..)
			//????????? ?????? ??? ?????? ??? DAO??? ????????????. ????????????
			//?????? ????????? ?????????
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
					int ageDicountPrice = ageDiscountDao.getPrice("??????");	
					reservationDetailDto.setAgeName("??????");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageNormal--;
				}else if(ageYoung>0) {
					int ageDicountPrice = ageDiscountDao.getPrice("?????????");
					reservationDetailDto.setAgeName("?????????");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageYoung--;	
				}else if(ageOld>0) {
					int ageDicountPrice = ageDiscountDao.getPrice("??????");
					reservationDetailDto.setAgeName("??????");
					reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
					ageOld--;
				}
				reservationDetailDto.setScheduleTimeDiscountType(ScheduleTimeDto.getScheduleTimeDiscountType());
				reservationDetailDto.setScheduleTimeDiscountPrice(ScheduleTimeDto.getScheduleTimeDiscountPrice());
				reservationDetailDto.setReservationDetailStatus("?????????");
				
				int totalDetailReservationPice = reservationDetailDto.getHallPrice() -
						reservationDetailDto.getAgeDiscountPrice() - reservationDetailDto.getScheduleTimeDiscountPrice();
				reservationDetailDto.setReservationDetailPrice(totalDetailReservationPice);
				
				totalReservationPice += totalDetailReservationPice;
				reservationDetailDao.insert(reservationDetailDto);
			}
			
			reservationDao.updatePrice(reservationDto.getReservationNo(),totalReservationPice);
			//????????? ?????? ?????? => ????????? - ?????? ????????? - ?????? ?????????
	}


	@Override
	public List<ReservationVO> getSeatVOList(int scheduleTimeNo) {
		//??????????????? ?????? ???????????? ???????????? ????????? ?????????????????? ???????????? ??????
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
							if(!reservationDetailDto.getReservationDetailStatus().equals("????????????") && 
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
		//??????????????? ?????? ???????????? ???????????? ????????? ?????????????????? ???????????? ??????
				ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);
				List<SeatDto> seatList = seatDao.list(scheduleTimeDto.getHallNo());
				List<ReservationDetailDto> reservationDetailList = reservationDetailDao.list(scheduleTimeNo);
				int count = 0;
				for(SeatDto seatDto : seatList) {

					
					if(!reservationDetailList.isEmpty()) {		
						for(ReservationDetailDto reservationDetailDto : reservationDetailList) {
							if(!reservationDetailDto.getReservationDetailStatus().equals("????????????") && 
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
		
		String item_name = String.valueOf(rList.get(0).getSeatRows())+"???"+
				String.valueOf(rList.get(0).getSeatCols())+"???";

		if(rList.size()>1)
		item_name += " ??? "+(rList.size()-1)+"???";
		
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
		
		//????????? ????????? ????????? update??????
		ReservationDto reservationDto = reservationDao.get(Integer.parseInt(partner_order_id));
		reservationDto.setTid(tid);
		reservationDto.setItemName(responseVO.getItem_name());
		reservationDto.setReservationStatus("????????????");
		reservationDto.setPointUse(memberPoint);
		
		reservationDao.approve(reservationDto);
		reservationDetailDao.approve(reservationDto.getReservationNo());
		
		//?????? ???????????? ?????? ????????? ??? ????????? ??? ????????? ???????????? ????????????. / ????????? ????????????
		ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
		scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
		scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
		scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
		scheduleTimeDao.reservationUpdate(scheduleTimeDto);

		MemberDto memberDto = memberDao.get2(memberNo);
		HistoryDto historyDto =new HistoryDto();
		//????????? ????????? ?????? 
		if(memberPoint>0) {
		memberDao.usePoint(memberNo,memberPoint);
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(memberPoint);
		historyDto.setHistoryMemo("????????? ??????");
		historyDao.insert(historyDto);
		}
		
		int pointPercent = gradeDao.get(memberDto.getMemberGrade());
		
		int pointByPay = ((int)reservationDto.getTotalAmount() - memberPoint) * pointPercent / 100;
		memberDao.returnPoint(memberNo, pointByPay);
		//????????? ????????? ??????
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(pointByPay);
		historyDto.setHistoryMemo("????????? ??????");
		historyDao.insert(historyDto);

		return reservationDto.getReservationNo();
	}


	@Override
	public void cancel(int reservationNo, int memberNo) throws URISyntaxException {
		//(1)
		ReservationDto reservationDto = reservationDao.get(reservationNo);

		//(2) ?????? ????????? ????????? ???????????? ??????
		long amount = (reservationDto.getTotalAmount()-reservationDto.getPointUse());

		//(3) ?????? ????????? ????????????
		KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(reservationDto.getTid(), amount);

		//(4) DB??? ??????
		reservationDao.cancel(reservationNo);
		reservationDetailDao.cancel(reservationNo);

		//(5) ??????????????? ?????? ??????(?????? ??????)
		ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
		scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
		scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
		scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
		scheduleTimeDao.reservationMinusUpdate(scheduleTimeDto);
		
		//?????? ????????? ????????? ??????
		HistoryDto historyDto = new HistoryDto();
		MemberDto memberDto = memberDao.get2(memberNo);
		if(reservationDto.getPointUse()>0) {
			
			memberDao.returnPoint(memberNo,reservationDto.getPointUse());
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(reservationDto.getPointUse());
		historyDto.setHistoryMemo("????????? ?????? ??????");
		historyDao.insert(historyDto);
		
		}
		int pointPercent = gradeDao.get(memberDto.getMemberGrade());
		int pointByPay = ((int)reservationDto.getTotalAmount() - reservationDto.getPointUse()) * pointPercent / 100;
		//?????? ????????? ????????? ??????
		memberDao.usePoint(memberNo, pointByPay);
		historyDto.setMemberEmail(memberDto.getMemberEmail());
		historyDto.setHistoryAmount(pointByPay);
		historyDto.setHistoryMemo("????????? ????????? ??????");
		historyDao.insert(historyDto);

	}


	@Override
	public PaginationVO searchNPaging(PaginationVO paginationVO) throws Exception {
		int count = reservationDao.count(paginationVO.getColumn(),paginationVO.getKeyword());
		paginationVO.setCount(count);
		paginationVO.calculate();
		List<ReservationListVO> list = reservationDao.serach(paginationVO.getColumn(),paginationVO.getKeyword(),paginationVO.getBegin(),paginationVO.getEnd());
		paginationVO.setList(list);
		return paginationVO;
	}


}
