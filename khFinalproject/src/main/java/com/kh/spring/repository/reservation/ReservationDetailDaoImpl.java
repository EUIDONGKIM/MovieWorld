package com.kh.spring.repository.reservation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.ReservationDetailDto;

@Repository
public class ReservationDetailDaoImpl implements ReservationDetailDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ReservationDetailDto> list(int scheduleTimeNo) {
		return sqlSession.selectList("reservationDetail.list",scheduleTimeNo);
	}

	@Override
	public void insert(ReservationDetailDto reservationDetailDto) {
		sqlSession.insert("reservationDetail.insert",reservationDetailDto);
	}

	@Override
	public List<ReservationDetailDto> get(int reservationNo) {
		return sqlSession.selectList("reservationDetail.get",reservationNo);
	}

	@Override
	public boolean remove(int reservationNo) {
		return sqlSession.delete("reservationDetail.remove",reservationNo)>0;
	}

	@Override
	public void approve(int reservationNo) {
		sqlSession.update("reservationDetail.approve",reservationNo);
	}

	@Override
	public void cancel(int reservationNo) {
		sqlSession.update("reservationDetail.cancel",reservationNo);
	}

}
