package com.kh.spring.repository.movie;

import java.util.List;

import com.kh.spring.entity.movie.MovieDto;

public interface MovieDao {
	List<MovieDto> list();

	MovieDto get(int movieNo);

	int getSequence();

	void insert(MovieDto movieDto);
	
	List<MovieDto> listWithoutDuplicate(int theaterNo);

	List<MovieDto> listByOpening();

	List<MovieDto> nowList(List<Integer> movieNoList);

	List<MovieDto> getTitleList(String movieTitle);

	List<Integer> notHaveSchedule();

	void delete(int movieNo);

	void edit(MovieDto movieDto);
	
	List<MovieDto> myMovieLikeList(int memberNo, int startRow, int endRow);

	void refreshStar(int movieNo);

	List<MovieDto> listNotContent();
}
