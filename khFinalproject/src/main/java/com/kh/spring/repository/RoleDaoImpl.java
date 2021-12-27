package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.RoleDto;

@Repository
public class RoleDaoImpl implements RoleDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(RoleDto roleDto) {
		sqlSession.insert("role.insert",roleDto);
	}
	
}
