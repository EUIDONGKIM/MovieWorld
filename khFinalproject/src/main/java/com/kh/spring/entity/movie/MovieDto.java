package com.kh.spring.entity.movie;

import java.sql.Date;

import lombok.Data;

@Data
public class MovieDto {
	private int movieNo;
	private String movieTitle;
	private String movieEngTitle;
	private String movieGrade;
	private String movieType;
	private String movieCountry;
	private String movieOpening;
	private int movieRuntime;
	private float movieStarpoint;
}
