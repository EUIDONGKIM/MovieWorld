package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleDto {
	private int scheduleNo;
	private int theaterNo;
	private int movieNo;
	private Date scheduleDate;
	private Date scheduleTime;
	private Date scheduleStart;
	private Date scheduleEnd;
}
