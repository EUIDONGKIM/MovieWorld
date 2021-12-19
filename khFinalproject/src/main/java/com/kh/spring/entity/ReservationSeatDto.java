package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationSeatDto {
	private int reservationNo;
	private int seatNo;
	private int scheduleTimeNo;
	private int hallPrice;
	private int ageDiscountPrice;
	private int scheduleDiscountPrice;
	private int memberDiscountPrice;
}
