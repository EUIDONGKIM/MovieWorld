package com.kh.spring.repository.member;

import java.util.List;

import com.kh.spring.entity.member.MemberDto;

public interface MemberDao {
	//회원가입
	void join(MemberDto memberDto);
	//단일 조회
	MemberDto get(String memberEmail);
	//로그인
	MemberDto login(MemberDto memberDto);
	
	//아이디 찾기
	MemberDto findId(String memberName ,String memberPhone);
	//비밀번호 찾기
	MemberDto findPw(String memberName, String memberEmail , String memberPhone);
	
	//비밀번호 변경
	boolean changePassword(String membeEmail, String memberPw, String changePw);
	//임시 비빌번호 변경
//	boolean temporayPassword(String memberEmail , String memberName , String memberPhone , String temporayPassword);
	boolean temporayPassword(MemberDto memberDto,String ChangePw);
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);
	
	//회원 탈퇴
	boolean quit(String memberEmail, String memberPw);

	
	
	List<MemberDto> list();
}
