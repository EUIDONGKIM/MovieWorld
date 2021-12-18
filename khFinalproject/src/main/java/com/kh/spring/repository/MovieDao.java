package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.MovieDto;

public interface MovieDao {
	List<MovieDto> list();
}
