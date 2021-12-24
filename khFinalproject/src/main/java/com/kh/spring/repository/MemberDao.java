package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.MemberDto;

public interface MemberDao {
	//회원가입
	void join(MemberDto memberDto);
	//단일 조회
	MemberDto get(String memberEmail);
	//로그인
	MemberDto login(MemberDto memberDto);
	
	//비밀번호 변경
	boolean changePassword(String membeEmail, String memberPw, String changePw);
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);

	//회원 탈퇴
	boolean quit(String membeEmail, String memberPw);
	
	List<MemberDto> list();
}
