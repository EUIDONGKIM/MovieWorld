package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.HallTypePriceDto;

@Repository
public class HallTypePriceDaoImpl implements HallTypePriceDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getPrice(String hallType) {
		return sqlSession.selectOne("hallTypePrice.getPrice",hallType);
	}

	@Override
	public List<HallTypePriceDto> list() {
		return sqlSession.selectList("hallTypePrice.list");
	}
	
}
