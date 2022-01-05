package com.kh.spring.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class MovieChartVO {
	private int movieNo;
	private String movieTitle;
	private String movieGrade;
	private float movieStarpoint;
	private String movieOpening;
	private float movieRatio;
}
