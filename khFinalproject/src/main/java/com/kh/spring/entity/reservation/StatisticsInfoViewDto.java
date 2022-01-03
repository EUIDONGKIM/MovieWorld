package com.kh.spring.entity.reservation;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class StatisticsInfoViewDto {
	private int memberNo;
	private String memberEmail;
	private String memberGender;
	private String memberBirth;
	private String memberGrade;
	private int memberPoint;
	private String memberJoin;
	private int reservationNo;
	private String tid;
	private int reservationTotalNumber;
	private String reservationStatus;
	private int movieNo;
	private String movieTitle;
	private String movieGrade;
	private String movieType;
	private int scheduleNo;
	private String scheduleStart;
	private String scheduleEnd;
	private int theaterNo;
	private String theaterName;
	private String theaterSido;
	private int scheduleTimeNo;
	private String scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeCount;
	private int scheduleTimeSum;
	private int hallNo;
	private String hallType;
}
