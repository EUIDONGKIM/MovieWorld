package com.kh.spring.repository.movie;

import java.util.List;

import com.kh.spring.entity.movie.VideoDto;

public interface VideoDao {

	void insert(VideoDto videoDto);

	List<VideoDto> listByMovie(int movieNo);

	boolean delete(int videoNo);

}
