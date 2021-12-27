package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ActorDto;
import com.kh.spring.entity.RoleDto;

public interface ActorDao {
	List<ActorDto>list();
		
	ActorDto get(int actorNo);

}
