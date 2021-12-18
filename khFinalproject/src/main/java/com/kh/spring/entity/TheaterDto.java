package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class TheaterDto {
	private int theaterNo;
	private String theaterName;
	private String theaterAddress;
	private String theaterInfo;
	private String theaterSido;
}
