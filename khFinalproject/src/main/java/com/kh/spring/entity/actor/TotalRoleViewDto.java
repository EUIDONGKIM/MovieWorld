package com.kh.spring.entity.actor;

import lombok.Data;

@Data
public class TotalRoleViewDto {
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
	private int actorNo;
	private String actorName;
	private String actorEngName;
	private String actorBirth;
	private String actorJob;
	private String actorNationality;
}
