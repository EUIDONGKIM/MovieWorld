package com.kh.spring.entity.schedule;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class TotalInfoViewDto {
	private int scheduleNo;
	private int movieNo;
	private int theaterNo;
	private Date scheduleStart;
	private Date scheduleEnd;
	private String movieGrade;
	private String movieTitle;
	private String movieEngTitle;
	private int movieRuntime;
	private String theaterSido;
	private String theaterName;

	public String getStartDateToString() {
		SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
		String date = fmt.format(this.scheduleStart);
		String go = date + "T" + "00:00";
		
		return go;
	}
	public String getNowDateToString() {
		LocalDateTime now = LocalDateTime.now();

		return now.toString().substring(0,16);
	}
	public String getEndDateToString() {
		SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
		String date = fmt.format(this.scheduleEnd);
		String go = date + "T" + "23:59";
		
		return go;
	}
}
