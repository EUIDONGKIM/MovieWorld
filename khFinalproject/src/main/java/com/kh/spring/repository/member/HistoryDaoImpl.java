package com.kh.spring.repository.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.member.HistoryDto;
@Repository
public class HistoryDaoImpl implements HistoryDao {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void insert(HistoryDto historyDto) {
		sqlSession.insert("history.insert",historyDto);
	}
	@Override
	public List<HistoryDto> list(String memberEmail) {
	
		return sqlSession.selectList("history.findMemberEmail",memberEmail);
	}
	@Override
	public HistoryDto get(int historyNo) {
		return sqlSession.selectOne("history.get",historyNo);
	}
	
}
