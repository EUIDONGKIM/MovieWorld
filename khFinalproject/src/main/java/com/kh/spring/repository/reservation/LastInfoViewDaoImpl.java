package com.kh.spring.repository.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.vo.ChartVO;

@Repository
public class LastInfoViewDaoImpl implements LastInfoViewDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<LastInfoViewDto> getByTheaterAndDate(int theaterNo, String day) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("day",day);
		return sqlSession.selectList("lastInfoView.getByTheaterAndDate",param);
	}

	@Override
	public List<Integer> getMovieNo(int theaterNo, String day) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("day",day);
		return sqlSession.selectList("lastInfoView.getMovieNo",param);
	}

	@Override
	public List<LastInfoViewDto> listByMoiveNoForMap(int theaterNo, String day, int movieNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("day",day);
		param.put("movieNo",movieNo);
		return sqlSession.selectList("lastInfoView.listByMoiveNoForMap",param);
	}

	@Override
	public List<Integer> hallNoList(int theaterNo, String day, int movieNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("day",day);
		param.put("movieNo",movieNo);
		return sqlSession.selectList("lastInfoView.hallNoList",param);
	}

	@Override
	public List<LastInfoViewDto> listByhallNoForMap(int theaterNo, String day, int movieNo, int hallNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("theaterNo",theaterNo);
		param.put("day",day);
		param.put("movieNo",movieNo);
		param.put("hallNo",hallNo);
		return sqlSession.selectList("lastInfoView.listByhallNoForMap",param);
	}

	@Override
	public LastInfoViewDto get(int scheduleTimeNo) {
		return sqlSession.selectOne("lastInfoView.getByNo",scheduleTimeNo);
	}

	@Override
	public List<ChartVO> countByTotal() {
		return sqlSession.selectList("lastInfoView.countByTotal");
	}

	@Override
	public List<ChartVO> countByProfit() {
		return sqlSession.selectList("lastInfoView.countByProfit");
	}

}
