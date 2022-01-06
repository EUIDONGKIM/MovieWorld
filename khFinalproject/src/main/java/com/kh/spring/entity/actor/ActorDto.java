package com.kh.spring.entity.actor;

import lombok.Data;

@Data  
public class ActorDto {
	private int actorNo;
	private String actorName;
	private String actorEngName;
	private String actorBirth;
	private String actorJob;
	private String actorNationality;
	
	public String getStringBirth() {
		return this.actorBirth.substring(0,10);
	}
}
