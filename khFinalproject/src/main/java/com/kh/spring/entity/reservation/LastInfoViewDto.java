package com.kh.spring.entity.reservation;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class LastInfoViewDto {
	private int movieNo;
	private String movieTitle;
	private String movieEngTitle;
	private String movieGrade;
	private String movieType;
	private String movieOpening;
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
	private int scheduleTimeCount;
	private int scheduleTimeSum;
	private int hallNo;
	private String hallName;
	private String hallType;
	private int hallSeat;
	
	public String getDateToString() {
		String cut = this.scheduleTimeDateTime;
		String cut1 = cut.substring(0,10);
		String cut2 = cut.substring(11,16);
		
		String go = cut1 + "T" + cut2;
		
		return go;
	}
	public String getStartDateToString() {
		String go = scheduleStart.substring(0,10) + "T" + "00:00";
		
		return go;
	}
	public String getNowDateToString() {
		LocalDateTime now = LocalDateTime.now();

		return now.toString().substring(0,16);
	}
	
	public String getEndDateToString() {
		String go = scheduleEnd.substring(0,10) + "T" + "00:00";
		
		return go;
	}
}
