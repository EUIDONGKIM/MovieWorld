package com.kh.spring.entity.movie;

import lombok.Data;

@Data
public class movieListDto {
	private int movieNo;
	private String movieTitle;
	private String movieGrade;
	private String movieType;
	private String movieOpening;
}
