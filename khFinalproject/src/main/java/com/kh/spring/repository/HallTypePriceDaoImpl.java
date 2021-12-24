package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HallTypePriceDaoImpl implements HallTypePriceDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getPrice(String hallType) {
		return sqlSession.selectOne("hallTypePrice.getPrice",hallType);
	}
	
}
