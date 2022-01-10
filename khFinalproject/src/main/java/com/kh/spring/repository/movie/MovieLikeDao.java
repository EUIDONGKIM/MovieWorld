package com.kh.spring.repository.movie;

import java.util.List;

import com.kh.spring.entity.movie.MovieLikeDto;

public interface MovieLikeDao{

	void insert(MovieLikeDto movieLikeDto);
	
	void delete(MovieLikeDto movieLikeDto);
	
	boolean get(int movieNo, int memberNo);
	
	int count(int memberNo);
}
