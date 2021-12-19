package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.TotalInfoViewDto;

public interface TotalInfoViewDao {
	List<TotalInfoViewDto> list();
	//추후에 리스트들을 <where>로 통합.
	TotalInfoViewDto get(int hallNo);
}
