package com.kh.spring.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.PaginationActorVO;
import com.kh.spring.vo.PaginationVO;

public interface ActorService {
	PaginationActorVO serachPage(PaginationActorVO paginationActorVO) throws Exception;

	int insert(ActorDto actorDto, MultipartFile attach) throws IllegalStateException, IOException;

	void edit(ActorDto actorDto, MultipartFile attach) throws IllegalStateException, IOException;

	void delete(int actorNo);

	List<MovieChartVO> getDetailVO(int actorNo);

}
