package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationDto {
	private int reservationNo;
	private int memberNo;
	private int scheduleTimeNo;
	private String scheduleTimeTime;
	private int reservationTotalNumber;
	private Date reservationDate;
	private int reservationTotalPrice;
}
