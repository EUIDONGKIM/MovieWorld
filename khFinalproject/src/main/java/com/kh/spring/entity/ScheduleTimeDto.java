package com.kh.spring.entity;

import lombok.Data;

@Data
public class ScheduleTimeDto {
	private int scheduleTimeNo;
	private int scheduleNo;
	private String scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int hallNo;
}
