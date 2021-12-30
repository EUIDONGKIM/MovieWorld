package com.kh.spring.entity.reservation;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationDto {
	private int reservationNo;
	private int memberNo;
	private String tid;
	private String itemName;
	private int scheduleTimeNo;
	private Date scheduleTimeDateTime;
	private int reservationTotalNumber;
	private String buyTime;
	private int pointUse;
	private long totalAmount;
	private String reservationStatus;
}
