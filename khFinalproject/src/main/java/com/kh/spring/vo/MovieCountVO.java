package com.kh.spring.vo;

import lombok.Data;

@Data
public class MovieCountVO {
	private int movieNo;
	private String movieTitle;
	private String movieGrade;
	private int movieRuntime;
	private int count;
}
