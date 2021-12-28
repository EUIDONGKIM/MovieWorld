package com.kh.spring.entity.member;

import java.sql.Date;

import lombok.Data;
@Data
public class CertificationDto {
	private String serial;
	private String memberEmail;
	private Date when;
}
