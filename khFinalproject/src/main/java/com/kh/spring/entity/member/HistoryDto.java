package com.kh.spring.entity.member;



import java.sql.Date;

import lombok.Data;
@Data
public class HistoryDto {
	private int historyNo;
	private String memberEmail;
	private Date historyTime;
	private String historyMemo;
	private int historyAmount;
	

}
