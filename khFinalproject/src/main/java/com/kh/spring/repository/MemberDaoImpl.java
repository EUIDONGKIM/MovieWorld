package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberDto> list() {
		return sqlSession.selectList("member.list");
	}

	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join", memberDto);
	}

	@Override
	public MemberDto get(String memberId) {
		return sqlSession.selectOne("member.get", memberId);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberEmail());
		
		if(findDto != null && memberDto.getMemberPw().equals(findDto.getMemberPw())) {
			return findDto;
		}else {
			return null;
		}
		
	}

	@Override
	public boolean changePassword(String memberId, String memberPw, String changePw) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean changeInformation(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean quit(String memberId, String memberPw) {
		// TODO Auto-generated method stub
		return false;
	}

}
