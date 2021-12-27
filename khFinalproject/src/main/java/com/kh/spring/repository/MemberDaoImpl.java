package com.kh.spring.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public List<MemberDto> list() {
		return sqlSession.selectList("member.list");
	}

	@Override
	public void join(MemberDto memberDto) {
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		
		sqlSession.insert("member.join", memberDto);
	}

	@Override
	public MemberDto get(String membeEmail) {
		return sqlSession.selectOne("member.get", membeEmail);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
//		System.err.println(memberDto.getMemberPw());
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberEmail());
//		System.err.println(findDto.getMemberPw());
		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
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

	@Override
	public MemberDto findId(String memberName, String memberPhone) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberName", memberName);
		param.put("memberPhone",memberPhone);
		
		return sqlSession.selectOne("member.findId",param);
	}
	
	@Override
	public MemberDto findPw(String memberName, String memberEmail, String memberPhone) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberName", memberName);
		param.put("memberEmail", memberEmail);
		param.put("memberPhone",memberPhone);
		
		return sqlSession.selectOne("member.findPw",param);
	}

	
	@Override
	public boolean temporayPassword(MemberDto memberDto,String ChangePw) {
		Map<String ,Object> param = new HashMap<>();
		//받은 난수를 암호화 하여 업데이트 진행
		String origin =	ChangePw;
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		System.out.println(memberDto.getMemberPw());
		
		param.put("memberEmail", memberDto.getMemberEmail());
		param.put("memberName", memberDto.getMemberName());
		param.put("memberPhone",memberDto.getMemberPhone());
		param.put("memberPw",memberDto.getMemberPw());
		
		//원래 비밀번호를 암호화 하여서 비밀번호 업데이트 
		int result=sqlSession.update("member.temporayPassword",param);
		return result>0;
	}

}
