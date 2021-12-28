package com.kh.spring.repository.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.TheaterNameBySidoVO;

@Repository
public class ReservationInfoViewDaoImpl implements ReservationInfoViewDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ReservationInfoViewDto get(int scheduleTimeNo) {
		return sqlSession.selectOne("reservationInfoView.get",scheduleTimeNo);
	}

	@Override
	public List<MovieCountVO> listMoiveByCount() {
		return sqlSession.selectList("reservationInfoView.listMoiveByCount");
	}

	@Override
	public List<String> listSidoByMovie(int movieNo) {
		return sqlSession.selectList("reservationInfoView.listSidoByMovie",movieNo);
	}

	@Override
	public List<TheaterNameBySidoVO> getTheaterNames(int movieNo, String theaterSido) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo",movieNo);
		param.put("theaterSido",theaterSido);
		
		return sqlSession.selectList("reservationInfoView.getTheaterNames",param);
	}

	@Override
	public List<MovieCountVO> listMoiveComplexSearch(String theaterSido, int theaterNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("theaterSido",theaterSido);
		
		return sqlSession.selectList("reservationInfoView.listMoiveComplexSearch",param);
	}

}