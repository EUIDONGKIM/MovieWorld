package com.kh.spring.entity.movie;

import lombok.Data;

@Data
public class VideoDto {
	private int videoNo;
	private int movieNo;
	private String videoTitle;
	private String videoDate;
	private String videoRoot;
}
