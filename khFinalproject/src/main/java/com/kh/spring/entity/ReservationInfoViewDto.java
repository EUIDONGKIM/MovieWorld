package com.kh.spring.entity;

import lombok.Data;

@Data
public class ReservationInfoViewDto {
	private int scheduleTimeNo;
	private String scheduleTimeDate;
	private String scheduleTimeTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int scheduleNo;
	private int movieNo;
	private String scheduleStart;
	private String scheduleEnd;
	private int hallNo;
	private int theaterNo;
	private String hallName;
	private String hallType;
	private int hallRows;
	private int hallCols;
	private int hallSeat;
}
