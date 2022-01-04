package com.kh.spring.repository.reservation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.vo.ChartVO;

@Repository
public class StatisticsInfoViewDaoImpl implements StatisticsInfoViewDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ChartVO> countByReservation() {
		return sqlSession.selectList("statisticsInfoView.countByReservation");
	}

	@Override
	public List<ChartVO> countByGenderForMovie() {
		return sqlSession.selectList("statisticsInfoView.countByGenderForMovie");
	}

	@Override
	public List<ChartVO> countByGenderForTotal() {
		return sqlSession.selectList("statisticsInfoView.countByGenderForTotal");
	}

	@Override
	public List<ChartVO> countByAgeForMoive() {
		return sqlSession.selectList("statisticsInfoView.countByAgeForMoive");
	}

	@Override
	public List<ChartVO> countByAgeForTotal() {
		return sqlSession.selectList("statisticsInfoView.countByAgeForTotal");
	}

	@Override
	public List<ChartVO> totalReservationByTheater() {
		return sqlSession.selectList("statisticsInfoView.totalReservationByTheater");
	}

	@Override
	public List<ChartVO> countByGradeReservation() {
		return sqlSession.selectList("statisticsInfoView.countByGradeReservation");
	}

	@Override
	public List<ChartVO> countReservationBySido() {
		return sqlSession.selectList("statisticsInfoView.countReservationBySido");
	}

	@Override
	public List<String> movieTitleBymemberNo(int memberNo) {
		return sqlSession.selectList("movieTitleBymemberNo",memberNo);
	}

	@Override
	public List<ChartVO> countForReservationRatio() {
		return sqlSession.selectList("statisticsInfoView.countByReservation");
	}
	
}
