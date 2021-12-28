package com.kh.spring.repository.actor;

import java.util.List;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.RoleDto;

public interface ActorDao {
	List<ActorDto>list();
		
	ActorDto get(int actorNo);

}
