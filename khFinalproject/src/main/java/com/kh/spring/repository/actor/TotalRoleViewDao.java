package com.kh.spring.repository.actor;

import java.util.List;

import com.kh.spring.entity.actor.TotalRoleViewDto;

public interface TotalRoleViewDao {

	List<TotalRoleViewDto> listByJob(int movieNo, String actorJob);

	List<TotalRoleViewDto> listByActorNo(int actorNo);

}
