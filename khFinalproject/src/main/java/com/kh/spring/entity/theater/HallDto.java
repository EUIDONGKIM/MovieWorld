package com.kh.spring.entity.theater;

import java.sql.Date;

import lombok.Data;

@Data
public class HallDto {
	private int hallNo;
	private int theaterNo;
	private String hallType;
	private String hallName;
	private int hallRows;
	private int hallCols;
	private int hallSeat;
	
	//1관[아이맥스] 형식으로 보여주는 메소드
	public String getFullName() {
		return hallName + "[" + hallType + "]" ;
	}
}
