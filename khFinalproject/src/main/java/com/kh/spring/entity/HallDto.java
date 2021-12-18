package com.kh.spring.entity;

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
}
