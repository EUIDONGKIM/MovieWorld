package com.kh.spring.entity;

import lombok.Data;

@Data
public class ScheduleTimeDto {
	private int scheduleNo;
	private String scheduleTimeDate;
	private String scheduleTimeTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
}
