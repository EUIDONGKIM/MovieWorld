package com.kh.spring.entity;

import lombok.Data;

@Data
public class RoleDto {
	private int roleNo;
	private int actorNo;
	private int movieNo;
	private String roleType;
	private String roleName;
}
