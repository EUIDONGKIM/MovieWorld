package com.kh.spring.repository.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.member.MemberDto;

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
	public MemberDto get2(int memberNo) {
		return sqlSession.selectOne("member.get2", memberNo);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberEmail());
		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
		
	}
	//비밀번호 변경
	@Override
	public boolean changePassword(String memberEmail, String memberPw, String changePw) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberEmail", memberEmail);
		param.put("memberPw", memberPw);
		//암호화 하여 바꿀비밀번호입력 
		String origin = changePw;
		String encrypt = encoder.encode(origin);
		String updatePw=encrypt;
		param.put("changePw", updatePw);
	
		
		int count = sqlSession.update("member.changePassword", param);
		return count > 0;
	
	}
	

	@Override
	public boolean changeInformation(MemberDto memberDto,String memberPw) {
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberEmail());
		int count;
		//단일조회된 비밀번호와 입력된 비밀번호가 맞다면 업데이트를 진행.
		if(findDto !=null && encoder.matches(memberPw, findDto.getMemberPw())) {
			count = sqlSession.update("member.changeInformation", memberDto);
			return count > 0;			
		}else {
			return false;
		}
				
	}
	
	@Override
	public boolean changeInformationAdmin(MemberDto memberDto) {
		int count = sqlSession.update("member.changeInformation", memberDto);
		return count > 0;			
	}

	@Override
	public boolean quit(String memberEmail, String memberPw) {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberEmail(memberEmail);
		memberDto.setMemberPw(memberPw);
		int count = sqlSession.delete("member.quit", memberDto);
		return count > 0;
	}
	
	@Override
	public boolean adminDrop(int memberNo) {
		int result = sqlSession.delete("member.adminDrop",memberNo);
		return result>0;
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

		
		param.put("memberEmail", memberDto.getMemberEmail());
		param.put("memberName", memberDto.getMemberName());
		param.put("memberPhone",memberDto.getMemberPhone());
		param.put("memberPw",memberDto.getMemberPw());
		
		//원래 비밀번호를 암호화 하여서 비밀번호 업데이트 
		int result=sqlSession.update("member.temporayPassword",param);
		return result>0;
	}

	@Override
	public int count(String column, String keyword) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		return sqlSession.selectOne("member.count",param);
	}

	@Override
	public List<MemberDto> search(String column, String keyword, int begin, int end) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("begin",begin);
		param.put("end",end);
		return sqlSession.selectList("member.search",param);
	}

	@Override
	public void usePoint(int memberNo, int memberPoint) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberNo",memberNo);
		param.put("memberPoint",memberPoint);
		
		sqlSession.update("member.updatePoint",param);
	}

	@Override
	public void returnPoint(int memberNo, int memberPoint) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberNo",memberNo);
		param.put("memberPoint",memberPoint);
		
		sqlSession.update("member.returnPoint",param);
	}

	@Override
	public void updateGrade() {
		sqlSession.update("member.updateGrade");
	}









}
