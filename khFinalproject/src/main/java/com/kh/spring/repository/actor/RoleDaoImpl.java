package com.kh.spring.repository.actor;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.actor.RoleDto;

@Repository
public class RoleDaoImpl implements RoleDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(RoleDto roleDto) {
		sqlSession.insert("role.insert",roleDto);
	}

	@Override
	public boolean delete(int actorNo) {
		return sqlSession.delete("role.delete",actorNo)>0;
	}
	
}
