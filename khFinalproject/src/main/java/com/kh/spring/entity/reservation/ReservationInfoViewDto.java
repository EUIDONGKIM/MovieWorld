package com.kh.spring.entity.reservation;

import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@Data
public class ReservationInfoViewDto {
	private int movieNo;
	private String movieTitle;
	private String movieEngTitle;
	private String movieGrade;
	private int movieRuntime;
	private int scheduleNo;
	private String scheduleStart;
	private String scheduleEnd;
	private int theaterNo;
	private String theaterName;
	private String theaterAddress;
	private String theaterDetailAddress;
	private String theaterSido;
	private int scheduleTimeNo;
	private String scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int hallNo;
	private int scheduleTimeCount;
	private int scheduleTimeSum;
}
