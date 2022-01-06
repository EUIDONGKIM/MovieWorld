package com.kh.spring.repository.reservation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.reservation.AgeDiscountDto;

@Repository
public class AgeDiscountDaoImpl implements AgeDiscountDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getPrice(String ageName) {
		return sqlSession.selectOne("ageDiscount.getPrice",ageName);
	}

	@Override
	public List<AgeDiscountDto> list() {
		return sqlSession.selectList("ageDiscount.list");
	}

	@Override
	public void insert(AgeDiscountDto ageDiscountDto) {
		sqlSession.insert("ageDiscount.insert",ageDiscountDto);
	}

	@Override
	public boolean delete(int ageNo) {
		return sqlSession.delete("ageDiscount.delete",ageNo) > 0;
	}

	@Override
	public void edit(AgeDiscountDto ageDiscountDto) {
		sqlSession.update("ageDiscount.edit",ageDiscountDto);
	}
	
	
}
