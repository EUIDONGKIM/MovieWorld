package com.kh.spring.vo;

import lombok.Data;

@Data
public class ReservationListVO {
	private int reservationNo;
	private int memberNo;
	private String memberName;
	private String tid;
	private String buyTime;
	private int reservationTotalNumber;
	private long totalAmount;
	private String reservationStatus;
}
