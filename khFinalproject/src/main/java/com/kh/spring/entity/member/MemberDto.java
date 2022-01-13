package com.kh.spring.entity.member;

import lombok.Data;

@Data
public class MemberDto {
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberName;
	private String memberNick;
	private String memberGender;
	private String memberBirth;
	private String memberPhone;
	private String memberGrade;
	private int memberPoint;
	private String memberJoin;
	private String memberLogin;
	
	public String getMemberBirthDay() {
			return this.memberBirth.substring(0,10);
	}
	
	public String getMemberJoinDay() {
		return this.memberJoin.substring(0,10);
	}



}
