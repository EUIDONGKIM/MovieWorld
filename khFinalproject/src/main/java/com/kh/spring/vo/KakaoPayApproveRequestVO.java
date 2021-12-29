package com.kh.spring.vo;

import lombok.Data;

@Data
public class KakaoPayApproveRequestVO {
	private String tid;
	private String partner_order_id;
	private String partner_user_id;
	private String pg_token;
}
