package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.TotalInfoViewDto;

@Repository
public class TotalInfoViewDaoImpl implements TotalInfoViewDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<TotalInfoViewDto> list() {
		return sqlSession.selectList("totalInfoView.list");
	}
	//추후에 리스트들을 <where>로 통합.
	@Override
	public TotalInfoViewDto get(int hallNo) {
		return sqlSession.selectOne("totalInfoView.getByHallNo",hallNo);
	}
	
	
}
