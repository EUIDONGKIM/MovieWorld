package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class SeatDto {
	private int seatNo;
	private int hallNo;
	private String seatName;
}
