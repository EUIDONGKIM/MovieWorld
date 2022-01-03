package com.kh.spring.repository.movie;

import java.util.List;

import com.kh.spring.entity.movie.MovieDto;

public interface MovieDao {
	List<MovieDto> list();

	MovieDto get(int movieNo);

	int getSequence();

	void insert(MovieDto movieDto);

	List<MovieDto> listByOpening();
}
