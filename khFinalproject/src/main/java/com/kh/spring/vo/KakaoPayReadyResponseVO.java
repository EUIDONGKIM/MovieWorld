package com.kh.spring.vo;

import lombok.Data;

@Data
public class KakaoPayReadyResponseVO {
	private String tid;
	private String next_redirect_pc_url;
	private String created_at;
}