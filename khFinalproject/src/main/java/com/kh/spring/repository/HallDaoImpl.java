package com.kh.spring.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.HallTypePriceDto;

@Repository
public class HallDaoImpl implements HallDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<HallTypePriceDto> getHallTypeList() {
		return sqlSession.selectList("hall.getHallTypeList");
	}

	@Override
	public void insert(HallDto hallDto) {
		sqlSession.insert("hall.insert",hallDto);
	}

	@Override
	public void update(int hallNo, int hallSeat) {
		Map<String,Object> param = new HashMap<>();
		param.put("hallNo",hallNo);
		param.put("hallSeat",hallSeat);
		
		sqlSession.update("hall.update", param);
	}

	@Override
	public int getSeq() {
		return sqlSession.selectOne("hall.getSeq");
	}

	@Override
	public List<HallDto> list() {
		return sqlSession.selectList("hall.list");
	}
	
	
}
