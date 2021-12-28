package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.ReservationDetailDto;

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

}
