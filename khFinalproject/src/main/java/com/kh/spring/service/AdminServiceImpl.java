package com.kh.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.vo.MemberSearchVO;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	private MemberDao memberDao;
	@Override
	public MemberSearchVO searchNPaging(MemberSearchVO memberSearchVO) throws Exception {
		int count = memberDao.count(memberSearchVO.getColumn(),memberSearchVO.getKeyword());
		memberSearchVO.setCount(count);
		memberSearchVO.calculate();
		List<MemberDto> list = memberDao.search(memberSearchVO.getColumn(), memberSearchVO.getKeyword(),memberSearchVO.getBegin(),memberSearchVO.getEnd());
		memberSearchVO.setList(list);
		return memberSearchVO;
	}
	



}
