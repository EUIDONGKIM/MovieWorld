package com.kh.spring.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class ActorDto {
	private int actorNo;
	private String actorName;
	private String actorEngName;
	private String actorBirth;
	private String actorJob;
	private String actorNationality;
}
