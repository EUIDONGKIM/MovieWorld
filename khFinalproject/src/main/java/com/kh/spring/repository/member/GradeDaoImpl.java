package com.kh.spring.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GradeDaoImpl implements GradeDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int get(String memberGrade) {
		return sqlSession.selectOne("grade.get",memberGrade);
	}
}
