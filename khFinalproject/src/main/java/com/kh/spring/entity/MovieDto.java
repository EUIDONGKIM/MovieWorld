package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class MovieDto {
	private int movieNo;
	private String movieCountry;
	private String movieGrade;
	private String movietitle;
	private String movieEngTitle;
	private String movieOpen;
	private int movieRuntime;
	private float movieRating;
}
