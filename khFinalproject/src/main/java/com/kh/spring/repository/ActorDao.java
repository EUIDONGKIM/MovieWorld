package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ActorDto;

public interface ActorDao {
	List<ActorDto>list();
		
	ActorDto get(int actorNo);
}
