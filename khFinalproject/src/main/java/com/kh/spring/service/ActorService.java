package com.kh.spring.service;

import java.util.List;
import java.util.Map;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.vo.PaginationActorVO;
import com.kh.spring.vo.PaginationVO;

public interface ActorService {
	PaginationActorVO serachPage(PaginationActorVO paginationActorVO) throws Exception;

}
