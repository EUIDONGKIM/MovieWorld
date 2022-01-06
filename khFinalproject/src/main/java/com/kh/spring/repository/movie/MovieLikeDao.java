package com.kh.spring.repository.movie;

import com.kh.spring.entity.movie.MovieLikeDto;

public interface MovieLikeDao{

	void insert(MovieLikeDto movieLikeDto);
	
	void delete(MovieLikeDto movieLikeDto);
}
