package com.kh.spring.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class MovieChartVO{
	private int movieNo;
	private int moviePhotoNo;
	private String movieTitle;
	private String movieGrade;
	private float movieStarpoint;
	private String movieOpening;
	private float movieRatio;
	private int movieCount;
	private String checkStatus;
}