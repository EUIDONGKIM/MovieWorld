package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleDto {
	private int scheduleNo;
	private int hallNo;
	private int movieNo;
	private String scheduleDate;
	private String scheduleTime;
	private String scheduleStart;
	private String scheduleEnd;
}
