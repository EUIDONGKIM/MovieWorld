package com.kh.spring.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.vo.PaginationActorVO;
import com.kh.spring.vo.PaginationVO;

@Service
public class ActorServiceImpl implements ActorService{
	@Autowired
	private ActorDao actorDao;

	@Override
	public PaginationActorVO serachPage(PaginationActorVO paginationActorVO) throws Exception {
		int count = actorDao.count(paginationActorVO.getActorJob(),paginationActorVO.getActorName());
		paginationActorVO.setCount(count);
		paginationActorVO.calculate();
		List<ActorDto> list = actorDao.search(paginationActorVO.getActorJob(),paginationActorVO.getActorName(),paginationActorVO.getBegin(),paginationActorVO.getEnd());
		paginationActorVO.setList(list);
		
		return paginationActorVO;
	}
	
}
