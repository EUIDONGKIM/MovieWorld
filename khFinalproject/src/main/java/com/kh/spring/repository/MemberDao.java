package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.MemberDto;

public interface MemberDao {
	List<MemberDto> list();
}
