package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.ReservationInfoViewDto;

@Repository
public class ReservationInfoViewDaoImpl implements ReservationInfoViewDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ReservationInfoViewDto get(int scheduleTimeNo) {
		return sqlSession.selectOne("reservationInfoView.get",scheduleTimeNo);
	}

}
