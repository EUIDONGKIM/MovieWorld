package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class TotalInfoViewDto {
	private int scheduleNo;
	private int movieNo;
	private int theaterNo;
	private Date scheduleStart;
	private Date scheduleEnd;
	private String movieGrade;
	private String movieTitle;
	private String movieEngTitle;
	private int movieRuntime;
	private String theaterSido;
	private String theaterName;
}
