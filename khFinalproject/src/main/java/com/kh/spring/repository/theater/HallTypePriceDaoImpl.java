package com.kh.spring.repository.theater;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.theater.HallTypePriceDto;

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

	@Override
	public void insert(HallTypePriceDto hallTypePriceDto) {
		sqlSession.insert("hallTypePrice.insert",hallTypePriceDto);
	}

	@Override
	public boolean delete(int hallTypeNo) {
		return sqlSession.delete("hallTypePrice.delete", hallTypeNo) > 0;
	}

	@Override
	public void edit(HallTypePriceDto hallTypePriceDto) {
		sqlSession.update("hallTypePrice.edit", hallTypePriceDto);
	}
	
}
