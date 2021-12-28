package com.kh.spring.entity.reservation;

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
	private String ageName;
	private int ageDiscountPrice;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int reservationDetailPrice;
	private String reservationDetailStatus;
}
