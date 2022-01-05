package com.kh.spring.repository.actor;

import com.kh.spring.entity.actor.RoleDto;

public interface RoleDao {

	void insert(RoleDto roleDto);

	boolean delete(int actorNo);

}
