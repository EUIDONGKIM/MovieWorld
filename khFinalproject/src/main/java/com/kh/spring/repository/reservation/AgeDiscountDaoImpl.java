package com.kh.spring.repository.reservation;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AgeDiscountDaoImpl implements AgeDiscountDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getPrice(String ageName) {
		return sqlSession.selectOne("ageDiscount.getPrice",ageName);
	}
	
	
}