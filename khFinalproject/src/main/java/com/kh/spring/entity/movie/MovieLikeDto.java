package com.kh.spring.entity.movie;

import java.sql.Date;

import lombok.Data;

@Data
public class MovieLikeDto {

	private int movieNo;
	private int memberNo;
	private Date movieLikeDate;
}
