package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationDetailDto {
	private int reservationNo;
	private int seatNo;
	private String seatName;
	private int scheduleTimeNo;
	private int hallPrice;
	private int ageName;
	private int ageDiscountPrice;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private String reservationDetailStatus;
}