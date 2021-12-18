package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class MovieDto {
	private int movieNo;
	private String movieNation;
	private String movieGrade;
	private String movieKorName;
	private String movieEngName;
	private String movieRelease;
	private int movieRuntime;
	private float movieRating;
}
