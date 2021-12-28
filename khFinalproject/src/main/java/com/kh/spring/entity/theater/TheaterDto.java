package com.kh.spring.entity.theater;

import java.sql.Date;

import lombok.Data;

@Data
public class TheaterDto {
	private int theaterNo;
	private String theaterName;
	private String theaterAddress;
	private String theaterDetailAddress;
	private String theaterSido;
	private String theaterInfo;
	
	//영화관 전체 주소 보여주기
	public String getTheaterFullAddress() {
		return theaterAddress + " " +  theaterDetailAddress;
	}
}
