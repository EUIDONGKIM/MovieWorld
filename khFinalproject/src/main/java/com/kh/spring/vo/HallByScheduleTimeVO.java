package com.kh.spring.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class HallByScheduleTimeVO {
	private int hallNo;
	private int theaterNo;
	private String hallType;
	private String hallName;
	private int hallRows;
	private int hallCols;
	private int hallSeat;
	private int scheduleTimeNo;
	private int scheduleNo;
	private Date scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int scheduleTimeCount;
	private int scheduleTimeSum;
}
