package com.kh.spring.entity.member;

import java.sql.Date;

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
	private Date memberJoin;
	
	public String getMemberBirthDay() {
			return this.memberBirth.substring(0,10);
	}



}
