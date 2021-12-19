package com.kh.spring.entity;

import lombok.Data;

@Data
public class TotalInfoViewDto {
	private int scheduleNo;
	private int hallNo;
	private int movieNo;
	private int theaterNo;
	private String scheduleStart;
	private String scheduleEnd;
	private String movieGrade;
	private String movieTitle;
	private String movieEngTitle;
	private int movieRuntime;
	private String hallName;
	private String hallType;
	private int hallSeat;
	private String theaterSido;
	private String theaterName;
}
