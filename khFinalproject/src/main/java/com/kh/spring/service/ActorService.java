package com.kh.spring.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.vo.PaginationActorVO;
import com.kh.spring.vo.PaginationVO;

public interface ActorService {
	PaginationActorVO serachPage(PaginationActorVO paginationActorVO) throws Exception;

	int insert(ActorDto actorDto, MultipartFile attach) throws IllegalStateException, IOException;

}
