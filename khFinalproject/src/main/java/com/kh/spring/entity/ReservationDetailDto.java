package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationDetailDto {
	private int reservationNo;
	private int seatNo;
	private int seatRows;
	private int seatCols;
	private int scheduleTimeNo;
	private String hallType;
	private int hallPrice;
	private int ageName;
	private int ageDiscountPrice;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private String reservationDetailStatus;
}
