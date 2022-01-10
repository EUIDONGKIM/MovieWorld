package com.kh.spring.vo;

import lombok.Data;

@Data
public class MyMovieLikeVO {
	private int moviePhotoNo;
	private int movieNo;
	private String movieTitle;
	private String movieEngTitle;
	private String movieGrade;
	private String movieType;
	private String movieCountry;
	private String movieOpening;
	private int movieRuntime;
	private float movieStarpoint;
	private String movieContent;
	
	public String getOpeningDay() {
		return this.movieOpening.substring(0,10);
	}
}
