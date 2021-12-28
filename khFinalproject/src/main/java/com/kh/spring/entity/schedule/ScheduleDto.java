package com.kh.spring.entity.schedule;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleDto {
	private int scheduleNo;
	private int theaterNo;
	private int movieNo;
	private String scheduleStart;
	private String scheduleEnd;
}
