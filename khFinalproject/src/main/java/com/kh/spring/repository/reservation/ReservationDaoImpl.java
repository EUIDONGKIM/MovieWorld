package com.kh.spring.repository.reservation;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.ReservationDto;

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

}
