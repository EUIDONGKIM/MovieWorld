package com.kh.spring.repository.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.vo.ReservationListVO;

@Repository
public class ReservationDaoImpl implements ReservationDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("reservation.getSequence");
	}

	@Override
	public void insert(ReservationDto reservationDto) {
		sqlSession.insert("reservation.insert",reservationDto);
	}

	@Override
	public ReservationDto get(int reservationNo) {
		return sqlSession.selectOne("reservation.get",reservationNo);
	}

	@Override
	public void updatePrice(int reservationNo, int totalReservationPice) {
		Map<String,Object> param = new HashMap<>();
		param.put("reservationNo",reservationNo);
		param.put("totalAmount",totalReservationPice);
		
		sqlSession.update("reservation.updatePrice",param);
	}

	@Override
	public boolean remove(int reservationNo) {
		return sqlSession.delete("reservation.remove",reservationNo)>0;
	}

	@Override
	public void clean() {
		sqlSession.delete("reservation.clean");
	}

	@Override
	public void approve(ReservationDto reservationDto) {
		sqlSession.update("reservation.approve",reservationDto);
	}

	@Override
	public void cancel(int reservationNo) {
		sqlSession.update("reservation.cancel",reservationNo);
	}

	@Override
	public List<ReservationDto> list(int memberNo) {
		return sqlSession.selectList("reservation.getMemberNo",memberNo);
	}

	@Override
	public List<ReservationDto> listByPage(int memberNo, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("reservation.listByPage",param);
	}

	@Override
	public int count(String column, String keyword) {
		Map<String,Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectOne("reservation.count",param);
	}

	@Override
	public List<ReservationListVO> serach(String column, String keyword, int begin, int end) {
		Map<String,Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		param.put("begin", begin);
		param.put("end", end);
		return sqlSession.selectList("reservation.serach",param);
	}

	@Override
	public List<ReservationDto> paymentCompletedListByScheduleTimeNo(int scheduleTimeNo) {
		return sqlSession.selectList("reservation.exist", scheduleTimeNo);
	}


}
