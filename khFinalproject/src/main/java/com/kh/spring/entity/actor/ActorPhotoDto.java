package com.kh.spring.entity.actor;

import lombok.Data;

@Data
public class ActorPhotoDto {
	private int actorPhotoNo;
	private int actorNo;
	private String actorPhotoUploadName;
	private String actorPhotoSaveName;
	private long actorPhotoSize;
	private String actorPhotoType;
}
