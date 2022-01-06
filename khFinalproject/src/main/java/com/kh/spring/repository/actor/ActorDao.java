package com.kh.spring.repository.actor;

import java.util.List;
import java.util.Map;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.RoleDto;

public interface ActorDao {
	List<ActorDto> list();
		
	ActorDto get(int actorNo);
	
//	int getSequence();

	List<ActorDto> listByJob(String actorJob);

	void insert(ActorDto actorDto);

	boolean delete(int actorNo);

	int count(String actorJob, String actorName);

	List<ActorDto> search(String actorJob, String actorName, int begin, int end);

	int getSequence();

	void update(ActorDto actorDto);
}
