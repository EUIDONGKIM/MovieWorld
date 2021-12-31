package com.kh.spring.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ShowRealTimeVO {
	private int hallNo;
	private String hallType;
	private String hallName;
	private int hallSeat;
	private int scheduleTimeNo;
	private int scheduleNo;
	private Date scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int disabledSeat;
}
