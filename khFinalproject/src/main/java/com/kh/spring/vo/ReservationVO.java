package com.kh.spring.vo;

import lombok.Data;

@Data
public class ReservationVO {
	private int seatNo;
	private int seatRows;
	private int seatCols;
	private String seatStatus;
}
